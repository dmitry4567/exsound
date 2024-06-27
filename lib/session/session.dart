import 'package:exstudio/backend/api_requests/api_calls.dart';
import 'package:exstudio/flutter_flow/flutter_flow_theme.dart';
import 'package:exstudio/flutter_flow/flutter_flow_widgets.dart';
import 'package:exstudio/session/cubit/session_cubit.dart';
import 'package:exstudio/session/cubit/session_state.dart';
import 'package:exstudio/session/widgets/admin/choose_admin.dart';
import 'package:exstudio/session/widgets/type/choose_type.dart';
import 'package:exstudio/flutter_flow/flutter_flow_util.dart';
import 'package:exstudio/session/widgets/model.dart';
import 'package:exstudio/shedule/bloc/schedule_bloc.dart';
import 'package:exstudio/shedule/model/studio_session_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../flutter_flow/custom_functions.dart' as functions;
import 'package:bottom_sheet/bottom_sheet.dart';

class AddSession extends StatefulWidget {
  const AddSession({super.key});

  @override
  State<AddSession> createState() => _AddSessionState();
}

class _AddSessionState extends State<AddSession> {
  final ExpandableListData typeNotifier = ExpandableListData();

  final formatter = DateFormat('HH:mm');

  int startOfMonth = DateTime.now().month;

  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();
  CalendarFormat _calendarFormat = CalendarFormat.month;

  var textController2;

  Future<dynamic> getData() async {
    final fromValue = DateTime.now().millisecondsSinceEpoch;
    final tempTime = DateTime.fromMillisecondsSinceEpoch(fromValue);

    final fromTime = DateTime(
      tempTime.year,
      tempTime.month,
      tempTime.day,
    ).millisecondsSinceEpoch;
    final toTime = DateTime(
          tempTime.year,
          tempTime.month,
          tempTime.day,
        ).add(Duration(days: 1)).millisecondsSinceEpoch -
        1;

    final sessions = await GetSessionsByTimePeriod.call(
      from: fromTime,
      until: toTime,
    );

    if (sessions.succeeded) {
      return sessions.jsonBody
          .map((project) => StudioSessions.fromJson(project))
          .toList();
    }

    return null;
  }

  @override
  void initState() {
    super.initState();

    DateTime startDate =
        DateTime(_selectedDay.year, _selectedDay.month, _selectedDay.day);

    context.read<ScheduleBloc>().add(ScheduleGetData(
        startDate.millisecondsSinceEpoch,
        startDate.add(Duration(days: 1)).millisecondsSinceEpoch - 1));
  }

  void showModalType(context) {
    showFlexibleBottomSheet(
      bottomSheetColor: Colors.transparent,
      minHeight: 0,
      initHeight: 1,
      maxHeight: 1,
      duration: Duration(milliseconds: 500),
      context: context,
      builder: (BuildContext context, ScrollController controller, double d) {
        return ChooseTypeWidget(context: context);
      },
      anchors: [0, 0.5, 1],
      isSafeArea: true,
    );
  }

  void showModalAdmin(context) {
    showFlexibleBottomSheet(
      bottomSheetColor: Colors.transparent,
      minHeight: 0,
      initHeight: 1,
      maxHeight: 1,
      duration: Duration(milliseconds: 500),
      context: context,
      builder: (BuildContext context, ScrollController controller, double d) {
        return ChooseAdminWidget(context: context);
      },
      anchors: [0, 0.5, 1],
      isSafeArea: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocListener<ScheduleBloc, ScheduleState>(
        listener: (context, state) {
          if (state is ScheduleError) {
            ScaffoldMessenger.of(context)
                .showSnackBar(functions.setupSnackBar(state.error));
          }
        },
        child: SafeArea(
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: CustomScrollView(
                physics: BouncingScrollPhysics(),
                slivers: <Widget>[
                  SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 11),
                        Text(
                          'выберите день',
                          style: TextStyle(
                            fontFamily: 'BebasNeue',
                            color: Color(0xFF000000),
                            fontSize: 35,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        SizedBox(height: 14),
                        Visibility(
                          visible: true,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                width: 1,
                                color: Color(0xffCBD4DD),
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(6)),
                            ),
                            child: TableCalendar(
                              daysOfWeekVisible: false,
                              firstDay: DateTime(1947),
                              lastDay: DateTime(2030),
                              focusedDay: _focusedDay,
                              calendarFormat: _calendarFormat,
                              selectedDayPredicate: (day) {
                                return isSameDay(_selectedDay, day);
                              },
                              onDaySelected: (selectedDay, focusedDay) {
                                if (!isSameDay(_selectedDay, selectedDay)) {
                                  setState(() {
                                    _selectedDay = selectedDay;
                                    _focusedDay = focusedDay;
                                  });

                                  context.read<ScheduleBloc>().add(
                                      ScheduleGetData(
                                          selectedDay.millisecondsSinceEpoch,
                                          selectedDay
                                                  .add(Duration(days: 1))
                                                  .millisecondsSinceEpoch -
                                              1));

                                  context
                                      .read<SessionCubit>()
                                      .updateDay(selectedDay);
                                }
                              },
                              onFormatChanged: (format) {
                                if (_calendarFormat != format) {
                                  setState(() {
                                    _calendarFormat = format;
                                  });
                                }
                              },
                              onPageChanged: (focusedDay) {
                                _focusedDay = focusedDay;
                              },
                              headerStyle: HeaderStyle(
                                headerPadding:
                                    EdgeInsets.symmetric(vertical: 2),
                                leftChevronIcon: Icon(
                                  Icons.chevron_left,
                                  color: Color(0xFF9EADBD),
                                  size: 28,
                                ),
                                rightChevronIcon: Icon(
                                  Icons.chevron_right,
                                  color: Color(0xFF9EADBD),
                                  size: 28,
                                ),
                                titleCentered: true,
                                titleTextFormatter: (date, locale) =>
                                    DateFormat.MMMM(
                                            Localizations.localeOf(context)
                                                .languageCode)
                                        .format(date)
                                        .toUpperCase(),
                                formatButtonVisible: false,
                                titleTextStyle: TextStyle(
                                  fontFamily: 'BebasNeue',
                                  color: Color(0xFF9EADBD),
                                  fontWeight: FontWeight.w400,
                                  fontSize: 22,
                                ),
                              ),
                              calendarStyle: const CalendarStyle(
                                outsideTextStyle: TextStyle(
                                  fontFamily: 'BebasNeue',
                                  color: Color(0xff9EADBD),
                                  fontSize: 20,
                                ),
                                holidayTextStyle: TextStyle(
                                  fontFamily: 'BebasNeue',
                                  fontSize: 20,
                                ),
                                weekendTextStyle: TextStyle(
                                  fontFamily: 'BebasNeue',
                                  fontSize: 20,
                                ),
                                defaultTextStyle: TextStyle(
                                  fontFamily: 'BebasNeue',
                                  fontSize: 20,
                                ),
                                todayTextStyle: TextStyle(
                                  fontFamily: 'BebasNeue',
                                  fontSize: 20,
                                  color: Color(0xff8D40FF),
                                ),
                                selectedTextStyle: TextStyle(
                                  fontFamily: 'BebasNeue',
                                  fontSize: 20,
                                  color: Color(0xff8D40FF),
                                ),
                                selectedDecoration: BoxDecoration(
                                  color: Color(0x338D40FF),
                                  shape: BoxShape.circle,
                                ),
                                todayDecoration: BoxDecoration(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        SizedBox(height: 16),
                        Text(
                          'Сессии',
                          style: TextStyle(
                            fontFamily: 'BebasNeue',
                            color: Color(0xFF000000),
                            fontSize: 35,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        SizedBox(height: 16),
                        BlocBuilder<ScheduleBloc, ScheduleState>(
                          builder: (context, state) {
                            if (state is ScheduleDataPass) {
                              return ListView.builder(
                                shrinkWrap: true,
                                itemCount: state.data.length,
                                physics: ClampingScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return Container(
                                    margin: EdgeInsets.only(bottom: 20),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        width: 1,
                                        color: Color(0xffCBD4DD),
                                      ),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(6)),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          16, 8, 16, 0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                state.data[index].typeOfActivity
                                                    .name,
                                                style: TextStyle(
                                                  fontFamily: 'BebasNeue',
                                                  color: Color(0xFF000000),
                                                  fontSize: 29,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                              ),
                                              Text(
                                                '${formatter.format(state.data[index].from)}-${formatter.format(state.data[index].until)}',
                                                style: TextStyle(
                                                  fontFamily: 'BebasNeue',
                                                  color: Color(0xFF000000),
                                                  fontSize: 29,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Text(
                                            state.data[index].nameTrack,
                                            style: TextStyle(
                                              fontFamily: 'BebasNeue',
                                              color: Color(0xFF9EADBD),
                                              fontSize: 20,
                                              height: 1,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                          SizedBox(height: 18),
                                          Text(
                                            "Админы",
                                            style: TextStyle(
                                              fontFamily: 'Inter',
                                              color: Color(0xFF9EADBD),
                                              fontSize: 13,
                                              height: 1,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                          SizedBox(height: 12),
                                          Container(
                                            child: ListView.builder(
                                              itemCount: state.data[index]
                                                  .userAdmins.length,
                                              shrinkWrap: true,
                                              itemBuilder: (context, index2) {
                                                return Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 6),
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Container(
                                                        width: 18,
                                                        height: 18,
                                                        margin: EdgeInsets.only(
                                                            right: 4),
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              Color(0xff8D40FF),
                                                          shape:
                                                              BoxShape.circle,
                                                        ),
                                                      ),
                                                      Text(
                                                        state
                                                            .data[index]
                                                            .userAdmins[index2]
                                                            .nickname,
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'BebasNeue',
                                                          color:
                                                              Color(0xFF000000),
                                                          fontSize: 22,
                                                          height: 0.99,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                          SizedBox(height: 12),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            } else if (state is ScheduleGettingData) {
                              return Center(
                                child: CircularProgressIndicator(
                                  color: Color(0xff8D40FF),
                                ),
                              );
                            } else if (state is ScheduleDataEmpty) {
                              return Center(
                                child: Column(
                                  children: [
                                    SvgPicture.asset("assets/icons/volume.svg"),
                                    SizedBox(height: 15),
                                    Text(
                                      "на этот день пусто",
                                      style: TextStyle(
                                        fontFamily: 'BebasNeue',
                                        color: Color(0xFF9EADBD),
                                        fontSize: 30,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            } else if (state is ScheduleError) {
                              return Text("Ошибка получения данных");
                            }
                            return Container();
                          },
                        ),
                        SizedBox(height: 16),
                        Text(
                          'информация о сессии',
                          style: TextStyle(
                            fontFamily: 'BebasNeue',
                            color: Color(0xFF000000),
                            fontSize: 35,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        SizedBox(height: 14),
                        Text(
                          "Время",
                          style: TextStyle(
                            color: Color(0xff9EADBD),
                            fontSize: 14,
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: 10),
                        GestureDetector(
                            onTap: () async {
                              final cubit = Provider.of<SessionCubit>(context,
                                  listen: false);

                              final selectedToTime = await showTimePicker(
                                helpText: "С какого времени?",
                                initialTime: TimeOfDay.now(),
                                context: context,
                              );

                              final selectedUntilTime2 = await showTimePicker(
                                helpText: "До какого времени?",
                                initialTime: TimeOfDay.now(),
                                context: context,
                              );

                              cubit.updateTime(
                                  selectedToTime, selectedUntilTime2);
                            },
                            child: BlocBuilder<SessionCubit, Session>(
                                buildWhen: (previous, current) {
                              return previous.to != current.to ||
                                  previous.until != current.until;
                            }, builder: (context, state) {
                              return Text(
                                "${state.to.format(context)}-${state.until.format(context)}",
                                style: TextStyle(
                                  color: Color(0xffCBD4DD),
                                  fontSize: 30,
                                  fontFamily: "BebasNeue",
                                  fontWeight: FontWeight.w400,
                                  height: 1,
                                ),
                              );
                            })),
                        SizedBox(height: 14),
                        Text(
                          "Тип",
                          style: TextStyle(
                            color: Color(0xff9EADBD),
                            fontSize: 14,
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: 10),
                        Material(
                          borderRadius: BorderRadius.circular(4.0),
                          clipBehavior: Clip.hardEdge,
                          child: InkWell(
                            onTap: () {
                              showModalType(context);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4.0),
                                  color: Colors.white,
                                  border: Border.all(
                                      color: Color(0xffCBD4DD), width: 1.0)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 12, horizontal: 16.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        BlocBuilder<SessionCubit, Session>(
                                          buildWhen: (previous, current) {
                                            return previous.type !=
                                                current.type;
                                          },
                                          builder: (context, state) {
                                            return Text(
                                              state.type,
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontStyle: FontStyle.normal,
                                                  color: Colors.black),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 14),
                        Text(
                          "Название трека",
                          style: TextStyle(
                            color: Color(0xff9EADBD),
                            fontSize: 14,
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          width: double.infinity,
                          height: 56,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Align(
                            alignment: const AlignmentDirectional(0, 0),
                            child: TextFormField(
                              controller: textController2,
                              onChanged: (nameTrack) => context
                                  .read<SessionCubit>()
                                  .updateNameTrack(nameTrack),
                              decoration: InputDecoration(
                                hintText: '',
                                hintStyle: TextStyle(
                                  color: Color(0xff9EADBD),
                                  fontSize: 16,
                                  fontFamily: 'RobotoFlex',
                                  fontWeight: FontWeight.w400,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: const Color(0xffCBD4DD),
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Color(0xFF8D40FF),
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(4),
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
                                    color: Color(0x00000000),
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding:
                                    const EdgeInsetsDirectional.fromSTEB(
                                        16, 14, 16, 14),
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'Inter',
                                    color: const Color(0xFF0F0F0F),
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal,
                                  ),
                            ),
                          ),
                        ),
                        SizedBox(height: 14),
                        Text(
                          "Админы",
                          style: TextStyle(
                            color: Color(0xff9EADBD),
                            fontSize: 14,
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: 10),
                        BlocBuilder<SessionCubit, Session>(
                          buildWhen: (previous, current) =>
                              previous.admins != current.admins,
                          builder: (context, state) {
                            if (state.admins.isEmpty) {
                              return MaterialButton(
                                onPressed: () {
                                  showModalAdmin(context);
                                },
                                height: 56,
                                color: Color(0xffCBD4DD),
                                child: Center(
                                  child: Icon(
                                    Icons.add,
                                    size: 32,
                                    color: Colors.white,
                                  ),
                                ),
                              );
                            } else {
                              return GestureDetector(
                                onTap: () {
                                  showModalAdmin(context);
                                },
                                child: Container(
                                  child: ListView.builder(
                                    itemCount: state.admins.length,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 6),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: 18,
                                              height: 18,
                                              margin: EdgeInsets.only(right: 4),
                                              decoration: BoxDecoration(
                                                color: Color(0xff8D40FF),
                                                shape: BoxShape.circle,
                                              ),
                                            ),
                                            Text(
                                              state.admins[index],
                                              style: TextStyle(
                                                fontFamily: 'BebasNeue',
                                                color: Color(0xFF000000),
                                                fontSize: 22,
                                                height: 0.99,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              );
                            }
                          },
                        ),
                        SizedBox(height: 32),
                        Container(
                          width: double.infinity,
                          child: FFButtonWidget(
                            onPressed: () async {
                              context
                                  .read<SessionCubit>()
                                  .createSession(context);
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
                        SizedBox(height: 24),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
