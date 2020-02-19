import 'package:flutter/material.dart';
import 'package:dev_menu/helpers/shared_preferences_helper.dart';

class DropDown extends StatefulWidget {
  final String initialValue;
  final String title;
  final List<String> options;
  final List<Map<String, dynamic>> customAppInfo;

  const DropDown({
    Key key,
    this.title,
    this.initialValue,
    this.options,
    this.customAppInfo,
  }) : super(key: key);
  @override
  _DropDownState createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> with SharedPreferencesHelper {
  String _dropdownValue;
  @override
  void initState() {
    _dropdownValue = widget.initialValue;

    _getPreferences();
    super.initState();
  }

  void _getPreferences() async {
    String sharedPrefItemTitle = 'dev_menu_additional_' + widget.title;
    String pref = await getSharedPreferenceString(sharedPrefItemTitle);

    if (pref == 'NOT_EXISTING') {
      setSharedPreferenceString(sharedPrefItemTitle, _dropdownValue);
    } else {
      setState(() {
        _dropdownValue = pref;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String sharedPrefItemTitle = 'dev_menu_additional_' + widget.title;
    return (DropdownButton(
      value: _dropdownValue,
      isExpanded: true,
      items: widget.options.map((item) {
        return DropdownMenuItem(
          value: item,
          child: Text(item),
        );
      }).toList(),
      onChanged: (newValue) {
        setSharedPreferenceString(sharedPrefItemTitle, newValue);
        setState(() {
          _dropdownValue = newValue;
        });
      },
    ));
  }
}
