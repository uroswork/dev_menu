import 'package:flutter/material.dart';

class Playground extends StatelessWidget {
  final List widgets;

  const Playground({
    Key key,
    this.widgets,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Developer menu - Test playground'),
      ),
      body: ListView(
        children: widgets
            .map(
              (widget) => ListTile(
                title: Text(widget['name']),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Scaffold(
                        appBar: AppBar(
                          title: Text(
                            'Developer menu - ' + widget['name'],
                          ),
                        ),
                        body: widget['widget'],
                      ),
                    ),
                  );
                },
              ),
            )
            .toList(),
      ),
    );
  }
}
