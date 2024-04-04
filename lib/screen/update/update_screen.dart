import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/bloc/notes_bloc/notes_bloc.dart';
import 'package:notes_app/bloc/notes_bloc/notes_event.dart';
import 'package:notes_app/data/model/notes_model.dart';
import '../../utils/colors.dart';

class UpdateScreen extends StatefulWidget {
  final NotesModel notesModel;

  const UpdateScreen({super.key, required this.notesModel});

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();

  @override
  void initState() {
    super.initState();
    titleController.text = widget.notesModel.name;
    bodyController.text = widget.notesModel.descriptions;
  }

  @override
  void dispose() {
    titleController.dispose();
    bodyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    content: const Text("Are you sure"),
                    title: const Text("Do you want update"),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Cancel")),
                      TextButton(
                          onPressed: () {
                            context.read<NotesBloc>().add(
                                  UpdateNotesEvent(
                                    widget.notesModel.id!,
                                    widget.notesModel.copyWith(
                                      name: titleController.text,
                                      descriptions: bodyController.text,
                                    ),
                                  ),
                                );
                            context.read<NotesBloc>().add(GetNotesEvent());
                            Navigator.pop(context);
                            Navigator.pop(context);
                          },
                          child: const Text("Save"),
                      )
                    ],
                  );
                },
              );
            },
            icon: const Icon(
              Icons.save,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          TextField(
            style: const TextStyle(fontSize: 32, color: Colors.white),
            controller: titleController,
            maxLines: null,
            decoration: const InputDecoration(
              hintText: "Title",
              hintStyle: TextStyle(fontSize: 32, color: Colors.white),
              border: InputBorder.none,
            ),
          ),
          TextField(
            maxLines: null,
            style: TextStyle(fontSize: 24, color: Colors.white),
            controller: bodyController,
            decoration: const InputDecoration(
              hintText: "Type something...",
              hintStyle: TextStyle(fontSize: 24, color: Colors.white),
              border: InputBorder.none,
            ),
          ),
        ],
      ),
    );
  }
}
