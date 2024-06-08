import 'package:exstudio/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:scope_function/scope_function.dart';
import 'package:table_calendar/table_calendar.dart';

class SheduleWidget extends StatefulWidget {
  const SheduleWidget({super.key});

  @override
  State<SheduleWidget> createState() => _SheduleWidgetState();
}

class _SheduleWidgetState extends State<SheduleWidget> {
  DateTime selectedDate = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();
  CalendarFormat _calendarFormat = CalendarFormat.month;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
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
                            borderRadius: BorderRadius.all(Radius.circular(6)),
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
                              headerPadding: EdgeInsets.symmetric(vertical: 2),
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
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: 5,
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
                              padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Сведение',
                                        style: TextStyle(
                                          fontFamily: 'BebasNeue',
                                          color: Color(0xFF000000),
                                          fontSize: 29,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                      Text(
                                        '18:40-19:00',
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
                                    "Ice",
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
                                      itemCount: 2,
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
                                                margin:
                                                    EdgeInsets.only(right: 4),
                                                decoration: BoxDecoration(
                                                  color: Color(0xff8D40FF),
                                                  shape: BoxShape.circle,
                                                ),
                                              ),
                                              Text(
                                                'smokeynagato',
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
                                  SizedBox(height: 12),
                                ],
                              ),
                            ),
                          );
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
    );
  }
}
