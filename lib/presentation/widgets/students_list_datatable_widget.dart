import 'package:flutter/material.dart';
import 'package:journal/domain/entities/user.dart';

class StudentListDataTableWidget extends StatefulWidget {
  final List<User> usersList;

  const StudentListDataTableWidget({super.key, required this.usersList});

  @override
  StudentListDataTableWidgetState createState() => StudentListDataTableWidgetState();
}

class StudentListDataTableWidgetState extends State<StudentListDataTableWidget> {
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
      rows: getRows(widget.usersList),
    );
  }

  List<DataColumn> getColumns() => const [
        DataColumn(
          label: SizedBox(width: 20, child: Text('N')),
        ),
        DataColumn(
            label: VerticalDivider(
          color: Colors.grey,
          thickness: 1,
        )),
        DataColumn(
          label: SizedBox(width: 140, child: Text('Name students')),
        )
      ];

  List<DataRow> getRows(List<User> usersData) =>
      List.generate(usersData.length, (index) {
        int number = index + 1;
        return DataRow(cells: [
          DataCell(Text('$number.')),
          const DataCell(VerticalDivider(
            color: Colors.grey,
            thickness: 1,
          )),
          DataCell(Text(
              '${usersData[index].lastName} ${usersData[index].firstName}'))
        ]);
      });
}
