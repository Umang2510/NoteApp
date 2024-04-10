import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/note/note_cubit.dart';
import '/UI/widgets/button.dart';
import '/UI/widgets/text_field.dart';
import '../models/note_model.dart';
import 'widgets/common/snackBar.dart';

class UpdateNotePage extends StatefulWidget {
  final NoteModel note;
  const UpdateNotePage({super.key, required this.note});

  @override
  State<UpdateNotePage> createState() => _UpdateNotePageState();
}

class _UpdateNotePageState extends State<UpdateNotePage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descreptionController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    _titleController.value = TextEditingValue(text: widget.note.title!);
    _descreptionController.value =
        TextEditingValue(text: widget.note.description!);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _titleController.dispose();
    _descreptionController.dispose();
    super.dispose();
  }

  void _updateNote() {
    if (_titleController.text.isEmpty) {
      showSnackBarMessage("Enter title", context);
      return;
    }

    if (_descreptionController.text.isEmpty) {
      showSnackBarMessage("Enter Description", context);
      return;
    }
    context.read<NoteCubit>().updateNote(NoteModel(
        title: _titleController.text,
        description: _descreptionController.text,
        noteId: widget.note.noteId,
        createAt: DateTime.now().millisecondsSinceEpoch));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Update Note"),
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
                title: "Update Note",
                onTap: _updateNote,
              )
            ],
          ),
        ),
      ),
    ));
  }
}
