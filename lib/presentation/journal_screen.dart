import 'package:flutter/material.dart';
import 'package:journal/data/local/points.dart';
import 'package:journal/data/local/users.dart';
import 'package:journal/presentation/text_dialog_widget.dart';
import 'package:linked_scroll_controller/linked_scroll_controller.dart';
import '../domain/entities/point.dart';
import '../domain/entities/user.dart';

class JournalScreen extends StatefulWidget {
  const JournalScreen({super.key, required this.title});

  final String title;

  @override
  State<JournalScreen> createState() => _JournalScreenState();
}

class _JournalScreenState extends State<JournalScreen> {
  int counter = 1;

  LinkedScrollControllerGroup controllerGroup = LinkedScrollControllerGroup();
  late ScrollController headerScrollController;
  late ScrollController dataScrollController;
  late List<Point> points;
  // late List<ApiUser> allUsers;

  void _incrementCounter()  {
    setState(() {
      counter++;
    });
  }

  Future editPointValue(Point editPoint, User user) async {
    final pointValue = await showTextDialog(
      context,
      title: '${user.firstName} ${user.lastName} Point',
      value: editPoint.value,
    );

    setState(() => points = points.map((point) {
      final isEditedPoint = point == editPoint;

      return isEditedPoint ? point.copy(value: pointValue) : point;
    }).toList());
  }

  @override
  void initState() {
    super.initState();
    headerScrollController = controllerGroup.addAndGet();
    dataScrollController = controllerGroup.addAndGet();
    points = List.of(allPoints);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Row(
                children: [
                  DataTable(
                    columnSpacing: 0,
                    dataRowHeight: 30,
                    headingRowHeight: 60,
                    headingRowColor:
                        MaterialStateProperty.all(Colors.green[300]),
                    horizontalMargin: 10,
                    decoration: const BoxDecoration(
                      border: Border(
                        right: BorderSide(
                          color: Colors.grey,
                          width: 1.5,
                        ),
                      ),
                    ),
                    columns: const [
                      DataColumn(
                        label: SizedBox(width: 20, child: Text('N')),
                      ),
                      DataColumn(
                          label: VerticalDivider(
                        color: Colors.grey,
                        thickness: 1,
                      )),
                      DataColumn(
                        label:
                            SizedBox(width: 140, child: Text('Name students')),
                      )
                    ],
                    rows: List.generate(allUsers.length, (index) {
                      int number = index + 1;
                      return DataRow(cells: [
                        DataCell(Text('$number.')),
                        const DataCell(VerticalDivider(
                          color: Colors.grey,
                          thickness: 1,
                        )),
                        DataCell(Text(
                            '${allUsers[index].lastName} ${allUsers[index].firstName}'))
                      ]);
                    }),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      controller: dataScrollController,
                      child: DataTable(
                        headingRowColor:
                            MaterialStateProperty.all(Colors.green[100]),
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
                        columns: List.generate(
                          counter,
                          (index) => DataColumn(
                              label: Row(children: [
                            SizedBox(
                                width: 30,
                                child: Text('$index',
                                    textAlign: TextAlign.center)),
                            const SizedBox(
                              width: 1,
                              child: VerticalDivider(
                                  color: Colors.grey, thickness: 1),
                            )
                          ])),
                        ),
                        rows: List.generate(
                          allUsers.length,
                          (index) {
                            User user = allUsers[index];
                            return DataRow(
                              cells: List.generate(counter, (index) {
                                // int random = Random().nextInt(13);
                                Point point = points
                                    .firstWhere((element) =>
                                        element.userId == user.id &&
                                        element.date == index,
                                orElse: () {
                                  Point point = Point(value: '', date: index, userId: user.id);
                                  points.add(point);
                                  return point;
    },
                                );
                                // String value = point.value==0 ? '' : point.value.toString();
                                // (random < 5) ? '' : random.toString();
                                return DataCell(
                                  Row(children: [
                                    SizedBox(
                                        width: 30,
                                        child: Text(point.value,
                                            textAlign: TextAlign.center)),
                                    const SizedBox(
                                      width: 1,
                                      child: VerticalDivider(
                                          color: Colors.grey, thickness: 1),
                                    )
                                  ]),
                                  // showEditIcon: true,
                                  // placeholder: true,
                                  onTap: () {
                                    editPointValue(point, user);
                                  },
                                );
                              }),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                DataTable(
                    columnSpacing: 0,
                    dataRowHeight: 30,
                    headingRowHeight: 60,
                    headingRowColor:
                        MaterialStateProperty.all(Colors.green[300]),
                    horizontalMargin: 10,
                    decoration: const BoxDecoration(
                      border: Border(
                        right: BorderSide(
                          color: Colors.grey,
                          width: 1.5,
                        ),
                      ),
                    ),
                    columns: const [
                      DataColumn(
                        label: SizedBox(width: 20, child: Text('N')),
                      ),
                      DataColumn(
                          label: VerticalDivider(
                        color: Colors.grey,
                        thickness: 1,
                      )),
                      DataColumn(
                        label:
                            SizedBox(width: 140, child: Text('Name students')),
                      )
                    ],
                    rows: const []),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    controller: headerScrollController,
                    child: DataTable(
                      headingRowColor:
                          MaterialStateProperty.all(Colors.green[100]),
                      columnSpacing: 0,
                      horizontalMargin: 0,
                      dataRowHeight: 30,
                      headingRowHeight: 60,
                      columns: List.generate(
                        counter,
                        (index) => DataColumn(
                            label: Row(children: [
                          SizedBox(
                              width: 30,
                              child:
                                  Text('$index', textAlign: TextAlign.center)),
                          const SizedBox(
                            width: 1,
                            child: VerticalDivider(
                                color: Colors.grey, thickness: 1),
                          )
                        ])),
                      ),
                      rows: const [],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        child: const Icon(Icons.add),
      ),
    );
  }
}
