import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:documents/logic/createnote/event.dart';
import 'package:documents/logic/createnote/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateNoteBloc extends Bloc<CreateNoteEvent, CreateNoteState> {
  CreateNoteBloc() : super(CreateNoteInitialState()) {
    on<SubmitNoteEvent>((event, emit) async {
      emit(CreateNoteLoadingState());
      try {
        await FirebaseFirestore.instance
            .collection('notes')
            .add(event.note.toJson());
        emit(CreateNoteLoadedState());
      } catch (e) {
        emit(CreateNoteErrorState(e.toString()));
      }
    });

    on<EditNoteEvent>((event, emit) async {
      emit(CreateNoteLoadingState());
      try {
        await FirebaseFirestore.instance.collection('notes').doc(event.noteid).update(event.updatednote.toJson());
        emit(CreateNoteLoadedState());
      }
      catch (e) {
        emit(CreateNoteErrorState(e.toString()));
      }
    });
  }
}
