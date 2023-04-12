import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:journal/presentation/blocs/journal_screen/journal_screen_bloc.dart';
import 'package:journal/presentation/widgets/one_line_title_column.dart';
import 'package:journal/presentation/widgets/two_line_title_column.dart';
import 'package:journal/utils/identifier.dart';

import 'package:linked_scroll_controller/linked_scroll_controller.dart';
import '../../domain/entities/point.dart';
import '../../domain/entities/user.dart';
import '../widgets/text_dialog_widget.dart';

class JournalScreen extends StatefulWidget {
  const JournalScreen({super.key, required this.title});

  final String title;

  @override
  State<JournalScreen> createState() => _JournalScreenState();
}

class _JournalScreenState extends State<JournalScreen> {

  LinkedScrollControllerGroup controllerGroup = LinkedScrollControllerGroup();
  ScrollController headerScrollController = ScrollController();
  ScrollController dataScrollController = ScrollController();

  Future editPointValue(String id) async {
    Point editPoint = context
        .read<JournalScreenBloc>()
        .points
        .firstWhere((element) => element.id == id);
    User editUser = context
        .read<JournalScreenBloc>()
        .users
        .firstWhere((element) => element.id == editPoint.userId);
    if (editPoint.value == '') {
      final pointValue = await showTextDialog(
        context,
        title: '${editUser.firstName} ${editUser.lastName} Point',
        value: editPoint.value,
        validator: (value) {
          if (value != '1' &&
              value != '2' &&
              value != '3' &&
              value != '4' &&
              value != '5' &&
              value != '6' &&
              value != '7' &&
              value != '8' &&
              value != '9' &&
              value != '10' &&
              value != '11' &&
              value != '12') {
            return 'Please enter the correct points';
          }
          return null;
        },
      );
      if (pointValue != null) {
        if (context.mounted) {
          context
              .read<JournalScreenBloc>()
              .add(AddPoint(editPoint, pointValue));
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();
    headerScrollController = controllerGroup.addAndGet();
    dataScrollController = controllerGroup.addAndGet();
  }

  @override
  void dispose() {
    super.dispose();
    headerScrollController.dispose();
    dataScrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text(widget.title),
          ],
        ),
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
            Future.delayed(Duration.zero, () {
              controllerGroup.animateTo(
                  headerScrollController.position.maxScrollExtent,
                  curve: Curves.linear,
                  duration: const Duration(milliseconds: 500));
            });
            return SafeArea(
              child: Stack(
                children: [
                  SingleChildScrollView(
                    child: Row(
                      children: [
                        OneLineTitleColumn(
                            titleColumn: 'N o/l',
                            rowsData: List.generate(
                                state.usersData.length,
                                (index) => Identifier(state.usersData[index].id,
                                    '${index + 1}.')),
                            width: 20,
                            dataRowHeight: 30,
                            onTap: (onTap) => null),
                        OneLineTitleColumn(
                            titleColumn: 'Name and Surname students',
                            rowsData: state.usersData
                                .map((e) => Identifier(
                                    e.id, '${e.lastName} ${e.firstName}'))
                                .toList(),
                            width: 140,
                            dataRowHeight: 30,
                            onTap: (onTap) => null),
                        Expanded(
                          child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              controller: dataScrollController,
                              child: Row(
                                  children: state.lessonData
                                      .map((lesson) => TwoLineTitleColumn(
                                          titleNumerator: lesson.dateTime
                                              .toLocal()
                                              .day
                                              .toString()
                                              .padLeft(2, '0'),
                                          titleDenominator: lesson.dateTime
                                              .toLocal()
                                              .month
                                              .toString()
                                              .padLeft(2, '0'),
                                          rowsData: List.generate(
                                              state.usersData.length, (index) {
                                            User user = state.usersData[index];
                                            Point point = state.pointsData
                                                .firstWhere(
                                                    (element) =>
                                                        element.lessonId ==
                                                            lesson.id &&
                                                        element.userId ==
                                                            user.id,
                                                    orElse: () {
                                              Point localPoint = Point(
                                                  id: '${lesson.id}${user.id}',
                                                  value: '',
                                                  lessonId: lesson.id,
                                                  userId: user.id);
                                              state.pointsData.add(localPoint);
                                              return localPoint;
                                            });
                                            return Identifier(
                                                point.id, point.value);
                                          }),
                                          width: 30,
                                          onTap: editPointValue,
                                          dataRowHeight: 30))
                                      .toList())),
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
                          onTap: (onTap) => null,
                          dataRowHeight: 30),
                      OneLineTitleColumn(
                          titleColumn: 'Name and Surname students',
                          rowsData: const [],
                          width: 140,
                          dataRowHeight: 30,
                          onTap: (onTap) => null),
                      Expanded(
                        child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            controller: headerScrollController,
                            child: Row(
                                children: state.lessonData
                                    .map((lesson) => TwoLineTitleColumn(
                                        titleNumerator: lesson.dateTime
                                            .toLocal()
                                            .day
                                            .toString()
                                            .padLeft(2, '0'),
                                        titleDenominator: lesson.dateTime
                                            .toLocal()
                                            .month
                                            .toString()
                                            .padLeft(2, '0'),
                                        rowsData: const [],
                                        width: 30,
                                        onTap: editPointValue,
                                        dataRowHeight: 30))
                                    .toList())),
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
    );
  }
}
