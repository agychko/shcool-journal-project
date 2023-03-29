import 'package:flutter/material.dart';

class LessonListScreen extends StatefulWidget {
  const LessonListScreen({Key? key}) : super(key: key);

  @override
  State<LessonListScreen> createState() => _LessonListScreenState();
}

class _LessonListScreenState extends State<LessonListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Lesson List'),
        ),
        body: SingleChildScrollView(
          child: DataTable(
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
            rows: const [],
          ),
        ),
    );
  }
}

List<DataColumn> getColumns() => const [
  DataColumn(
    label: SizedBox(width: 20, child: Text('N', textAlign: TextAlign.center)),
  ),
  DataColumn(
      label: VerticalDivider(
        color: Colors.grey,
        thickness: 1,
      )),
  DataColumn(
    label: SizedBox(width: 40, child: Text('Date', textAlign: TextAlign.center)),
  ),
  DataColumn(
      label: VerticalDivider(
        color: Colors.grey,
        thickness: 1,
      )),
  DataColumn(
    label: SizedBox(child: Text('Contents', textAlign: TextAlign.center)),
  ),
  DataColumn(
      label: VerticalDivider(
        color: Colors.grey,
        thickness: 1,
      )),
  DataColumn(
    label: SizedBox(width: 100, child: Text('Home task', textAlign: TextAlign.center)),
  )
];

// List<DataRow> getRows(List<User> usersData) =>
//     List.generate(usersData.length, (index) {
//       int number = index + 1;
//       return DataRow(cells: [
//         DataCell(Text('$number.')),
//         const DataCell(VerticalDivider(
//           color: Colors.grey,
//           thickness: 1,
//         )),
//         DataCell(Text(
//             '${usersData[index].lastName} ${usersData[index].firstName}'))
//       ]);
//     });
