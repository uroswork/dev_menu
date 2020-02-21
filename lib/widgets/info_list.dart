import 'package:dev_menu/widgets/drop_down.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;

class InfoList extends StatelessWidget {
  final Map data;
  final String title;
  final List<Map<String, dynamic>> customAppInfo;

  const InfoList({
    Key key,
    this.data,
    this.title,
    this.customAppInfo,
  }) : super(key: key);

  Widget renderAdditionalAppInfo() {
    bool isiOS = Platform.isIOS;
    if (customAppInfo != null && customAppInfo.length > 0) {
      return Column(
        children: customAppInfo.map(
          (appInfo) {
            List<String> options = [];
            appInfo['options'].forEach((option) {
              options.add(option.toString());
            });

            return Row(
              children: <Widget>[
                Text(
                  appInfo['title'],
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.fromLTRB(5.0, 10.0, 0.0, 10.0),
                    child: DropDown(
                      title: appInfo['title'],
                      initialValue: appInfo['selected'].toString(),
                      options: options,
                    ),
                  ),
                )
              ],
            );
          },
        ).toList(),
      );
    } else {
      if (isiOS) {
        return Text(
            'You are running on iOS. Add customAppInfo if you want to see it here.');
      }
    }
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    bool isiOS = Platform.isIOS;
    Map _data = data;
    bool isDeviceInfo = title == 'Device info';
    if (isDeviceInfo) {
      double width = MediaQuery.of(context).size.width;
      double height = MediaQuery.of(context).size.height;
      _data['screen width'] = width.floor().toString();
      _data['screen height'] = height.floor().toString();
    }
    bool isAppInfo = title == 'Application info';
    bool shouldHideDefaultAppInfo = isiOS && isAppInfo;

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: _data != null
            ? Column(
                children: [
                  shouldHideDefaultAppInfo
                      ? Container()
                      : Column(
                          children: _data.keys.map(
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
                                      padding: EdgeInsets.fromLTRB(
                                          5.0, 10.0, 0.0, 10.0),
                                      child: Text(
                                        _data[property].toString(),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ).toList(),
                        ),
                  renderAdditionalAppInfo()
                ],
              )
            : shouldHideDefaultAppInfo
                ? Text(
                    'You are running on iOS. Add customAppInfo if you want to see it here.')
                : Text('Please provide packageName.'),
      ),
    );
  }
}
