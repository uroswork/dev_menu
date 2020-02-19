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
    return Scaffold(
      appBar: AppBar(
        title: Text('Flags'),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: list.map(
            (item) {
              return FlagItem(item: item);
            },
          ).toList(),
        ),
      ),
    );
  }
}
