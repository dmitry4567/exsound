import 'package:exstudio/flutter_flow/flutter_flow_util.dart';
import 'package:exstudio/sign_up/bloc/register_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../backend/api_requests/api_calls.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';

class SignUpWidget extends StatefulWidget {
  const SignUpWidget({Key? key}) : super(key: key);

  @override
  _SignUpWidgetState createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<SignUpWidget> {
  ApiCallResponse? singUpResult;
  TextEditingController? textController1;
  TextEditingController? textController2;
  TextEditingController? textController3;
  TextEditingController? textController4;
  TextEditingController? textController5;

  late bool passwordVisibility;
  late bool againPasswordVisibility;
  // late bool privacyLicenseBool;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    textController1 = TextEditingController();
    textController2 = TextEditingController();
    textController3 = TextEditingController();
    textController4 = TextEditingController();
    textController5 = TextEditingController();
    passwordVisibility = false;
    againPasswordVisibility = false;
    // privacyLicenseBool = false;
  }

  @override
  void dispose() {
    textController1?.dispose();
    textController2?.dispose();
    textController3?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final safeAreaBottom = MediaQuery.of(context).padding.top;
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      body: BlocListener<RegisterBloc, RegisterState>(
        listener: (context, state) {
          if (state is RegisterError) {
            ScaffoldMessenger.of(context)
                .showSnackBar(functions.setupSnackBar(state.error));
          }
          if (state is RegisterPass) {
            context.goNamed('signIn');
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
                    top: safeAreaBottom + 70, left: 33, right: 33),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const Text(
                      'Регистрация',
                      style: TextStyle(
                        color: Color.fromRGBO(37, 43, 55, 0.8),
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
                              hintText: 'ФИО',
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
                                  color: Color(0x00000000),
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
                          ),
                        ),
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
                            controller: textController2,
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
                                  color: Color(0x00000000),
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
                            controller: textController3,
                            autofocus: true,
                            obscureText: false,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.alternate_email,
                                  color: Color(0xFFFFA000), size: 22),
                              hintText: 'Ваш Telegram',
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
                                  color: Color(0x00000000),
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
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 50),
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
                            controller: textController4,
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
                                  color: Color(0xffFF4B4B),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Color(0xffFF4B4B),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(16),
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
                            controller: textController5,
                            autofocus: true,
                            obscureText: !againPasswordVisibility,
                            decoration: InputDecoration(
                              hintText: 'Повторите пароль',
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
                                  color: Color(0xffFF4B4B),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Color(0xffFF4B4B),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding:
                                  const EdgeInsetsDirectional.fromSTEB(
                                      16, 14, 16, 14),
                              suffixIcon: InkWell(
                                onTap: () => setState(
                                  () => againPasswordVisibility =
                                      !againPasswordVisibility,
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
                    // Padding(
                    //   padding: const EdgeInsets.only(top: 10),
                    //   child: SizedBox(
                    //     width: double.infinity,
                    //     child: Column(
                    //       mainAxisSize: MainAxisSize.max,
                    //       children: [
                    //         Row(
                    //           mainAxisSize: MainAxisSize.max,
                    //           mainAxisAlignment: MainAxisAlignment.start,
                    //           crossAxisAlignment: CrossAxisAlignment.start,
                    //           children: [
                    //             Expanded(
                    //               child: Padding(
                    //                 padding: const EdgeInsetsDirectional.fromSTEB(
                    //                     0, 15, 32, 0),
                    //                 child: Container(
                    //                   width: 100,
                    //                   decoration: const BoxDecoration(
                    //                     color: Colors.white,
                    //                   ),
                    //                   child: Column(
                    //                     mainAxisSize: MainAxisSize.max,
                    //                     crossAxisAlignment:
                    //                         CrossAxisAlignment.start,
                    //                     children: [
                    //                       Text(
                    //                         'Настоящим подтверждаю, что я ознакомлен и согласен с условиями ',
                    //                         style: FlutterFlowTheme.of(context)
                    //                             .bodyText1
                    //                             .override(
                    //                               fontFamily: 'Inter',
                    //                               color: Colors.black,
                    //                               fontWeight: FontWeight.w400,
                    //                               lineHeight: 1.4,
                    //                             ),
                    //                       ),
                    //                       InkWell(
                    //                         onTap: () async {
                    //                           await launchURL(
                    //                               'https://pages.flycricket.io/rupl/privacy.html');
                    //                         },
                    //                         child: Text(
                    //                           'политики конфиденциальности',
                    //                           style: TextStyle(
                    //                             fontFamily: 'Inter',
                    //                             color:
                    //                                 FlutterFlowTheme.of(context)
                    //                                     .bitterLemon,
                    //                             fontWeight: FontWeight.w400,
                    //                             height: 1.4,
                    //                             decoration:
                    //                                 TextDecoration.underline,
                    //                             decorationColor:
                    //                                 FlutterFlowTheme.of(context)
                    //                                     .bitterLemon,
                    //                           ),
                    //                         ),
                    //                       ),
                    //                     ],
                    //                   ),
                    //                 ),
                    //               ),
                    // // //             ),
                    // //           ],
                    // //         ),
                    //       ],
                    // //     ),
                    // //   ),
                    // // ),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0, 35, 0, 0),
                      child: Container(
                        width: double.infinity,
                        height: 56,
                        decoration: const BoxDecoration(),
                        child: FFButtonWidget(
                          onPressed: () {
                            context.read<RegisterBloc>().add(RegisterAuth(
                                  textController1!.text,
                                  textController2!.text,
                                  textController3!.text,
                                  textController4!.text,
                                ));
                          },
                          text: 'Зарегистрироваться',
                          options: FFButtonOptions(
                            width: double.infinity,
                            height: double.infinity,
                            elevation: 0,
                            color: const Color(0xFFFFA000),
                            textStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontFamily: 'RobotoFlex',
                              fontWeight: FontWeight.w200,
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
