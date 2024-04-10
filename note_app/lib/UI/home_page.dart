import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../../cubit/auth/auth_cubit.dart';
import '../../cubit/note/note_cubit.dart';
import '../../models/note_model.dart';

import '../routers/page_const.dart';

class HomePage extends StatefulWidget {
  final String uid;
  const HomePage({super.key, required this.uid});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    context.read<NoteCubit>().getMyNotes(NoteModel(creatorId: widget.uid));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, PageConst.addNote,
                arguments: widget.uid);
          },
          child: Icon(Icons.add),
        ),
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Row(
            children: [
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, PageConst.profilePpage,
                      arguments: widget.uid);
                },
                child: const Icon(Icons.person),
              ),
              SizedBox(
                width: 10.w,
              ),
              Text("My Notes"),
            ],
          ),
          actions: [
            InkWell(
              child: Icon(Icons.logout),
              onTap: () {
                context.read<AuthCubit>().loggedOut();
              },
            ),
            SizedBox(width: 20.w),
            InkWell(
              child: Icon(Icons.refresh),
              onTap: () {
                context
                    .read<NoteCubit>()
                    .getMyNotes(NoteModel(creatorId: widget.uid));
              },
            ),
            SizedBox(width: 10.w)
          ],
        ),
        body: BlocBuilder<NoteCubit, NoteState>(builder: (context, state) {
          if (state is NoteLoaded) {
            final notes = state.notes;
            notes.sort((a, b) => DateTime.fromMillisecondsSinceEpoch(
                    b.createAt!.toInt())
                .compareTo(
                    DateTime.fromMillisecondsSinceEpoch(a.createAt!.toInt())));
            return notes.isEmpty
                ? _addNoteMessageWidget(context)
                : ListView.builder(
                    itemBuilder: ((context, index) {
                      final note = notes[index];
                      return Card(
                        child: ListTile(
                          onTap: () {
                            Navigator.pushNamed(context, PageConst.updateNote,
                                arguments: note);
                          },
                          title: Text("${note.title}"),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text("${note.description}"),
                              SizedBox(height: 10.h),
                              Text(DateFormat("dd MMMM yyyy hh:mm a").format(
                                  DateTime.fromMicrosecondsSinceEpoch(
                                      note.createAt!.toInt()))),
                            ],
                          ),
                          trailing: InkWell(
                            child: Icon(Icons.delete),
                            onTap: () {
                              context
                                  .read<NoteCubit>()
                                  .deleteNote(NoteModel(noteId: note.noteId))
                                  .then((value) => context
                                      .read<NoteCubit>()
                                      .getMyNotes(
                                          NoteModel(creatorId: widget.uid)));
                            },
                          ),
                        ),
                      );
                    }),
                    itemCount: notes.length,
                  );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        }),
      ),
    );
  }

  _addNoteMessageWidget(context) {
    return Center(
        child: Column(
      children: [
        Text(
          "Add Notes",
          style: TextStyle(
              fontSize: 30,
              color: Theme.of(context)
                  .colorScheme
                  .inversePrimary
                  .withOpacity(0.5)),
        )
      ],
      mainAxisAlignment: MainAxisAlignment.center,
    ));
  }
}
