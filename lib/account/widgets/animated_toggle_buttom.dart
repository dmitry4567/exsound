import 'dart:developer';
import 'package:exstudio/backend/api_requests/api_calls.dart';
import 'package:exstudio/flutter_flow/flutter_flow_util.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class AnimatedToggleButton extends StatefulWidget {
  bool isOn;

  AnimatedToggleButton(this.isOn);

  @override
  _AnimatedToggleButtonState createState() => _AnimatedToggleButtonState();
}

class _AnimatedToggleButtonState extends State<AnimatedToggleButton> {
  void _toggleButton() async {
    if (widget.isOn) {
      String? deviceToken = await FirebaseMessaging.instance.getToken();

      if (deviceToken != null) {
        log(deviceToken);

        final notification = await SubscribeNotification.call(
          token: FFAppState().userAuthToken,
          deviceToken: deviceToken,
        );

        if (notification.succeeded) {
          setState(() {
            widget.isOn = !widget.isOn;
          });
        }
      }
    } else {
      final notificationSettings = await FirebaseMessaging.instance
          .requestPermission(provisional: false);

      await FirebaseMessaging.instance.setAutoInitEnabled(true);
      String? deviceToken = await FirebaseMessaging.instance.getToken();

      if (deviceToken != null) {
        final notification = await SubscribeNotification.call(
          token: FFAppState().userAuthToken,
          deviceToken: deviceToken,
        );

        if (notification.succeeded) {
          setState(() {
            widget.isOn = !widget.isOn;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleButton,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        width: 40.0,
        height: 24.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: widget.isOn ? Colors.green : Colors.grey,
        ),
        child: Stack(
          children: [
            AnimatedPositioned(
              duration: Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              left: widget.isOn ? 15.0 : 0.0,
              right: widget.isOn ? 0.0 : 24.0,
              child: AnimatedSwitcher(
                duration: Duration(milliseconds: 200),
                child: widget.isOn
                    ? Icon(
                        Icons.circle,
                        color: Colors.white,
                        size: 24.0,
                        key: UniqueKey(),
                      )
                    : Icon(
                        Icons.circle,
                        color: Colors.white,
                        size: 24.0,
                        key: UniqueKey(),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
