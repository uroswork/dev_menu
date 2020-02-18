import 'package:flutter/material.dart';

class DeviceInfo extends StatelessWidget {
  final Map<String, dynamic> deviceData;

  const DeviceInfo({
    Key key,
    this.deviceData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: deviceData.keys.map(
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
                    deviceData[property].toString(),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          );
        },
      ).toList(),
    );
  }
}
