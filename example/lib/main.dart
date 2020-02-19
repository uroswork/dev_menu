import 'package:flutter/material.dart';
import 'package:dev_menu/dev_menu.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DevMenu(
        testWidgets: [
          {
            'name': 'Alert dialog',
            'widget': AlertDialog(
              title: Text('Title'),
              content: Text('Content'),
              actions: <Widget>[
                FlatButton(
                  onPressed: () {},
                  child: Center(
                    child: Text('Button 1'),
                  ),
                ),
                FlatButton(
                  onPressed: () {},
                  child: Center(
                    child: Text('Button 2'),
                  ),
                )
              ],
            ),
          },
          {
            'name': 'Sized box',
            'widget': SizedBox(
              width: 300,
              height: 400,
              child: Container(
                color: Colors.red,
                child: Text('I am text in sized box'),
              ),
            )
          }
        ],
        packageName: 'com.example.dev_menu_example',
        flags: [
          {
            'title': 'Flag 1 title',
            'description': 'Flag 1 description',
          },
          {
            'title': 'Flag 2 title without description',
          },
          {
            'title':
                'Flag 3 title which is very long in order to try to break UI',
            'description':
                'Flag 3 description which is very long in order to try to break UI'
          }
        ],
      ),
    );
  }
}
