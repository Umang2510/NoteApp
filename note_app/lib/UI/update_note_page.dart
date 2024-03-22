import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import '/UI/widgets/button.dart';
import '/UI/widgets/text_field.dart';

class UpdateNotePage extends StatefulWidget {
  const UpdateNotePage({super.key});

  @override
  State<UpdateNotePage> createState() => _UpdateNotePageState();
}

class _UpdateNotePageState extends State<UpdateNotePage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descreptionController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    _titleController.dispose();
    _descreptionController.dispose();
    super.dispose();
  }

  void _updateNote() {}

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
    ));
  }
}
