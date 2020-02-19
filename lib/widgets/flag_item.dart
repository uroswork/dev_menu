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
    bool pref = await getSharedPreferenceBool(widget.item['title']);

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
              Text(
                widget.item['title'],
                maxLines: 1,
                overflow: TextOverflow.fade,
                softWrap: false,
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 5),
                child: widget.item['description'] != null
                    ? Text(
                        widget.item['description'],
                        style: TextStyle(
                          color: Colors.black54,
                        ),
                      )
                    : Container(),
              ),
            ],
          ),
        ),
        Switch(
          value: value,
          onChanged: (newValue) {
            setSharedPreferenceBool(widget.item['title'], newValue);
            setState(() {
              value = newValue;
            });
          },
        ),
      ],
    );
  }
}
