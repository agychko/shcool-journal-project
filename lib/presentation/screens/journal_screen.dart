import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:journal/data/local/points.dart';
import 'package:journal/presentation/bloc/journal_screen_bloc.dart';
import 'package:journal/presentation/widgets/students_list_table_widget.dart';
import 'package:linked_scroll_controller/linked_scroll_controller.dart';
import '../../domain/entities/point.dart';
import '../../domain/entities/user.dart';
import '../widgets/data_points_table_widget.dart';
import '../widgets/text_dialog_widget.dart';

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

  void _incrementCounter() {
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
      body: BlocBuilder<JournalScreenBloc, JournalScreenState>(
        builder: (context, state) {
          if (state is JournalScreenLoading) {
            return const CircularProgressIndicator();
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
            return SafeArea(
              child: Stack(
                children: [
                  SingleChildScrollView(
                    child: Row(
                      children: [
                        StudentListTableWidget(usersList: state.usersData),
                        Expanded(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            controller: dataScrollController,
                            child: DataPointsTableWidget(
                              counter: counter,
                              allUsers: state.usersData,
                              points: points,
                              onTap: editPointValue,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      const StudentListTableWidget(usersList: []),
                      Expanded(
                        child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            controller: headerScrollController,
                            child: DataPointsTableWidget(
                                counter: counter,
                                allUsers: const [],
                                points: const [],
                                onTap: editPointValue)
                            ),
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
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        child: const Icon(Icons.add),
      ),
    );
  }
}
