import 'package:dev_menu/helpers/shared_preferences_helper.dart';
import 'package:flutter/material.dart';

class FlagItem extends StatefulWidget {
  final item;

  const FlagItem({
    Key key,
    this.item,
  }) : super(key: key);

  @override
  _FlagItemState createState() => _FlagItemState();
}

class _FlagItemState extends State<FlagItem> with SharedPreferencesHelper {
  bool value = false;

  @override
  void initState() {
    _getPreferences();

    super.initState();
  }

  void _getPreferences() async {
    bool pref = await getSharedPreference(widget.item['title']);

    setState(() {
      value = pref;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    'FLAG: ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      widget.item['title'],
                      maxLines: 1,
                      overflow: TextOverflow.fade,
                      softWrap: false,
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ),
                ],
              ),
              widget.item['description'] != null
                  ? Text(widget.item['description'])
                  : Container()
            ],
          ),
        ),
        Switch(
          value: value,
          onChanged: (newValue) {
            setSharedPreference(widget.item['title'], newValue);
            setState(() {
              value = newValue;
            });
          },
        ),
      ],
    );
  }
}
