import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:documents/logic/get_notes/event.dart';
import 'package:documents/logic/get_notes/state.dart';
import 'package:documents/models/note_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NoteBloc extends Bloc<NoteEvent,NoteState>{
  NoteBloc() : super (NoteInitialState()){
    on<LoadNotesEvent> ((event,emit) async{
      emit(NoteLoadingState());
      try{
        final snapshot =await FirebaseFirestore.instance.collection('notes').get();
        final notes =snapshot.docs.map((e) => NoteModel.fromJson(e.data(), e.id)).toList();
        emit(NoteLoadedState(notes));
      }catch(e){
        emit(NoteErrorState(e.toString()));
      }
    });
  }

}