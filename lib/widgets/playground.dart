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
        title: Text('Test playground'),
        centerTitle: true,
      ),
      body: widgets != null && widgets.length > 0
          ? ListView(
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
                                title: Text(widget['name']),
                              ),
                              body: widget['widget'],
                            ),
                          ),
                        );
                      },
                    ),
                  )
                  .toList(),
            )
          : Container(
              padding: EdgeInsets.all(20.0),
              child: Text('Please add some Test Widgets.'),
            ),
    );
  }
}
