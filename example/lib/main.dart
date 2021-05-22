import 'package:flutter/material.dart';
import 'package:flutter_custom_table/flutter_custom_table.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: FlutterCustomTable(
            headers: [
              TableHeaderCell(
                content: Text('No.'),
                ratio: 1,
              ),

              TableHeaderCell(
                content: Text('Header 1'),
                ratio: 10,
              ),

              TableHeaderCell(
                content: Text('Header 2'),
                ratio: 10,
              ),
            ],

            rows: [
              for (int i = 0; i < 100; i++)
                TableBodyRow(
                  cells: [
                    TableBodyCell(
                      content: Text('${i + 1}'),
                    ),

                    TableBodyCell(
                      content: Text('Cell'),
                    ),

                    TableBodyCell(
                      content: Text('Cell'),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
