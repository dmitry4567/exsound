import 'package:exstudio/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';

class AnimatedButton extends StatefulWidget {
  const AnimatedButton({
    Key? key,
    required this.onEnd,
    required this.duration,
  }) : super(key: key);

  final VoidCallback onEnd;
  final Duration duration;

  @override
  _AnimatedButtonState createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton> {
  bool _isPressed = false;
  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 1,
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return GestureDetector(
            onTapDown: (TapDownDetails details) {
              setState(() {
                _isPressed = true;
              });
            },
            onTapUp: (TapUpDetails details) {
              setState(() {
                _isPressed = false;
              });
            },
            onTapCancel: () {
              setState(() {
                _isPressed = false;
              });
            },
            child: Container(
              height: 56,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: const Color(0xffCBD4DD),
              ),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: AnimatedContainer(
                      duration: widget.duration,
                      width: _isPressed ? constraints.maxWidth : 0,
                      height: 56,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: const Color(0xff9EADBD),
                      ),
                      onEnd: () {
                        if (_isPressed) {
                          return widget.onEnd();
                        }
                      },
                    ),
                  ),
                  Center(
                    child: Text(
                      'Завершить',
                      style: FlutterFlowTheme.of(context).subtitle2.override(
                            fontFamily: 'Inter',
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
