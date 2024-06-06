import 'package:exstudio/account/animated_toggle_buttom.dart';
import 'package:exstudio/flutter_flow/flutter_flow_theme.dart';
import 'package:exstudio/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class FavoritesWidget extends StatefulWidget {
  const FavoritesWidget({super.key});

  @override
  State<FavoritesWidget> createState() => _FavoritesWidgetState();
}

class _FavoritesWidgetState extends State<FavoritesWidget> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Container(
              width: double.infinity,
              height: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: ListView(
                      physics: BouncingScrollPhysics(),
                      children: [
                        SizedBox(height: 11),
                        Text(
                          'Аккаунт',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 50,
                            fontFamily: "BebasNeue",
                            fontWeight: FontWeight.w400,
                            letterSpacing: 0.3,
                          ),
                        ),
                        SizedBox(height: 19),
                        Text(
                          'Личные данные',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 30,
                            fontFamily: "BebasNeue",
                            fontWeight: FontWeight.w400,
                            letterSpacing: 0.5,
                          ),
                        ),
                        SizedBox(height: 16),
                        Text(
                          "Никнейм",
                          style: TextStyle(
                            color: Color(0xff9EADBD),
                            fontSize: 14,
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "smokeynagato",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: 32),
                        Text(
                          "ФИО",
                          style: TextStyle(
                            color: Color(0xff9EADBD),
                            fontSize: 14,
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Иван Иванов",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: 32),
                        Text(
                          "E-mail",
                          style: TextStyle(
                            color: Color(0xff9EADBD),
                            fontSize: 14,
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "pavel@yandex.ru",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: 44),
                        Text(
                          'Настройки',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 30,
                            fontFamily: "BebasNeue",
                            fontWeight: FontWeight.w400,
                            letterSpacing: 0.5,
                          ),
                        ),
                        SizedBox(height: 13),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Уведомления',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'Inter',
                                      letterSpacing: 0.4),
                                ),
                              ],
                            ),
                            AnimatedToggleButton()
                          ],
                        ),
                        SizedBox(height: 32),
                        Divider(
                          height: 0.5,
                          thickness: 0.5,
                          color: Color(0xFF9EADBD),
                        ),
                        SizedBox(height: 42),
                        Text(
                          'еще',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 30,
                            fontFamily: "BebasNeue",
                            fontWeight: FontWeight.w400,
                            letterSpacing: 0.5,
                          ),
                        ),
                        InkWell(
                          onTap: (() {}),
                          child: Padding(
                            padding: EdgeInsets.only(top: 14, bottom: 17),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.telegram),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      'Мы в Telegram',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontFamily: "Inter",
                                        fontWeight: FontWeight.w400,
                                        letterSpacing: 0.3,
                                      ),
                                    ),
                                  ],
                                ),
                                Icon(
                                  Icons.chevron_right,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Divider(
                          height: 0.5,
                          thickness: 0.5,
                          color: Color(0xFF9EADBD),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset('assets/icons/box.svg'),
                                SizedBox(
                                  width: 9,
                                ),
                                Text(
                                  'Версия 0.0.1',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontFamily: "Inter",
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: 0.3,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Divider(
                          height: 0.5,
                          thickness: 0.5,
                          color: Color(0xFF9EADBD),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: FFButtonWidget(
                            onPressed: () async {
                              _showDialog(
                                  context: context,
                                  text: 'Вы точно хотите выйти из аккаунта?',
                                  functionYes: () async {
                                    // signOut = await SignOutCall.call(
                                    //   userAuthToken: FFAppState().userAuthToken,
                                    //   refreshToken: FFAppState().refreshToken,
                                    // );
                                    // if (resultCodeSuccess(getJsonField(
                                    //   (signOut?.jsonBody ?? ''),
                                    //   r'''$.status''',
                                    // ))) {
                                    //   FFAppState().userAuthToken = "";
                                    //   FFAppState().clearDataUser();
                                    //   Phoenix.rebirth(context);
                                    // }
                                  },
                                  functionNo: () {
                                    Navigator.pop(context);
                                  });
                            },
                            text: 'Выйти из аккаунта',
                            options: FFButtonOptions(
                              elevation: 0,
                              width: double.infinity,
                              height: 60,
                              color: Color(0xFF9EADBD),
                              textStyle: FlutterFlowTheme.of(context)
                                  .subtitle2
                                  .override(
                                    fontFamily: 'Inter',
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal,
                                  ),
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
