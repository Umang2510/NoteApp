import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:note_app/cubit/note/note_cubit.dart';
import 'package:note_app/models/note_model.dart';

import 'widgets/common/snackBar.dart';
import '/UI/widgets/button.dart';
import '/UI/widgets/text_field.dart';

class AddNotePage extends StatefulWidget {
  final String uid;
  const AddNotePage({super.key, required this.uid});

  @override
  State<AddNotePage> createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descreptionController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    _titleController.dispose();
    _descreptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Add Note"),
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              CustomTextField(hint: "Title", controller: _titleController),
              SizedBox(height: 15.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  maxLines: 10,
                  controller: _descreptionController,
                  decoration: InputDecoration(
                    hintText: "Description",
                    border: InputBorder.none,
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              CustomButton(
                title: "Add Note",
                onTap: _addNewNote,
              )
            ],
          ),
        ),
      ),
    ));
  }

  void _addNewNote() {
    if (_titleController.text.isEmpty) {
      showSnackBarMessage("Enter title", context);
      return;
    }

    if (_descreptionController.text.isEmpty) {
      showSnackBarMessage("Enter Description", context);
      return;
    }
    context
        .read<NoteCubit>()
        .addNote(NoteModel(
            title: _titleController.text,
            description: _descreptionController.text,
            creatorId: widget.uid))
        .then((value) => _clear());
  }

  void _clear() {
    _titleController.clear();
    _descreptionController.clear();
    showSnackBarMessage("New note added successfully", context);
    //Navigator.pop(context);
    setState(() {});
  }
}
