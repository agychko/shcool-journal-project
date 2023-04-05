import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:journal/presentation/blocs/journal_screen/journal_screen_bloc.dart';
import 'package:journal/presentation/widgets/student_list_datatable_widget.dart';
import 'package:linked_scroll_controller/linked_scroll_controller.dart';
import '../../domain/entities/point.dart';
import '../../domain/entities/user.dart';
import '../widgets/points_datatable_widget.dart';
import '../widgets/edit_point_dialog_widget.dart';

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

  Future editPointValue(Point editPoint, User user) async {
    final pointValue = await showTextDialog(
      context,
      title: '${user.firstName} ${user.lastName} Point',
      value: editPoint.value,
    );
    if (pointValue != null) {
      if (context.mounted) {
        context
            .read<JournalScreenBloc>()
            .add(AddPoint(editPoint, pointValue));
      }
    }
    // setState(() => points = points.map((point) {
    //       final isEditedPoint = point == editPoint;
    //
    //       return isEditedPoint ? point.copy(value: pointValue) : point;
    //     }).toList());
  }

  @override
  void initState() {
    super.initState();
    headerScrollController = controllerGroup.addAndGet();
    dataScrollController = controllerGroup.addAndGet();
    // points = List.of(allPoints);
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
            return SafeArea(
              child: Stack(
                children: [
                  SingleChildScrollView(
                    child: Row(
                      children: [
                        StudentListDataTableWidget(usersList: state.usersData),
                        Expanded(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            controller: dataScrollController,
                            child: PointsDataTableWidget(
                              allLessons: state.lessonData,
                              allUsers: state.usersData,
                              points: state.pointsData,
                              onTap: editPointValue,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      const StudentListDataTableWidget(usersList: []),
                      Expanded(
                        child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            controller: headerScrollController,
                            child: PointsDataTableWidget(
                                allLessons: state.lessonData,
                                allUsers: const [],
                                points: const [],
                                onTap: editPointValue)),
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
