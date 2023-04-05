import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  Future editLessonDate(LessonData editLesson) async {
    final newDate = await showDatePicker(
      context: context,
      initialDate: editLesson.dateTime.toLocal(),
      firstDate: DateTime(DateTime.now().year-1, 9, 1),
      lastDate: DateTime.now(),
    );
    if (newDate != null) {

      if (context.mounted) {
        context
            .read<JournalScreenBloc>()
            .add(EditLessonDate(editLesson, newDate));
      }
    }
  }

  Future editLessonContents(LessonData editLesson) async {
    final newLessonContents = await showEditLessonDialog(
      context,
      title: 'Edit Lesson Theme',
      value: editLesson.contents,
    );
    if (newLessonContents != null) {
      if (context.mounted) {
        context
            .read<JournalScreenBloc>()
            .add(EditLessonContents(editLesson, newLessonContents));
      }
    }
  }

  Future editLessonHomeTask(LessonData editLesson) async {
    final newLessonHomeTask = await showEditLessonDialog(
      context,
      title: 'Edit Lesson Home Task',
      value: editLesson.homeTask,
    );
    if (newLessonHomeTask != null) {
      if (context.mounted) {
        context
            .read<JournalScreenBloc>()
            .add(EditLessonHomeTask(editLesson, newLessonHomeTask));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<JournalScreenBloc, JournalScreenState>(
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
          return Scaffold(
            appBar: AppBar(
              title: const Text('Lesson List'),
            ),
            body: SafeArea(
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
                          editContents: editLessonContents,
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
                        editContents: editLessonContents,
                        editHomeTask: editLessonHomeTask,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                context.read<JournalScreenBloc>().add(AddLesson());
              },
              child: const Icon(Icons.add),
            ),
          );
        }
        return const Center(child: Text('Internal Error'));
      },
    );
  }
}
