import 'package:dev_menu/widgets/drop_down.dart';
import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
    Map _data = data;
    if (title == 'Device info') {
      double width = MediaQuery.of(context).size.width;
      double height = MediaQuery.of(context).size.height;
      _data['screen width'] = width.floor().toString();
      _data['screen height'] = height.floor().toString();
    }

    Widget renderAdditionalAppInfo() {
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
      }
      return Container();
    }

    return _data != null
        ? Scaffold(
            appBar: AppBar(
              title: Text(title),
              centerTitle: true,
            ),
            body: Container(
              padding: EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Column(
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
                                padding:
                                    EdgeInsets.fromLTRB(5.0, 10.0, 0.0, 10.0),
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
              ),
            ),
          )
        : Container();
  }
}
