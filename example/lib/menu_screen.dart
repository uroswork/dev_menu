import 'package:flutter/material.dart';
import 'package:dev_menu/dev_menu.dart';

class MenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DevMenu(
      customAppInfo: [
        {
          'title': 'Environment',
          'selected': 'QA',
          'options': ['QA', 'DEV', 'PROD', 'STAGING']
        },
      ],
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
          'title': 'Is Environment button enabled?',
          'description': 'Determine if Environment button should work.',
        },
      ],
    );
  }
}
