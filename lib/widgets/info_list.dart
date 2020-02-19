import 'package:flutter/material.dart';

class InfoList extends StatelessWidget {
  final Map data;
  final String title;

  const InfoList({
    Key key,
    this.data,
    this.title,
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
    return _data != null
        ? Scaffold(
            appBar: AppBar(
              title: Text(title),
              centerTitle: true,
            ),
            body: Container(
              padding: EdgeInsets.all(20.0),
              child: Column(
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
                            padding: EdgeInsets.fromLTRB(5.0, 10.0, 0.0, 10.0),
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
            ),
          )
        : Container();
  }
}
