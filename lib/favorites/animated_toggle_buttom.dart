import 'package:flutter/material.dart';

class AnimatedToggleButton extends StatefulWidget {
  @override
  _AnimatedToggleButtonState createState() => _AnimatedToggleButtonState();
}

class _AnimatedToggleButtonState extends State<AnimatedToggleButton> {
  bool _isOn = false;

  void _toggleButton() {
    setState(() {
      _isOn = !_isOn;
    });
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
          color: _isOn ? Colors.green : Colors.grey,
        ),
        child: Stack(
          children: [
            AnimatedPositioned(
              duration: Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              left: _isOn ? 15.0 : 0.0,
              right: _isOn ? 0.0 : 24.0,
              child: AnimatedSwitcher(
                duration: Duration(milliseconds: 200),
                child: _isOn
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
