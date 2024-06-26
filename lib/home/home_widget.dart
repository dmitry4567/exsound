import 'package:exstudio/flutter_flow/flutter_flow_util.dart';
import 'package:exstudio/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  static const List<String> text = [
    'доброе утро',
    'добрый день',
    'добрый вечер',
    'доброй ночи'
  ];

  String welcomeText = '';

  @override
  void initState() {
    super.initState();

    final dateNow = DateTime.now();

    if (dateNow.hour >= 6 && dateNow.hour < 12)
      welcomeText = text[0];
    else if (dateNow.hour >= 12 && dateNow.hour < 18)
      welcomeText = text[1];
    else if (dateNow.hour >= 18 && dateNow.hour < 24)
      welcomeText = text[2];
    else if (dateNow.hour >= 0 && dateNow.hour < 6) welcomeText = text[3];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(color: Colors.white),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 18),
              child: Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Title(
                        text: welcomeText,
                      ),
                      Description(),
                      BookButton(),
                      SetDistanceButton(),
                    ],
                  ),
                  // LogoIcon(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Title extends StatelessWidget {
  const Title({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 15),
      child: Center(
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'BebasNeue',
            color: Colors.black,
            fontSize: 45,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
    );
  }
}

class Description extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'Что ты хочешь сделать?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Inter',
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BookButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 48, bottom: 12),
      child: Container(
        width: double.infinity,
        child: FFButtonWidget(
          onPressed: () async {
            context.pushNamed('addsession');
          },
          text: 'Забронировать время',
          options: FFButtonOptions(
            elevation: 0,
            width: double.infinity,
            height: 60,
            color: Color(0xFF8D40FF),
            textStyle: TextStyle(
              fontFamily: 'Inter',
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.normal,
            ),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }
}

class SetDistanceButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 0, bottom: 50),
      child: Container(
        width: double.infinity,
        child: FFButtonWidget(
          onPressed: () {},
          text: 'QR',
          options: FFButtonOptions(
            elevation: 0,
            width: double.infinity,
            height: 60,
            color: Color(0xFF9EADBD),
            textStyle: TextStyle(
              fontFamily: 'Inter',
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.normal,
            ),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }
}

class LogoIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 19,
      child: SvgPicture.asset("assets/icons/box.svg"),
    );
  }
}
