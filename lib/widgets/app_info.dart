import 'package:flutter/material.dart';

class AppInfo extends StatelessWidget {
  final Map appData;

  const AppInfo({
    Key key,
    this.appData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return appData != null
        ? Column(
            children: appData.keys.map(
              (property) {
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
                          appData[property].toString(),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ).toList(),
          )
        : Container();
  }
}
