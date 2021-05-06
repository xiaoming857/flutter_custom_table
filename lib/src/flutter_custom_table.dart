import 'package:flutter/material.dart';


/// [FlutterCustomTable]
/// A customizable table's column size with flex ratio.
class FlutterCustomTable extends StatelessWidget {
  final List<TableHeaderCell> headers;
  final EdgeInsets margin;
  final List<TableBodyRow> rows;


  FlutterCustomTable({
    Key key,
    @required this.headers,
    this.margin = const EdgeInsets.all(10.0),
    @required this.rows,
  }) : assert(headers != null && headers.isNotEmpty),
        assert(margin != null),
        assert(rows != null && rows.isNotEmpty),
        super(key: key);


  @override
  Widget build(BuildContext context) {
    List<Alignment> alignments = this.headers.map((e) => e.alignment).toList();
    List<double> horizontalPaddings = this.headers.map((e) => e.horizontalPadding).toList();
    List<int> ratios = headers.map((e) => e.ratio).toList();
    return Container(
      margin: this.margin,
      child: Column(
        children: [
          // Header
          Row(children: headers),


          Divider(
            color: Colors.grey,
            height: 0.5,
            thickness: 0.5,
          ),


          // Body
          for (TableBodyRow row in this.rows)
            row._build(
              alignments: alignments,
              horizontalPaddings: horizontalPaddings,
              ratios: ratios,
            ),
        ],
      ),
    );
  }
}




/// [TableHeaderCell]
class TableHeaderCell extends StatelessWidget {
  final Alignment alignment;
  final Widget content;
  final double height;
  final double horizontalPadding;
  final int ratio;
  final double verticalPadding;


  TableHeaderCell({
    Key key,
    this.alignment = Alignment.centerLeft,
    @required this.content,
    this.height,
    this.horizontalPadding = 15.0,
    this.ratio = 1,
    this.verticalPadding = 20.0,
  }) : assert(alignment != null),
        assert(content != null),
        assert(horizontalPadding != null && horizontalPadding >= 0),
        assert(ratio != null && ratio > 0),
        assert(verticalPadding != null && verticalPadding >= 0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: this.ratio,
      child: Container(
        alignment: this.alignment,
        child: this.content,
        height: this.height,
        padding: EdgeInsets.symmetric(horizontal: this.horizontalPadding, vertical: this.verticalPadding),
      ),
    );
  }
}




/// [TableBodyRow]
class TableBodyRow {
  final List<TableBodyCell> cells;
  final double verticalPadding;


  TableBodyRow({
    @required this.cells,
    this.verticalPadding = 20.0,
  }) : assert(cells != null && cells.isNotEmpty);


  _TableBodyRow _build({
    @required List<Alignment> alignments,
    @required List<double> horizontalPaddings,
    @required List<int> ratios,
  }) {
    return _TableBodyRow(
      alignments: alignments,
      cells: this.cells,
      horizontalPaddings: horizontalPaddings,
      ratios: ratios,
      verticalPadding: this.verticalPadding,
    );
  }
}




/// [_TableBodyRow]
class _TableBodyRow extends StatelessWidget {
  final List<Alignment> alignments;
  final List<TableBodyCell> cells;
  final List<double> horizontalPaddings;
  final List<int> ratios;
  final double verticalPadding;

  _TableBodyRow({
    Key key,
    @required this.alignments,
    @required this.cells,
    @required this.horizontalPaddings,
    @required this.ratios,
    this.verticalPadding = 0,
  }) : assert(alignments != null && alignments.isNotEmpty),
        assert(cells != null && cells.isNotEmpty),
        assert(horizontalPaddings != null && horizontalPaddings.isNotEmpty),
        assert(ratios != null),
        assert(verticalPadding != null && verticalPadding >= 0),
        assert(alignments.length == cells.length && horizontalPaddings.length == cells.length && ratios.length == cells.length),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: this.verticalPadding),
        child: Row(
          children: [
            for (int i = 0; i < this.cells.length; i++)
              cells[i]._build(
                alignment: this.alignments[i],
                horizontalPadding: this.horizontalPaddings[i],
                ratio: this.ratios[i],
              ),
          ],
        ),
      ),
    );
  }
}




/// [TableBodyCell]
class TableBodyCell {
  final Widget content;


  TableBodyCell({
    @required this.content,
  }) : assert(content != null);


  _TableBodyCell _build({
    @required Alignment alignment,
    @required double horizontalPadding,
    @required int ratio,
  }) {
    return _TableBodyCell(
      alignment: alignment,
      content: this.content,
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      ratio: ratio,
    );
  }
}




/// [_CustomTableBodyCell]
class _TableBodyCell extends StatelessWidget {
  final Alignment alignment;
  final Widget content;
  final EdgeInsets padding;
  final int ratio;


  _TableBodyCell({
    Key key,
    this.alignment = Alignment.centerLeft,
    @required this.content,
    this.padding = EdgeInsets.zero,
    this.ratio = 1,
  }) : assert(alignment != null),
        assert(content != null),
        assert(padding != null),
        assert(ratio != null && ratio > 0),
        super(key: key);


  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: this.ratio,
      child: Container(
        alignment: this.alignment,
        padding: this.padding,
        child: this.content,
      ),
    );
  }
}