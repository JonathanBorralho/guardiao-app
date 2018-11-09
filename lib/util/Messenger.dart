import 'package:flutter/material.dart';

class Messenger extends StatelessWidget {
  const Messenger({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: Builder(
        builder: (context) =>
            Center(
              child: RaisedButton(
                child: const Text('Show toast'),
                onPressed: () => _showToast(context),
              ),
            ),
      ),
    );
  }

  void _showToast(BuildContext context) {
    final scaffold = Scaffold.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: const Text('Added to favorite'),
        action: SnackBarAction(
            label: 'UNDO', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }
}