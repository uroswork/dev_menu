import 'package:dev_menu/widgets/info_list.dart';
import 'package:dev_menu/widgets/playground.dart';
import 'package:flutter/material.dart';

import 'package:dev_menu/helpers/shared_preferences_helper.dart';
import 'package:dev_menu/widgets/flags_list.dart';
import 'package:dev_menu/helpers/device_info_helper.dart';
import 'package:flutter/services.dart';

class DevMenuHelper with SharedPreferencesHelper {
  @override
  Future<bool> setSharedPreferenceBool(String title, bool value) {
    return super.setSharedPreferenceBool(title, value);
  }

  @override
  Future<bool> getSharedPreferenceBool(String title) {
    return super.getSharedPreferenceBool(title);
  }

  @override
  Future<bool> setSharedPreferenceString(String title, String value) {
    return super.setSharedPreferenceString(title, value);
  }

  @override
  Future<String> getSharedPreferenceString(String title) {
    return super.getSharedPreferenceString(title);
  }
}

class DevMenu extends StatefulWidget {
  final String packageName;
  final List<Map<String, dynamic>> flags;
  final List<Map<String, dynamic>> testWidgets;
  final List<Map<String, dynamic>> customAppInfo;

  const DevMenu({
    Key key,
    this.flags,
    this.packageName,
    this.testWidgets,
    this.customAppInfo,
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
        'description':
            'Switches to turn certain features or test options on and off.',
      },
      {
        'name': 'Application info',
        'widget': InfoList(
          data: _appData,
          title: 'Application info',
          customAppInfo: widget.customAppInfo,
        ),
        'description':
            'Find out (and add your own, for example the environment) some useful info about the app like app version, build number.',
      },
      {
        'name': 'Device info',
        'widget': InfoList(
          data: _deviceData,
          title: 'Device info',
        ),
        'description':
            'Find out some useful info about the device like manufacturer, OS version, phone dimensions and many more.',
      },
      {
        'name': 'Test playground',
        'widget': Playground(widgets: widget.testWidgets),
        'description':
            'Add the WIP components of your app or the ones that are not connected to flow so other members of the team (QAs can test the UI for example) can see it.',
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
                isThreeLine: item['name'] != 'Flags',
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
