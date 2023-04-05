import 'package:flutter/material.dart';
import 'package:journal/domain/entities/lesson_data.dart';

class NumericDateColumnWidget extends StatefulWidget {
  final List<LessonData> lessonData;
  final Function(LessonData lessonData) onTap;

  const NumericDateColumnWidget(
      {Key? key, required this.lessonData, required this.onTap})
      : super(key: key);

  @override
  State<NumericDateColumnWidget> createState() =>
      _NumericDateColumnWidgetState();
}

class _NumericDateColumnWidgetState extends State<NumericDateColumnWidget> {
  @override
  Widget build(BuildContext context) {
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
      columns: getColumns(),
      rows: getRows(widget.lessonData),
    );
  }

  List<DataColumn> getColumns() => [
        DataColumn(
          label: SizedBox(
              width: 20,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text('№', textAlign: TextAlign.center),
                  Text('o/l', textAlign: TextAlign.center)
                ],
              )),
        ),
        const DataColumn(
            label: VerticalDivider(
          color: Colors.grey,
          thickness: 1,
        )),
        const DataColumn(
          label: SizedBox(
              width: 45,
              child: Text(
                'Date',
                textAlign: TextAlign.center,
              )),
        )
      ];

  List<DataRow> getRows(List<LessonData> lessonData) =>
      List.generate(lessonData.length, (index) {
        int number = index + 1;
        return DataRow(cells: [
          DataCell(Text('$number.')),
          const DataCell(VerticalDivider(
            color: Colors.grey,
            thickness: 1,
          )),
          DataCell(
            SizedBox(
              width: 45,
              child: Text(
                  '${lessonData[index].dateTime.toLocal().day.toString().padLeft(2, '0')} / '
                  '${lessonData[index].dateTime.toLocal().month.toString().padLeft(2, '0')}',
                  textAlign: TextAlign.center),
            ),
            onTap: () {
                widget.onTap(lessonData[index]);
            },
          )
        ]);
      });
}
