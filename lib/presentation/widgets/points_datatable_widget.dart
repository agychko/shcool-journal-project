import 'package:flutter/material.dart';

import '../../domain/entities/point.dart';
import '../../domain/entities/user.dart';

class PointsDataTableWidget extends StatefulWidget {
  final int counter;
  final List<User> allUsers;
  final List<Point> points;
  final Function(Point, User) onTap;

  const PointsDataTableWidget(
      {super.key,
      required this.counter,
      required this.allUsers,
      required this.points, required this.onTap});

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
      headingRowHeight: 60,
      columns: getColumns(widget.counter),
      rows: getRows(widget.counter, widget.allUsers, widget.points),
    );
  }

  List<DataColumn> getColumns(int counter) => List.generate(
        counter,
        (index) => DataColumn(
            label: Row(children: [
          SizedBox(
              width: 30, child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('0$index', textAlign: TextAlign.center),
                  const Divider(color: Colors.black, thickness: 0.5, indent: 7, endIndent: 7, height: 5,),
                  const Text('03', textAlign: TextAlign.center),
                ],
              )),
          const SizedBox(
            width: 1,
            child: VerticalDivider(color: Colors.grey, thickness: 1),
          )
        ])),
      );

  List<DataRow> getRows(int counter, List<User> allUsers, List<Point> points) =>
      List.generate(
        allUsers.length,
        (index) {
          User user = allUsers[index];
          return DataRow(
            cells: List.generate(counter, (index) {
              Point point = points.firstWhere(
                (element) => element.userId == user.id && element.date == index,
                orElse: () {
                  Point point = Point(value: '', date: index, userId: user.id);
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
                  widget.onTap(point, user);
                },
              );
            }),
          );
        },
      );


}
