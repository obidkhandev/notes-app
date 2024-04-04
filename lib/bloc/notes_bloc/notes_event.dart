import 'package:notes_app/data/model/notes_model.dart';

abstract class NotesEvent{}
class GetNotesEvent extends NotesEvent{}
class DeleteNotesEvent extends NotesEvent{
  final int id;
  DeleteNotesEvent(this.id);
}
class UpdateNotesEvent extends NotesEvent{
  final int id;
  final NotesModel notesModel;
  UpdateNotesEvent(this.id,this.notesModel);
}
class DeleteAllNotesEvent extends NotesEvent{}
class SearchNotesEvent extends NotesEvent{}