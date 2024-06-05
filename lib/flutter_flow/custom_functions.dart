import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

String getFormatterTimeString(DateTime workoutTime) {
  var currentDayOfWeek = "";

  switch (workoutTime.weekday) {
    case 1:
      {
        currentDayOfWeek = "Понедельник";
      }
      break;
    case 2:
      {
        currentDayOfWeek = "Вторник";
      }
      break;
    case 3:
      {
        currentDayOfWeek = "Среда";
      }
      break;
    case 4:
      {
        currentDayOfWeek = "Четверг";
      }
      break;
    case 5:
      {
        currentDayOfWeek = "Пятница";
      }
      break;
    case 6:
      {
        currentDayOfWeek = "Суббота";
      }
      break;
    case 7:
      {
        currentDayOfWeek = "Воскресенье";
      }
      break;
  }

  var text = DateFormat(', HH:mm / dd.MM.y').format(workoutTime);

  return currentDayOfWeek + text;
}

bool resultCodeSuccess(int status) {
  if (status >= 400 && status < 500) {
    return false;
  } else {
    return true;
  }
}

SnackBar setupSnackBar(String text) {
  return SnackBar(
    content: Row(children: [
      const Icon(
        Icons.error_outline,
        color: Colors.white,
        size: 21,
      ),
      Expanded(
          child: Padding(
              padding: const EdgeInsets.only(left: 12),
              child: Text(
                text,
                style: GoogleFonts.getFont(
                  'Roboto Flex',
                  color: Colors.white,
                  fontSize: 16,
                ),
              )))
    ]),
    duration: const Duration(milliseconds: 4000),
    backgroundColor: Colors.red,
  );
}
