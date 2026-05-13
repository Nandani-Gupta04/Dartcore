import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatefulWidget {
  
  const Calendar({super.key});

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
   DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF4F7FF),
      appBar: AppBar(
        elevation: 4,
        title: Text('Calendar App',style: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: Colors.blueAccent,
        ),
        ),
        centerTitle: true,
      ),

      body: 

      Center(
child: TableCalendar(
  focusedDay: _focusedDay,
 firstDay: DateTime.utc(1999,1,1), 
 lastDay: DateTime.utc(2040,12,31),
 selectedDayPredicate:  (day) {
            return isSameDay(_selectedDay, day);
          },
onDaySelected: (selectedDay, focusedDay) => setState(() {
   _selectedDay = selectedDay;
              _focusedDay = focusedDay;
}
),
 ),
      ),
    );
  }
}