import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/bloc/notes_bloc/notes_bloc.dart';
import 'package:notes_app/bloc/notes_bloc/notes_event.dart';
import 'package:notes_app/bloc/notes_bloc/notes_state.dart';
import 'package:notes_app/screen/search_screen/search_screen.dart';
import 'package:notes_app/screen/update/update_screen.dart';
import 'package:notes_app/utils/route_name.dart';
import '../../utils/colors.dart';

List<String> searchList = [];

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.primary,
        title: Text(
          "Notes",
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
        actions: [
          BlocListener<NotesBloc, NotesState>(
            listener: (BuildContext context, state) {
              if (state is SearchNotesState) {
                searchList = [];
                for (int i = 0; i < state.allNotes.length; i++) {
                  searchList.add(state.allNotes[i].name);
                }
              }
            },
            child: IconButton(
              onPressed: () async {
                showSearch(
                  context: context,
                  delegate: MyCustomSearchDelegate(),
                );
                context.read<NotesBloc>().add(SearchNotesEvent());
              },
              icon: Icon(
                Icons.search,
                color: Colors.white,
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    content: Text("Are you sure"),
                    title: Text("Do you want delete all"),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("Cancel")),
                      TextButton(
                          onPressed: () {
                            context
                                .read<NotesBloc>()
                                .add(DeleteAllNotesEvent());
                            Navigator.pop(context);
                          },
                          child: Text("Ok"))
                    ],
                  );
                },
              );
            },
            icon: Icon(
              Icons.delete,
              color: Colors.red,
            ),
          ),
        ],
      ),
      backgroundColor: const Color(0xff252525),
      floatingActionButton: Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            offset: Offset(3, 0),
            color: Colors.white.withOpacity(0.5),
            blurRadius: 10,
          )
        ]),
        child: FloatingActionButton(
          backgroundColor: Color(0xff252527),
          onPressed: () {
            Navigator.pushNamed(context, RouteName.create);
          },
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
      body: BlocBuilder<NotesBloc, NotesState>(
        builder: (BuildContext context, state) {
          if (state is NotesInitialState) {
            Center(
              child: Text(
                "Note updated successfully",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            );
            context.read<NotesBloc>().add(GetNotesEvent());
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is NotesGetAllState) {

            return
              state.allNotes.isEmpty? Center(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: const DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage("[removal.ai]_c2baa865-2dd2-46fd-9ecc-09b35e9ad37a-photo_2024-04-04_15-30-46.png"),
                    ),
                  ),
                ),
              ):
              ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 20),
              itemCount: state.allNotes.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    context.read<NotesBloc>().add(
                          UpdateNotesEvent(
                            state.allNotes[index].id!,
                            state.allNotes[index],
                          ),
                        );
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => UpdateScreen(
                          notesModel: state.allNotes[index],
                        ),
                      ),
                    );
                  },
                  child: Dismissible(
                    confirmDismiss: (direction) {
                      return showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            content: Text("Are you sure"),
                            title: Text("Do you want to delete"),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text("Cancel")),
                              TextButton(
                                  onPressed: () {
                                    context.read<NotesBloc>().add(
                                        DeleteNotesEvent(
                                            state.allNotes[index].id!,
                                        ),
                                    );
                                    context.read<NotesBloc>().add(
                                      GetNotesEvent(),
                                    );
                                    Navigator.pop(context);
                                  },
                                  child: Text("Ok"))
                            ],
                          );
                        },
                      );
                    },
                    background: Container(
                      margin: EdgeInsets.only(bottom: 15),
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    ),
                    key: Key(state.allNotes[index].id.toString(),),
                    onDismissed: (direction) {},
                    child: Container(
                      margin: EdgeInsets.only(bottom: 15),
                      height: 100,
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 10),
                      decoration: BoxDecoration(
                        color: Color(0xff + state.allNotes[index].noteColor),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            state.allNotes[index].name,
                            style: TextStyle(color: Colors.black, fontSize: 20),
                          ),
                          Text(
                            state.allNotes[index].descriptions,
                            style: TextStyle(color: Colors.black, fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else if (state is NotesErrorState) {
            return Text(state.text);
          } else if (state is NotesDeleteAllState) {
            return Center(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: const DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage("[removal.ai]_c2baa865-2dd2-46fd-9ecc-09b35e9ad37a-photo_2024-04-04_15-30-46.png"),
                  ),
                ),
              ),
            );
          } else if (state is NotesUpdateState) {
            context.read<NotesBloc>().add(GetNotesEvent());
            return Center(
              child: Text(
                "Note updated successfully",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            );
          } else if (state is NotesLoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return Center(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: const DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage("[removal.ai]_c2baa865-2dd2-46fd-9ecc-09b35e9ad37a-photo_2024-04-04_15-30-46.png"),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
