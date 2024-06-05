import 'package:exstudio/flutter_flow/flutter_flow_widgets.dart';
import 'package:exstudio/index.dart';
import 'package:exstudio/sign_in/bloc/login_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../backend/api_requests/api_calls.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';

class SignInWidget extends StatefulWidget {
  const SignInWidget({Key? key}) : super(key: key);

  @override
  _SignInWidgetState createState() => _SignInWidgetState();
}

class _SignInWidgetState extends State<SignInWidget> {
  ApiCallResponse? login;
  TextEditingController? textController1;
  TextEditingController? textController2;

  late bool passwordVisibility;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    textController1 = TextEditingController();
    textController2 = TextEditingController();
    passwordVisibility = false;
  }

  @override
  void dispose() {
    textController1?.dispose();
    textController2?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final safeAreaBottom = MediaQuery.of(context).padding.top;

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      body: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginError) {
            ScaffoldMessenger.of(context)
                .showSnackBar(functions.setupSnackBar(state.error));
          }
          if (state is LoginPass) {
            context.goNamed('home');
          }
        },
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (overscroll) {
              overscroll.disallowIndicator();
              return true;
            },
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(
                    top: safeAreaBottom + 100, left: 33, right: 33),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const Text(
                      'Авторизация',
                      style: TextStyle(
                        color: Color(0xff252B37),
                        fontSize: 36,
                        fontFamily: "RobotoFlex",
                        fontWeight: FontWeight.w500,
                        height: 1.0,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Container(
                        width: double.infinity,
                        height: 56,
                        decoration: BoxDecoration(
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Align(
                          alignment: const AlignmentDirectional(0, 0),
                          child: TextFormField(
                            controller: textController1,
                            autofocus: true,
                            obscureText: false,
                            decoration: InputDecoration(
                              hintText: 'E-mail',
                              hintStyle: TextStyle(
                                color: const Color(0xff252B37).withOpacity(0.2),
                                fontSize: 16,
                                fontFamily: 'RobotoFlex',
                                fontWeight: FontWeight.w400,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color:
                                      const Color(0xff252B37).withOpacity(0.2),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Color(0xFFFFA000),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Color(0x00000000),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Color(0xFFF14343),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding:
                                  const EdgeInsetsDirectional.fromSTEB(
                                      16, 14, 16, 14),
                            ),
                            style:
                                FlutterFlowTheme.of(context).bodyText1.override(
                                      fontFamily: 'Inter',
                                      color: const Color(0xFF0F0F0F),
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal,
                                    ),
                            keyboardType: TextInputType.emailAddress,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 25),
                      child: Container(
                        width: double.infinity,
                        height: 56,
                        decoration: BoxDecoration(
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Align(
                          alignment: const AlignmentDirectional(0, 0),
                          child: TextFormField(
                            controller: textController2,
                            autofocus: true,
                            obscureText: !passwordVisibility,
                            decoration: InputDecoration(
                              hintText: 'Пароль',
                              hintStyle: TextStyle(
                                color: const Color(0xff252B37).withOpacity(0.2),
                                fontSize: 16,
                                fontFamily: 'RobotoFlex',
                                fontWeight: FontWeight.w400,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color:
                                      const Color(0xff252B37).withOpacity(0.2),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Color(0xFFFFA000),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Color(0x00000000),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Color(0xFFF14343),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding:
                                  const EdgeInsetsDirectional.fromSTEB(
                                      16, 14, 16, 14),
                              suffixIcon: InkWell(
                                onTap: () => setState(
                                  () =>
                                      passwordVisibility = !passwordVisibility,
                                ),
                                focusNode: FocusNode(skipTraversal: true),
                                child: Icon(
                                  passwordVisibility
                                      ? Icons.visibility_outlined
                                      : Icons.visibility_off_outlined,
                                  color:
                                      const Color(0xFF252B37).withOpacity(0.2),
                                  size: 22,
                                ),
                              ),
                            ),
                            style:
                                FlutterFlowTheme.of(context).bodyText1.override(
                                      fontFamily: 'Inter',
                                      color: const Color(0xFF0F0F0F),
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal,
                                    ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 17),
                      child: InkWell(
                        onTap: () {
                          // context.pushNamed("RetrivePassword");
                        },
                        child: Text(
                          "Я забыл пароль",
                          style: TextStyle(
                            color: const Color(0xFF252B37).withOpacity(0.2),
                            fontSize: 16,
                            fontFamily: 'RobotoFlex',
                            fontWeight: FontWeight.w200,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 28),
                      child: Container(
                        width: double.infinity,
                        height: 60,
                        decoration: const BoxDecoration(),
                        child: FFButtonWidget(
                          onPressed: () async {
                            context.read<LoginBloc>().add(LoginAuth(
                                  textController1!.text,
                                  textController2!.text,
                                ));
                          },
                          text: 'Войти',
                          options: FFButtonOptions(
                            width: double.infinity,
                            height: double.infinity,
                            color: const Color(0xFFFFA000),
                            elevation: 0,
                            textStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontFamily: 'RobotoFlex',
                              fontWeight: FontWeight.w400,
                            ),
                            borderSide: const BorderSide(
                              color: Colors.transparent,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => const SignUpWidget()),
                          );
                        },
                        child: Text(
                          "Зарегистрироваться",
                          style: TextStyle(
                            color: const Color(0xFF252B37).withOpacity(0.2),
                            fontSize: 16,
                            fontFamily: 'RobotoFlex',
                            fontWeight: FontWeight.w200,
                            decoration: TextDecoration.underline,
                            decorationColor:
                                const Color(0xFF252B37).withOpacity(0.2),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
