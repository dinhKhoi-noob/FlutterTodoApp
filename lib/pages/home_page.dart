import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: HomePageState());
  }
}

class HomePageState extends StatefulWidget {
  const HomePageState({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePageState> {
  bool _status = true;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.toggledOn;
  DateTime? _selectedDate;
  DateTime _focusedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: AppBar(
                title: const Text(
                  "Work List",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
                backgroundColor: const Color(0xfff96060),
                elevation: 0,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  color: Colors.white,
                  onPressed: () {
                    Navigator.of(context).pop(context);
                  },
                ),
                actions: <Widget>[
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.short_text_rounded))
                ],
              ),
            ),
            Container(
              height: 70,
              color: const Color(0xfff96060),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            _status = false;
                          });
                        },
                        child: const Text(
                          "Today",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 4,
                        width: 120,
                        color: (_status == false)
                            ? Colors.white
                            : Colors.transparent,
                      )
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            _status = true;
                          });
                        },
                        child: const Text(
                          "Monthly",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 4,
                        width: 120,
                        color: (_status == true)
                            ? Colors.white
                            : Colors.transparent,
                      )
                    ],
                  )
                ],
              ),
            ),
            (_status == true)
                ? TableCalendar(
                    focusedDay: _focusedDate,
                    firstDay: DateTime(2020),
                    lastDay: DateTime(2023),
                    startingDayOfWeek: StartingDayOfWeek.monday,
                    rangeStartDay: _rangeStart,
                    rangeEndDay: _rangeEnd,
                    rangeSelectionMode: _rangeSelectionMode,
                    calendarFormat: _calendarFormat,
                    selectedDayPredicate: (date) {
                      return isSameDay(_selectedDate, date);
                    },
                    onPageChanged: (focusedDate) {
                      setState(() {
                        _focusedDate = focusedDate;
                      });
                    },
                    onDaySelected: (selectedDate, focusedDate) {
                      setState(() {
                        _selectedDate = selectedDate;
                        _focusedDate = focusedDate;
                      });
                    },
                    onFormatChanged: (format) {
                      if (_calendarFormat != format) {
                        setState(() {
                          _calendarFormat = format;
                        });
                      }
                    },
                    onRangeSelected: (start, end, focusedDate) {
                      setState(() {
                        _selectedDate = null;
                        _focusedDate = focusedDate;
                        _rangeStart = start;
                        _rangeEnd = end;
                        _rangeSelectionMode = RangeSelectionMode.toggledOn;
                      });
                    },
                  )
                : Column(),
            Expanded(
                child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[Text("Today ${DateFormat.yMMMd().format(DateTime.now())}")],
                    ),
                  )
                ],
              ),
            ))
          ],
        ),
      ],
    );
  }
}
