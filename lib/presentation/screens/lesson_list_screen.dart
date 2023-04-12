import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:journal/presentation/widgets/one_line_title_column.dart';
import 'package:journal/presentation/widgets/text_dialog_widget.dart';
import 'package:journal/utils/identifier.dart';

import '../blocs/journal_screen/journal_screen_bloc.dart';

class LessonListScreen extends StatefulWidget {
  const LessonListScreen({Key? key}) : super(key: key);

  @override
  State<LessonListScreen> createState() => _LessonListScreenState();
}

class _LessonListScreenState extends State<LessonListScreen> {
  ScrollController lessonController = ScrollController();

  Future editLessonDate(String id) async {
    var editLesson = context
        .read<JournalScreenBloc>()
        .lessons
        .firstWhere((element) => element.id == id);
    final newDate = await showDatePicker(
      context: context,
      initialDate: editLesson.dateTime.toLocal(),
      firstDate: DateTime(DateTime.now().year - 1, 9, 1),
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

  Future editLessonContents(String id) async {
    var editLesson = context
        .read<JournalScreenBloc>()
        .lessons
        .firstWhere((element) => element.id == id);
    final newLessonContents = await showTextDialog(
      context,
      title: 'Edit Lesson Theme',
      value: editLesson.contents,
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return 'Please enter some text';
        }
        return null;
      },
    );
    if (newLessonContents != null) {
      if (context.mounted) {
        context
            .read<JournalScreenBloc>()
            .add(EditLessonContents(editLesson, newLessonContents));
      }
    }
  }

  Future editLessonHomeTask(String id) async {
    var editLesson = context
        .read<JournalScreenBloc>()
        .lessons
        .firstWhere((element) => element.id == id);
    final newLessonHomeTask = await showTextDialog(
      context,
      title: 'Edit Lesson Home Task',
      value: editLesson.homeTask,
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return 'Please enter some text';
        }
        return null;
      },
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
          Future.delayed(Duration.zero, () {
            lessonController.animateTo(
                lessonController.position.maxScrollExtent,
                duration: const Duration(milliseconds: 500),
                curve: Curves.linear
            );
          });
          return Scaffold(
            appBar: AppBar(
              title: const Text('Lesson List'),
            ),
            body: SafeArea(
              child: Stack(
                children: [
                  SingleChildScrollView(
                    controller: lessonController,
                    child: Row(
                      children: [
                        OneLineTitleColumn(
                          titleColumn: 'N o/l',
                          rowsData: List.generate(
                              state.lessonData.length,
                              (index) => Identifier(
                                  state.lessonData[index].id, '${index + 1}.')),
                          width: 20,
                          dataRowHeight: 70,
                          onTap: (onTap) => null,
                        ),
                        OneLineTitleColumn(
                          titleColumn: 'Date',
                          rowsData: List.generate(
                              state.lessonData.length,
                              (index) => Identifier(
                                  state.lessonData[index].id,
                                  '${state.lessonData[index].dateTime.toLocal().day.toString().padLeft(2, '0')} / '
                                  '${state.lessonData[index].dateTime.toLocal().month.toString().padLeft(2, '0')}')),
                          width: 45,
                          dataRowHeight: 70,
                          onTap: editLessonDate,
                        ),
                        OneLineTitleColumn(
                          titleColumn: 'Contents',
                          rowsData: state.lessonData
                              .map((e) => Identifier(e.id, e.contents))
                              .toList(),
                          width: MediaQuery.of(context).size.width - 289,
                          dataRowHeight: 70,
                          onTap: editLessonContents,
                        ),
                        OneLineTitleColumn(
                          titleColumn: 'Home Task',
                          rowsData: state.lessonData
                              .map((e) => Identifier(e.id, e.homeTask))
                              .toList(),
                          width: 140,
                          dataRowHeight: 70,
                          onTap: editLessonHomeTask,
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      OneLineTitleColumn(
                          titleColumn: 'N o/l',
                          rowsData: const [],
                          width: 20,
                          dataRowHeight: 70,
                          onTap: (onTap) => null),
                      OneLineTitleColumn(
                          titleColumn: 'Date',
                          rowsData: const [],
                          width: 45,
                          dataRowHeight: 70,
                          onTap: (onTap) => null),
                      OneLineTitleColumn(
                          titleColumn: 'Contents',
                          rowsData: const [],
                          width: MediaQuery.of(context).size.width - 289,
                          dataRowHeight: 70,
                          onTap: (onTap) => null),
                      OneLineTitleColumn(
                          titleColumn: 'Home Task',
                          rowsData: const [],
                          width: 140,
                          dataRowHeight: 70,
                          onTap: (onTap) => null),
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
