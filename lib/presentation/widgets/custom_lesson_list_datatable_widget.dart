import 'package:flutter/material.dart';

class CustomLessonListDataTableWidget extends StatefulWidget {
  final int counter;

  const CustomLessonListDataTableWidget(
      {Key? key, required this.counter})
      : super(key: key);

  @override
  State<CustomLessonListDataTableWidget> createState() =>
      _CustomLessonListDataTableWidgetState();
}

class _CustomLessonListDataTableWidgetState
    extends State<CustomLessonListDataTableWidget> {
  @override
  Widget build(BuildContext context) {
    return DataTable(
      columnSpacing: 0,
      dataRowHeight: 30,
      headingRowHeight: 60,
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
      rows: getRows(widget.counter),
    );
  }

  List<DataColumn> getColumns() => const [
        // DataColumn(
        //   label: SizedBox(
        //       width: 20,
        //       child: Text(
        //         'N',
        //         textAlign: TextAlign.center,
        //       )),
        // ),
    // DataColumn(
    //     label: VerticalDivider(
    //       color: Colors.grey,
    //       thickness: 1,
    //     )),
    //     DataColumn(
    //       label: SizedBox(
    //           width: 40,
    //           child: Text(
    //             'Date',
    //             textAlign: TextAlign.center,
    //           )),
    //     ),
    // DataColumn(
    //     label: VerticalDivider(
    //       color: Colors.grey,
    //       thickness: 1,
    //     )),
        DataColumn(
          label: SizedBox(
              width: 200,
              child: Text(
                'Contents',
                textAlign: TextAlign.center,
              )),
        ),
    DataColumn(
        label: VerticalDivider(
          color: Colors.grey,
          thickness: 1,
        )),
        DataColumn(
          label: SizedBox(
              width: 100,
              child: Text(
                'Home Task',
                textAlign: TextAlign.center,
              )),
        ),
      ];

  List<DataRow> getRows(int counter) =>
      List.generate(counter, (index) {
        // int number = index + 1;
        return const DataRow(cells: [
          // DataCell(Text('$number.')),
          // const DataCell(VerticalDivider(
          //   color: Colors.grey,
          //   thickness: 1,
          // )),
          // const DataCell(Text('')),
          // const DataCell(VerticalDivider(
          //   color: Colors.grey,
          //   thickness: 1,
          // )),
           DataCell(Text('')),
           DataCell(VerticalDivider(
            color: Colors.grey,
            thickness: 1,
          )),
           DataCell(Text('')),
        ]);
      });
}
