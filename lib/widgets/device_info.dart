import 'package:flutter/material.dart';

class DeviceInfo extends StatelessWidget {
  final Map<String, dynamic> deviceData;

  const DeviceInfo({
    Key key,
    this.deviceData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> _deviceData = deviceData;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    _deviceData['screen width'] = width.floor().toString();
    _deviceData['screen height'] = height.floor().toString();

    return Scaffold(
      appBar: AppBar(
        title: Text('Developer menu - Device info'),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: _deviceData.keys.map(
            (String property) {
              return Row(
                children: <Widget>[
                  Text(
                    property,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.fromLTRB(5.0, 10.0, 0.0, 10.0),
                      child: Text(
                        _deviceData[property].toString(),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              );
            },
          ).toList(),
        ),
      ),
    );
  }
}
