import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/data/local/local_database.dart';
import 'package:notes_app/data/model/notes_model.dart';
import 'package:notes_app/utils/colors.dart';

import '../../bloc/notes_bloc/notes_bloc.dart';
import '../../bloc/notes_bloc/notes_event.dart';

class CreateNotes extends StatefulWidget {
  const CreateNotes({super.key});

  @override
  State<CreateNotes> createState() => _CreateNotesState();
}

class _CreateNotesState extends State<CreateNotes> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: IconButton(
                onPressed: () {
                  final _random = Random();
                 Color randomColor = Color.fromRGBO(
                    _random.nextInt(256),
                    _random.nextInt(256),
                    _random.nextInt(256),
                    1,
                  );
                  NotesModel notes = NotesModel(
                    name: titleController.text,
                    createdDate: DateTime.now().toString(),
                    noteColor: randomColor.value,
                    descriptions: descriptionController.text,
                  );
                  LocalDB().insertNote(notes);
                   context.read<NotesBloc>().add(GetNotesEvent());
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.save,
                  color: Colors.white,
                )),
          )
        ],
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
      ),
      backgroundColor: AppColors.primary,
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
            controller: descriptionController,
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
