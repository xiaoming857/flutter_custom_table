import 'package:flutter/material.dart';


enum VerticalAlignment {
  top,
  middle,
  bottom,
}


enum HorizontalAlignment {
  left,
  center,
  right,
}


/// [FlutterCustomTable]
/// A customizable table's column size with flex ratio.
class FlutterCustomTable extends StatelessWidget {
  final List<TableHeaderCell> headers;
  final Color headersColor;
  final double headersHeight;
  final VerticalAlignment headersVerticalAlignment;
  final EdgeInsets margin;
  final List<TableBodyRow> rows;


  FlutterCustomTable({
    @required this.headers,
    this.headersColor = Colors.transparent,
    this.headersHeight = 40.0,
    this.headersVerticalAlignment = VerticalAlignment.middle,
    Key key,
    this.margin = const EdgeInsets.all(10.0),
    @required this.rows,
  }) : assert(headers != null && headers.isNotEmpty),
        assert(headersColor != null),
        assert(headersVerticalAlignment != null),
        assert(margin != null),
        assert(rows != null && rows.isNotEmpty),
        super(key: key);


  @override
  Widget build(BuildContext context) {
    List<Alignment> alignments = this.headers.map((e) {
      Alignment alignment;
      switch (e.horizontalAlignment) {
        case HorizontalAlignment.left:
          alignment = Alignment.centerLeft;
          break;
        case HorizontalAlignment.center:
          alignment = Alignment.center;
          break;
        case HorizontalAlignment.right:
          alignment = Alignment.centerRight;
          break;
      }
      return alignment;
    }).toList();
    List<double> horizontalPaddings = this.headers.map((e) => e.horizontalPadding).toList();
    List<int> ratios = headers.map((e) => e.ratio).toList();
    print(alignments);
    return Container(
      margin: this.margin,
      child: Column(
        children: [
          // Header
          Container(
            color: this.headersColor,
            height: this.headersHeight,
            child: Row(
              children: [
                for (TableHeaderCell header in this.headers)
                  header._build(headersVerticalAlignment: headersVerticalAlignment),
              ],
            ),
          ),


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
class TableHeaderCell {
  final Widget content;
  final HorizontalAlignment horizontalAlignment;
  final double horizontalPadding;
  final Key key;
  final int ratio;

  TableHeaderCell({
    @required this.content,
    this.horizontalAlignment = HorizontalAlignment.left,
    this.horizontalPadding = 15.0,
    this.key,
    this.ratio = 1,
  }) :assert(content != null),
        assert(horizontalAlignment != null),
        assert(horizontalPadding != null && horizontalPadding >= 0),
        assert(ratio != null && ratio > 0);

  _TableHeaderCell _build({
    @required VerticalAlignment headersVerticalAlignment,
  }) {
    Alignment alignment;
    switch (headersVerticalAlignment) {
      case VerticalAlignment.top:
        switch (this.horizontalAlignment) {
          case HorizontalAlignment.left:
            alignment = Alignment.topLeft;
            break;
          case HorizontalAlignment.center:
            alignment = Alignment.topCenter;
            break;
          case HorizontalAlignment.right:
            alignment = Alignment.topRight;
            break;
        }
        break;
      case VerticalAlignment.middle:
        switch (this.horizontalAlignment) {
          case HorizontalAlignment.left:
            alignment = Alignment.centerLeft;
            break;
          case HorizontalAlignment.center:
            alignment = Alignment.center;
            break;
          case HorizontalAlignment.right:
            alignment = Alignment.centerRight;
            break;
        }
        break;
      case VerticalAlignment.bottom:
        switch (this.horizontalAlignment) {
          case HorizontalAlignment.left:
            alignment = Alignment.bottomLeft;
            break;
          case HorizontalAlignment.center:
            alignment = Alignment.bottomCenter;
            break;
          case HorizontalAlignment.right:
            alignment = Alignment.bottomRight;
            break;
        }
        break;
    }
    return _TableHeaderCell(
      alignment: alignment,
      content: this.content,
      horizontalPadding: this.horizontalPadding,
      key: this.key,
      ratio: this.ratio,
    );
  }
}




/// [TableHeaderCell]
class _TableHeaderCell extends StatelessWidget {
  final Alignment alignment;
  final Widget content;
  final double horizontalPadding;
  final int ratio;

  _TableHeaderCell({
    @required this.alignment,
    @required this.content,
    @required this.horizontalPadding,
    @required Key key,
    @required this.ratio,
  }) : assert(alignment != null),
        assert(content != null),
        assert(horizontalPadding != null && horizontalPadding >= 0),
        assert(ratio != null && ratio > 0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: this.ratio,
      child: Container(
        alignment: alignment,
        child: this.content,
        padding: EdgeInsets.symmetric(horizontal: this.horizontalPadding),
      ),
    );
  }
}




/// [TableBodyRow]
class TableBodyRow {
  final List<TableBodyCell> cells;
  final double height;
  final Key key;

  TableBodyRow({
    @required this.cells,
    this.height = 35.0,
    this.key,
  }) : assert(cells != null && cells.isNotEmpty),
        assert(height != null && height > 0);

  _TableBodyRow _build({
    @required List<Alignment> alignments,
    @required List<double> horizontalPaddings,
    @required List<int> ratios,
  }) {
    return _TableBodyRow(
      alignments: alignments,
      cells: this.cells,
      height: this.height,
      horizontalPaddings: horizontalPaddings,
      key: this.key,
      ratios: ratios,
    );
  }
}




/// [_TableBodyRow]
class _TableBodyRow extends StatelessWidget {
  final List<Alignment> alignments;
  final List<TableBodyCell> cells;
  final List<double> horizontalPaddings;
  final List<int> ratios;
  final double height;

  _TableBodyRow({
    @required this.alignments,
    @required this.cells,
    @required this.height,
    @required this.horizontalPaddings,
    Key key,
    @required this.ratios,
  }) : assert(alignments != null && alignments.isNotEmpty),
        assert(cells != null && cells.isNotEmpty),
        assert(height != null && height >= 0),
        assert(horizontalPaddings != null && horizontalPaddings.isNotEmpty),
        assert(ratios != null),
        assert(alignments.length == cells.length && horizontalPaddings.length == cells.length && ratios.length == cells.length),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: SizedBox(
        height: this.height,
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
  final Key key;

  TableBodyCell({
    @required this.content,
    this.key
  }) : assert(content != null);

  _TableBodyCell _build({
    Alignment alignment = Alignment.centerLeft,
    double horizontalPadding = 0,
    int ratio = 1,
  }) {
    return _TableBodyCell(
      alignment: alignment,
      content: this.content,
      key: this.key,
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
    this.alignment,
    @required this.content,
    Key key,
    this.padding,
    this.ratio,
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