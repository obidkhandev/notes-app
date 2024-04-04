import '../../data/model/notes_model.dart';

abstract class NotesState{}

class NotesInitialState extends NotesState{}

class NotesLoadingState extends NotesState{}

class NotesGetAllState extends NotesState{
  final List<NotesModel> allNotes;
  NotesGetAllState(this.allNotes);
}
class NotesErrorState extends NotesState{
  final String text;
  NotesErrorState(this.text);
}

class NotesDeleteState extends NotesState{}

class NotesDeleteAllState extends NotesState{}

class NotesUpdateState extends NotesState{}
class SearchNotesState extends NotesState{
  final List<NotesModel> allNotes;
  SearchNotesState(this.allNotes);
}

