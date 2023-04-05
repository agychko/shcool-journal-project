import 'package:flutter/material.dart';

import '../../domain/entities/lesson_data.dart';

class CustomLessonListDataTableWidget extends StatefulWidget {
  final List<LessonData> lessonData;
  final Function(LessonData lessonData) editContents;
  final Function(LessonData lessonData) editHomeTask;

  const CustomLessonListDataTableWidget(
      {Key? key,
      required this.lessonData,
      required this.editContents,
      required this.editHomeTask})
      : super(key: key);

  @override
  State<CustomLessonListDataTableWidget> createState() =>
      _CustomLessonListDataTableWidgetState();
}

class _CustomLessonListDataTableWidgetState
    extends State<CustomLessonListDataTableWidget> {
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return DataTable(
      columnSpacing: 0,
      dataRowHeight: 70,
      headingRowHeight: 70,
      headingRowColor: MaterialStateProperty.all(Colors.green[300]),
      horizontalMargin: 10,
      decoration: const BoxDecoration(
        border: Border(
          right: BorderSide(
            color: Colors.grey,
            width: 1.5,
          ),
        ),
      ),
      columns: getColumn(width),
      rows: getRows(widget.lessonData, width),
    );
  }

  List<DataColumn> getColumn(double width) {
    double flex = width - 280;
    return [
      DataColumn(
        label: SizedBox(
            width: flex,
            child: const Text(
              'Contents',
              textAlign: TextAlign.center,
            )),
      ),
      const DataColumn(
          label: VerticalDivider(
        color: Colors.grey,
        thickness: 1,
      )),
      const DataColumn(
        label: SizedBox(
            width: 140, child: Text('Home task', textAlign: TextAlign.center)),
      )
    ];
  }

  List<DataRow> getRows(List<LessonData> lessonData, double width) =>
      List.generate(lessonData.length, (index) {
        double flex = width - 280;
        return DataRow(cells: [
          DataCell(
            SizedBox(
                width: flex,
                child: Text(
                  lessonData[index].contents,
                  maxLines: 4,
                )),
            onTap: () {
                widget.editContents(lessonData[index]);
            },
          ),
          const DataCell(VerticalDivider(
            color: Colors.grey,
            thickness: 1,
          )),
          DataCell(
            SizedBox(
                width: 140,
                child: Text(
                  lessonData[index].homeTask,
                  maxLines: 4,
                )),
            onTap: () {
                widget.editHomeTask(lessonData[index]);
            },
          ),
        ]);
      });
}
