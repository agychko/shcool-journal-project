import 'package:flutter/material.dart';
import 'package:journal/utils/identifier.dart';

class TwoLineTitleColumn extends StatefulWidget {
  final String titleNumerator;
  final String titleDenominator;
  final List<Identifier> rowsData;
  final double width;
  final double dataRowHeight;
  final Function(String) onTap;

  const TwoLineTitleColumn(
      {Key? key,
      required this.titleNumerator,
      required this.titleDenominator,
      required this.rowsData,
      required this.width,
      required this.onTap, required this.dataRowHeight})
      : super(key: key);

  @override
  State<TwoLineTitleColumn> createState() => _TwoLineTitleColumnState();
}

class _TwoLineTitleColumnState extends State<TwoLineTitleColumn> {
  @override
  Widget build(BuildContext context) {
    return DataTable(
      columnSpacing: 0,
      dataRowHeight: widget.dataRowHeight,
      headingRowHeight: 70,
      headingRowColor: MaterialStateProperty.all(Colors.indigo[100]),
      horizontalMargin: 0,
      decoration: const BoxDecoration(
        border: Border(
          right: BorderSide(
            color: Colors.grey,
            width: 1,
          ),
        ),
      ),
      columns: getColumns(
          widget.titleNumerator, widget.titleDenominator, widget.width),
      rows: getRows(widget.rowsData, widget.width),
    );
  }

  List<DataColumn> getColumns(
      String numerator, String denominator, double width) {
    return [
      DataColumn(
          label: Row(children: [
        SizedBox(
            width: width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(numerator, textAlign: TextAlign.center),
                const Divider(
                  color: Colors.black,
                  thickness: 0.5,
                  indent: 7,
                  endIndent: 7,
                  height: 5,
                ),
                Text(denominator, textAlign: TextAlign.center),
              ],
            )),
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
                  child: Text(rowsData[index].textElement, textAlign: TextAlign.center)),
              // const SizedBox(
              //   width: 1,
              //   child: VerticalDivider(color: Colors.grey, thickness: 1),
              // )
            ]),
            onTap: () {
              widget.onTap(rowsData[index].objectId);
            }
          )
        ]);
      });
}
