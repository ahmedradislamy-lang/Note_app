import '../../models/note_model.dart';

abstract class CreateNoteState{}

class CreateNoteInitialState extends CreateNoteState{}

class CreateNoteLoadingState extends CreateNoteState{}

class CreateNoteLoadedState extends CreateNoteState{}

class CreateNoteErrorState extends CreateNoteState{
  final String error;

  CreateNoteErrorState(this.error);
}