import 'package:flutter/material.dart';
import 'package:journal/data/local/users.dart';
import 'package:journal/presentation/widgets/custom_lesson_list_datatable_widget.dart';

import '../widgets/student_list_datatable_widget.dart';

class LessonListScreen extends StatefulWidget {
  const LessonListScreen({Key? key}) : super(key: key);

  @override
  State<LessonListScreen> createState() => _LessonListScreenState();
}

class _LessonListScreenState extends State<LessonListScreen> {

  int counter = 1;

  void _incrementCounter() {
    setState(() {
      counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lesson List'),
      ),
      body: SingleChildScrollView(
        child: Row(
          children: [
             StudentListDataTableWidget(usersList: allUsers),
            Expanded(
              child: CustomLessonListDataTableWidget(
                counter: counter,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        child: const Icon(Icons.add),
      ),
    );
  }
}
