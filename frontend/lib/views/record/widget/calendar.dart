import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatefulWidget {
  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  DateTime selectedDate = DateTime.now(); // Use now() to ensure it's local time
  DateTime focusedDate = DateTime.now(); // Initially focus on today

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: IconButton(
                icon: Icon(Icons.chevron_left_rounded),
                onPressed: () {
                  setState(() {
                    focusedDate =
                        DateTime(focusedDate.year, focusedDate.month - 1);
                  });
                },
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                DateFormat('yyyy.MM').format(focusedDate),
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 22),
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              child: IconButton(
                icon: Icon(Icons.chevron_right_rounded),
                onPressed: () {
                  setState(() {
                    focusedDate =
                        DateTime(focusedDate.year, focusedDate.month + 1);
                  });
                },
              ),
            ),
          ],
        ),
        TableCalendar(
          onDaySelected: onDaySelected,
          selectedDayPredicate: (date) => isSameDay(selectedDate, date),
          focusedDay: focusedDate,
          firstDay: DateTime(2024, 1, 1),
          lastDay: DateTime(2025, 1, 31),
          calendarStyle: CalendarStyle(outsideDaysVisible: false),
          headerStyle: HeaderStyle(
            titleTextFormatter: (date, locale) => "",
            formatButtonVisible: false,
            leftChevronVisible: false,
            rightChevronVisible: false,
            headerMargin: EdgeInsets.only(bottom: 1),
            titleTextStyle: TextStyle(
              fontSize: 0,
            ),
          ),
          daysOfWeekStyle: DaysOfWeekStyle(
            weekdayStyle: TextStyle(
                color: Color(0xFF6C7072).withOpacity(0.5), fontSize: 13),
            weekendStyle: TextStyle(
                color: Color(0xFF6C7072).withOpacity(0.5), fontSize: 13),
            dowTextFormatter: (date, locale) =>
                DateFormat.E(locale).format(date)[0],
          ),
          daysOfWeekHeight: 44,
        ),
      ],
    );
  }

  void onDaySelected(DateTime selected, DateTime focused) {
    setState(() {
      selectedDate = selected;
      focusedDate = focused;
    });
  }
}
