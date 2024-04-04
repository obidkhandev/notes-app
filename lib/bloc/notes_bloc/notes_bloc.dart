import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/bloc/notes_bloc/notes_event.dart';
import 'package:notes_app/bloc/notes_bloc/notes_state.dart';

import '../../data/local/local_database.dart';
import '../../data/model/notes_model.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  NotesBloc() : super(NotesInitialState()) {
    on<GetNotesEvent>(_getNotes);
    on<DeleteAllNotesEvent>(_deleteAllNotes);
    on<DeleteNotesEvent>(_deleteById);
    on<UpdateNotesEvent>(_updateNote);
    on<SearchNotesEvent>(_searchNote);
  }

  LocalDB localDB = LocalDB();

  Future<void> _getNotes(GetNotesEvent event, Emitter<NotesState> emit) async {
    try {
      final List<NotesModel> notes = await localDB.getAllNotes();
      emit(NotesGetAllState(notes));
    } catch (e) {
      emit(NotesErrorState("Error fetching notes: $e"));
    }
  }

  Future<void> _searchNote(SearchNotesEvent event, Emitter<NotesState> emit) async {
    try {
      final List<NotesModel> notes = await localDB.getAllNotes();
      emit(SearchNotesState(notes));
    } catch (e) {
      emit(NotesErrorState("Error fetching notes: $e"));
    }
  }


  Future<void> _deleteAllNotes(DeleteAllNotesEvent event, Emitter<NotesState> emit) async {
    try {
      await localDB.deleteAllNotes();
      emit(NotesDeleteAllState());
    } catch (e) {
      emit(NotesErrorState("Error deleting notes: $e"));
    }
  }
  Future<void> _deleteById(DeleteNotesEvent event,Emitter<NotesState> emit) async{
    try{
      await LocalDB().deleteNote(event.id);
      emit(NotesDeleteState());
    }catch(e){
      emit(NotesErrorState("Error deleting notes: $e"));
    }
  }
  Future<void> _updateNote(UpdateNotesEvent event,Emitter<NotesState> emit)async{
    try{
      await localDB.updateNote(event.id, event.notesModel);
      emit(NotesUpdateState());
    }catch(e){
      emit(NotesErrorState("Error update $e"));
    }
  }
}
