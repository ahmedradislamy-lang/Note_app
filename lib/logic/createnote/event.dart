import 'package:documents/models/note_model.dart';

abstract class CreateNoteEvent{
  const CreateNoteEvent();
}

class SubmitNoteEvent extends CreateNoteEvent{
  final NoteModel note;

  SubmitNoteEvent(this.note);

}

class EditNoteEvent extends CreateNoteEvent{
  final String noteid;
  final NoteModel updatednote;

  EditNoteEvent({required this.noteid, required this.updatednote});

}