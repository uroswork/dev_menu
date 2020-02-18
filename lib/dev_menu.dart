import 'package:flutter/material.dart';

import 'package:dev_menu/helpers/shared_preferences_helper.dart';
import 'package:dev_menu/widgets/flags_list.dart';
import 'package:dev_menu/widgets/device_info.dart';
import 'package:dev_menu/widgets/app_info.dart';
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

  const DevMenu({
    Key key,
    this.flags,
    this.packageName,
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
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Developer menu'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            FlagsList(list: widget.flags),
            AppInfo(appData: _appData),
            DeviceInfo(deviceData: _deviceData),
          ],
        ),
      ),
    );
  }
}
