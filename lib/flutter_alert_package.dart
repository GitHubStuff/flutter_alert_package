library flutter_alert_package;

import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

typedef AlertCallback = void Function();

Future<void> showAlert({
  @required BuildContext buildContext,
  @required dynamic title,
  @required dynamic content,
  String dismiss = 'Dismiss',
  AlertCallback alertCallback,
}) {
  assert(buildContext != null);
  assert(title != null);
  assert(content != null);
  assert(dismiss != null);
  title = (title is String) ? Text(title) : title;
  content = (content is String) ? Text(content) : content;
  if (Platform.isAndroid) {
    return _androidAlert(buildContext: buildContext, title: title, content: content, dismiss: dismiss, callback: alertCallback);
  } else if (Platform.isIOS) {
    return _iosAlert(buildContext: buildContext, title: title, content: content, dismiss: dismiss, callback: alertCallback);
  } else {
    throw Exception('Unknown platform');
  }
}

Future<void> _androidAlert({BuildContext buildContext, Widget title, Widget content, String dismiss, AlertCallback callback}) {
  return showDialog(
    context: buildContext,
    barrierDismissible: false,
    builder: (BuildContext context) {
      // return object of type Dialog
      return AlertDialog(
        title: title,
        content: content,
        actions: <Widget>[
          // usually buttons at the bottom of the dialog
          new FlatButton(
            child: new Text(dismiss),
            onPressed: () {
              Navigator.of(context).pop();
              if (callback != null) callback();
            },
          ),
        ],
      );
    },
  );
}

Future<void> _iosAlert({BuildContext buildContext, Widget title, Widget content, String dismiss, AlertCallback callback}) {
  return showCupertinoDialog(
    context: buildContext,
    builder: (BuildContext context) {
      return CupertinoAlertDialog(
        title: title,
        content: content,
        actions: <Widget>[
          // usually buttons at the bottom of the dialog
          new FlatButton(
            textColor: Colors.black,
            child: new Text(dismiss),
            onPressed: () {
              Navigator.of(context).pop();
              if (callback != null) callback();
            },
          ),
        ],
      );
    },
  );
}
