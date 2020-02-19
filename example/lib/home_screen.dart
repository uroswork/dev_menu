import 'package:flutter/material.dart';
import 'package:dev_menu_example/menu_screen.dart';
import 'package:dev_menu/dev_menu.dart';

class HomeScreen extends StatelessWidget {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  void _handleButtonClick() async {
    bool shouldAllowClick = await DevMenuHelper()
        .getSharedPreferenceBool('Is Environment button enabled?');

    String currentEnvironment = await DevMenuHelper()
        .getSharedPreferenceString('dev_menu_additional_Environment');

    String snackBarLabel = shouldAllowClick
        ? 'Current Environment is ' + currentEnvironment
        : 'Button is not enabled! Try enabling it through dev menu.';

    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text(snackBarLabel),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: FlatButton(
          onPressed: () {
            _scaffoldKey.currentState.hideCurrentSnackBar();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MenuScreen(),
              ),
            );
          },
          child: Icon(Icons.menu),
        ),
        title: Text('Dev menu example'),
        centerTitle: true,
      ),
      body: Center(
        child: RaisedButton(
          onPressed: _handleButtonClick,
          child: Text('Get Environment'),
        ),
      ),
    );
  }
}
