import 'package:flutter/material.dart';
import 'package:journal/domain/entities/lesson_data.dart';

import '../../domain/entities/point.dart';
import '../../domain/entities/user.dart';

class PointsDataTableWidget extends StatefulWidget {
  final List<LessonData> allLessons;
  final List<User> allUsers;
  final List<Point> points;
  final Function(Point, User) onTap;

  const PointsDataTableWidget(
      {super.key,
      required this.allUsers,
      required this.points,
      required this.onTap,
      required this.allLessons});

  @override
  PointsDataTableWidgetState createState() => PointsDataTableWidgetState();
}

class PointsDataTableWidgetState extends State<PointsDataTableWidget> {
  @override
  Widget build(BuildContext context) {
    return DataTable(
      headingRowColor: MaterialStateProperty.all(Colors.green[100]),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey,
            width: 1,
          ),
        ),
      ),
      columnSpacing: 0,
      horizontalMargin: 0,
      dataRowHeight: 30,
      headingRowHeight: 70,
      columns: getColumns(widget.allLessons),
      rows: getRows(widget.allLessons, widget.allUsers, widget.points),
    );
  }

  List<DataColumn> getColumns(List<LessonData> allLessons) => List.generate(
        allLessons.length,
        (index) => DataColumn(
            label: Row(children: [
          SizedBox(
              width: 30,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                      allLessons[index]
                          .dateTime
                          .toLocal()
                          .day
                          .toString()
                          .padLeft(2, '0'),
                      textAlign: TextAlign.center),
                  const Divider(
                    color: Colors.black,
                    thickness: 0.5,
                    indent: 7,
                    endIndent: 7,
                    height: 5,
                  ),
                  Text(
                      allLessons[index]
                          .dateTime
                          .toLocal()
                          .month
                          .toString()
                          .padLeft(2, '0'),
                      textAlign: TextAlign.center),
                ],
              )),
          const SizedBox(
            width: 1,
            child: VerticalDivider(color: Colors.grey, thickness: 1),
          )
        ])),
      );

  List<DataRow> getRows(List<LessonData> allLessons, List<User> allUsers,
          List<Point> points) =>
      List.generate(
        allUsers.length,
        (index) {
          User user = allUsers[index];
          return DataRow(
            cells: List.generate(allLessons.length, (index) {
              LessonData lesson = allLessons[index];
              Point point = points.firstWhere(
                (element) =>
                    element.userId == user.id && element.lessonId == lesson.id,
                orElse: () {
                  Point point = Point(
                      id: '', value: '', lessonId: lesson.id, userId: user.id);
                  points.add(point);
                  return point;
                },
              );
              return DataCell(
                Row(children: [
                  SizedBox(
                      width: 30,
                      child: Text(point.value, textAlign: TextAlign.center)),
                  const SizedBox(
                    width: 1,
                    child: VerticalDivider(color: Colors.grey, thickness: 1),
                  )
                ]),
                // showEditIcon: true,
                // placeholder: true,
                onTap: () {
                  if (point.value=='') {
                    widget.onTap(point, user);
                  }
                },
              );
            }),
          );
        },
      );
}
