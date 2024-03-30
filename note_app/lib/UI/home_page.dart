import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:note_app/cubit/auth/auth_cubit.dart';

import '../routers/page_const.dart';

class HomePage extends StatelessWidget {
  final String uid;
  const HomePage({super.key, required this.uid});

  @override
  Widget build(BuildContext context) {
    print(uid);
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, PageConst.addNote);
          },
          child: Icon(Icons.add),
        ),
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Row(
            children: [
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, PageConst.profilePpage, arguments: uid);
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
            Icon(Icons.refresh),
            SizedBox(width: 10.w)
          ],
        ),
        body: ListView.builder(
          itemBuilder: ((context, index) {
            return Card(
              child: ListTile(
                onTap: () {
                  Navigator.pushNamed(context, PageConst.updateNote);
                },
                title: Text("Title"),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("Description"),
                    SizedBox(height: 10.h),
                    Text(DateFormat("dd MMMM yyyy hh:mm a")
                        .format(DateTime.now())),
                  ],
                ),
                trailing: Icon(Icons.delete),
              ),
            );
          }),
          itemCount: 10,
        ),
      ),
    );
  }
}
