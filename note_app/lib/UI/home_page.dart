import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../routers/page_const.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
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
                  Navigator.pushNamed(context, PageConst.profilePpage);
                },
                child: const Icon(Icons.person),
              ),
              SizedBox(
                width: 10.w,
              ),
              const Text("My Notes"),
            ],
          ),
          actions: [
            const Icon(Icons.login),
            SizedBox(width: 20.w),
            const Icon(Icons.refresh),
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
