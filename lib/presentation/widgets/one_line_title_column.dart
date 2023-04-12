import 'package:flutter/material.dart';
import 'package:journal/utils/identifier.dart';

class OneLineTitleColumn extends StatefulWidget {
  final String titleColumn;
  final List<Identifier> rowsData;
  final double width;
  final double dataRowHeight;
  final Function(String) onTap;

  const OneLineTitleColumn(
      {Key? key,
      required this.titleColumn,
      required this.rowsData,
      required this.width,
      required this.onTap,
      required this.dataRowHeight})
      : super(key: key);

  @override
  State<OneLineTitleColumn> createState() => _OneLineTitleColumnState();
}

class _OneLineTitleColumnState extends State<OneLineTitleColumn> {
  @override
  Widget build(BuildContext context) {
    return DataTable(
      columnSpacing: 0,
      dataRowHeight: widget.dataRowHeight,
      headingRowHeight: 70,
      headingRowColor: MaterialStateProperty.all(Colors.indigo[300]),
      horizontalMargin: 10,
      decoration: const BoxDecoration(
        border: Border(
          right: BorderSide(
            color: Colors.black38,
            width: 1,
          ),
        ),
      ),
      columns: getColumns(widget.titleColumn, widget.width),
      rows: getRows(widget.rowsData, widget.width),
    );
  }

  List<DataColumn> getColumns(String titleColumn, double width) {
    return [
      DataColumn(
          label: Row(children: [
        SizedBox(
            width: width,
            child: Text(titleColumn,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                maxLines: 2)),
        // const SizedBox(
        //   width: 1,
        //   child: VerticalDivider(color: Colors.grey, thickness: 1),
        // )
      ]))
    ];
  }

  List<DataRow> getRows(List<Identifier> rowsData, double width) =>
      List.generate(rowsData.length, (index) {
        return DataRow(cells: [
          DataCell(
              Row(children: [
                SizedBox(
                    width: width,
                    child: Text(rowsData[index].textElement,
                        textAlign: TextAlign.center, maxLines: 4)),
                //
                //   width: 1,
                //   child: VerticalDivider(color: Colors.grey, thickness: 1),
                // )
              ]), onTap: () {
            widget.onTap(rowsData[index].objectId);
          })
        ]);
      });
}
