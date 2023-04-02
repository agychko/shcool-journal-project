import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:journal/data/local/lessons.dart';
import 'package:journal/domain/entities/lesson_data.dart';
import 'package:journal/presentation/widgets/custom_lesson_list_datatable_widget.dart';
import 'package:journal/presentation/widgets/numeric_date_lesson_list_column_widget.dart';

import '../blocs/journal_screen/journal_screen_bloc.dart';
import '../widgets/edit_lesson_dialog_widget.dart';

class LessonListScreen extends StatefulWidget {
  const LessonListScreen({Key? key}) : super(key: key);

  @override
  State<LessonListScreen> createState() => _LessonListScreenState();
}

class _LessonListScreenState extends State<LessonListScreen> {
  int counter = 1;
  late List<LessonData> lessons;

  Future editLessonDate(LessonData editLesson) async {
    final newDate = await showDatePicker(
      context: context,
      initialDate: editLesson.dateTime,
      firstDate: DateTime(2022, 1, 1),
      lastDate: DateTime.now(),
    );
    setState(() =>
    lessons = lessons.map((lesson) {
      final isEditedLesson = lesson == editLesson;
      return isEditedLesson ? lesson.copy(dateTime: newDate) : lesson;
    }).toList());
  }

  Future editLessonTheme(LessonData editLesson) async {
    final lessonTheme = await showEditLessonDialog(
      context,
      title: 'Edit Lesson Theme',
      value: editLesson.contents,
    );

    setState(() =>
    lessons = lessons.map((lesson) {
      final isEditedLesson = lesson == editLesson;
      return isEditedLesson ? lesson.copy(contents: lessonTheme) : lesson;
    }).toList());
  }

  Future editLessonHomeTask(LessonData editLesson) async {
    final lessonHomeTask = await showEditLessonDialog(
      context,
      title: 'Edit Lesson Home Task',
      value: editLesson.homeTask,
    );
    setState(() =>
    lessons = lessons.map((lesson) {
      final isEditedLesson = lesson == editLesson;
      return isEditedLesson ? lesson.copy(homeTask: lessonHomeTask) : lesson;
    }).toList());
  }

  void _incrementCounter() {
    setState(() {
      lessons.add(LessonData(dateTime: DateTime.now(),
          contents: 'Add contents',
          homeTask: 'Add homeTask'));
    });
  }

  @override
  void initState() {
    super.initState();
    lessons = List.of(allLessons);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lesson List'),
      ),
      body: BlocBuilder<JournalScreenBloc, JournalScreenState>(
        builder: (context, state) {
          if (state is JournalScreenLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is JournalScreenError) {
            return Center(
              child: AlertDialog(
                title: const Text('Error'),
                content: Text(state.errorMessage),
              ),
            );
          }
          if (state is JournalScreenSuccess) {
          return SafeArea(
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: Row(
                    children: [
                      NumericDateColumnWidget(
                        lessonData: state.lessonData,
                        onTap: editLessonDate,
                      ),
                      CustomLessonListDataTableWidget(
                        lessonData: state.lessonData,
                        editContents: editLessonTheme,
                        editHomeTask: editLessonHomeTask,
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    NumericDateColumnWidget(
                      lessonData: const [],
                      onTap: editLessonDate,
                    ),
                    CustomLessonListDataTableWidget(
                      lessonData: const [],
                      editContents: editLessonTheme,
                      editHomeTask: editLessonHomeTask,
                    ),
                  ],
                ),
              ],
            ),
          );
          }
          return const Center(child: Text('Internal Error'));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        child: const Icon(Icons.add),
      ),
    );
  }
}
