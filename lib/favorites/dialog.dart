import 'package:exstudio/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';

void _showDialog({
  required BuildContext context,
  required String text,
  required void Function() functionYes,
  required void Function() functionNo,
}) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text(
            text,
            style: FlutterFlowTheme.of(context).bodyText1.override(
                  fontFamily: 'Inter',
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: functionYes,
              child: Text("Да"),
            ),
            TextButton(
              onPressed: functionNo,
              child: Text("Нет"),
            ),
          ],
        );
      });
}
