import 'package:flutter/material.dart';
import 'package:dev_menu/widgets/flag_item.dart';

class FlagsList extends StatelessWidget {
  final List<Map<String, dynamic>> list;

  const FlagsList({
    Key key,
    this.list,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: list.map(
        (item) {
          return FlagItem(item: item);
        },
      ).toList(),
    );
  }
}
