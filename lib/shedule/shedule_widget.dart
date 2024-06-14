import 'dart:developer';
import 'dart:ffi';

import 'package:exstudio/shedule/bloc/schedule_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../flutter_flow/custom_functions.dart' as functions;
import 'package:exstudio/backend/api_requests/api_calls.dart';
import 'package:exstudio/flutter_flow/flutter_flow_util.dart';
import 'package:exstudio/shedule/model/studio_session_model.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class SheduleWidget extends StatefulWidget {
  const SheduleWidget({super.key});

  @override
  State<SheduleWidget> createState() => _SheduleWidgetState();
}

class _SheduleWidgetState extends State<SheduleWidget> {
  final formatter = DateFormat('HH:mm');

  int startOfMonth = DateTime.now().month;

  DateTime selectedDate = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();
  CalendarFormat _calendarFormat = CalendarFormat.month;

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

  void initState() {
    super.initState();

    context.read<ScheduleBloc>().add(ScheduleGetData(
        selectedDate.millisecondsSinceEpoch,
        selectedDate.add(Duration(days: 1)).millisecondsSinceEpoch - 1));
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
                          'расписание',
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
                                  log(selectedDay.millisecondsSinceEpoch
                                      .toString());
                                  log((selectedDay
                                              .add(Duration(days: 1))
                                              .millisecondsSinceEpoch -
                                          1)
                                      .toString());
                                  context.read<ScheduleBloc>().add(
                                      ScheduleGetData(
                                          selectedDay.millisecondsSinceEpoch,
                                          selectedDay
                                                  .add(Duration(days: 1))
                                                  .millisecondsSinceEpoch -
                                              1));
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
                            }
                            return Text("fsef");
                          },
                        ),
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
