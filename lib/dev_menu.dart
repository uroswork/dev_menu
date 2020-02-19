import 'package:dev_menu/widgets/info_list.dart';
import 'package:dev_menu/widgets/playground.dart';
import 'package:flutter/material.dart';

import 'package:dev_menu/helpers/shared_preferences_helper.dart';
import 'package:dev_menu/widgets/flags_list.dart';
import 'package:dev_menu/helpers/device_info_helper.dart';
import 'package:flutter/services.dart';

class DevMenuHelper with SharedPreferencesHelper {
  @override
  Future<bool> setSharedPreference(String title, bool value) {
    return super.setSharedPreference(title, value);
  }

  @override
  Future<bool> getSharedPreference(String title) {
    return super.getSharedPreference(title);
  }
}

class DevMenu extends StatefulWidget {
  final List<Map<String, dynamic>> flags;
  final String packageName;
  final List<Map<String, dynamic>> testWidgets;

  const DevMenu({
    Key key,
    this.flags,
    this.packageName,
    this.testWidgets,
  }) : super(key: key);

  @override
  _DevMenuState createState() => _DevMenuState();
}

class _DevMenuState extends State<DevMenu> with DeviceInfoHelper {
  Map<String, dynamic> _deviceData = <String, dynamic>{};
  Map _appData;

  static MethodChannel packageInfoPlatform =
      const MethodChannel('devmenu.flutter.io/packageInfo');

  @override
  void initState() {
    super.initState();

    _getDeviceInfo();
    _getPackageInfo();
  }

  Future<void> _getPackageInfo() async {
    await packageInfoPlatform.invokeMethod('getPackageInfo', {
      "packageName": widget.packageName,
    }).then((result) {
      setState(() {
        _appData = result;
      });
    }).catchError((e) {
      print(e);
    });
  }

  Future<void> _getDeviceInfo() async {
    var data = await initPlatformState();

    setState(() {
      _deviceData = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> screens = [
      {
        'name': 'Flags',
        'widget': FlagsList(list: widget.flags),
        'description': 'Description',
      },
      {
        'name': 'Application info',
        'widget': InfoList(
          data: _appData,
          title: 'Developer menu - Application info',
        ),
        'description': 'Description',
      },
      {
        'name': 'Device info',
        'widget': InfoList(
          data: _deviceData,
          title: 'Developer menu - Device info',
        ),
        'description': 'Description',
      },
      {
        'name': 'Test playground',
        'widget': Playground(widgets: widget.testWidgets),
      }
    ];

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Developer menu'),
      ),
      body: ListView(
        physics: NeverScrollableScrollPhysics(),
        children: screens
            .map(
              (item) => ListTile(
                subtitle: item['description'] != null
                    ? Text(item['description'])
                    : Container(),
                title: Text(item['name']),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => item['widget'],
                    ),
                  );
                },
              ),
            )
            .toList(),
      ),
    );
  }
}
