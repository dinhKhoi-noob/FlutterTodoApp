import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import './new_check_list_page.dart';
import './new_task_page.dart';
import './new_quick_note_page.dart';
import '../animation/new_screen_navigator_route.dart';

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
  void _navigateToNewScreen(String pageName) {
    Widget destination = const NewCheckListPage();
    if (pageName == 'new_task') {
      destination = const NewTaskPage();
    }
    if (pageName == 'new_quick_note') {
      destination = const NewQuickNotePage();
    }
    Navigator.push(context, NewScreenNavigatorRoute(child: destination));
  }

  void _openPopup(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Container(
              height: 192,
              width: 200,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Center(
                child: Column(
                  children: <Widget>[
                    InkWell(
                      child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          width: 180,
                          decoration: const BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                            color: Colors.black,
                          ))),
                          child: const Center(
                              child: Text(
                            "New Task",
                            style: TextStyle(fontSize: 22),
                          ))),
                      onTap: () {
                        _navigateToNewScreen("new_task");
                      },
                    ),
                    InkWell(
                      child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          width: 180,
                          decoration: const BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                            color: Colors.black,
                          ))),
                          child: const Center(
                              child: Text(
                            "New Quick Note",
                            style: TextStyle(fontSize: 22),
                          ))),
                      onTap: () {
                        _navigateToNewScreen("new_quick_note");
                      },
                    ),
                    InkWell(
                      child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          width: 180,
                          decoration: const BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                            color: Colors.black,
                          ))),
                          child: const Center(
                              child: Text(
                            "New Check List",
                            style: TextStyle(fontSize: 22),
                          ))),
                      onTap: () {
                        _navigateToNewScreen("new_check_list");
                      },
                    ),
                  ],
                ),
              ),
            ),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
          );
        });
  }

  Slidable taskWidget(Color color, String title, String time) {
    return Slidable(
      actionPane: const SlidableDrawerActionPane(),
      child: Container(
        height: 80,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.03),
              offset: const Offset(0, 9),
              blurRadius: 20,
              spreadRadius: 1)
        ]),
        child: Row(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              height: 25,
              width: 25,
              decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(color: color, width: 4)),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(title,
                    style: const TextStyle(color: Colors.black, fontSize: 18)),
                Text(
                  time,
                  style: TextStyle(
                      color: Colors.black.withOpacity(0.5), fontSize: 16),
                )
              ],
            ),
            Expanded(child: Container()),
            Container(
                margin: const EdgeInsets.only(right: 5),
                height: 50,
                width: 5,
                color: color)
          ],
        ),
      ),
      secondaryActions: <Widget>[
        SizedBox(
            height: 80,
            child: IconSlideAction(
              caption: "Edit",
              color: Colors.blue,
              icon: Icons.edit,
              onTap: () {},
            )),
        SizedBox(
            height: 80,
            child: IconSlideAction(
              caption: "Delete",
              color: Colors.red,
              icon: Icons.delete,
              onTap: () {},
            )),
      ],
    );
  }

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
                      children: <Widget>[
                        Text(
                            "Today ${DateFormat.yMMMd().format(DateTime.now())}")
                      ],
                    ),
                  ),
                  taskWidget(const Color(0xfff96060),
                      "Have a meeting with dev team", "9:00 AM"),
                  taskWidget(Colors.blue, "Play team fight tactic", "8:00 PM"),
                  taskWidget(Colors.yellow, "Watch movies", "15:00 PM")
                ],
              ),
            )),
            SizedBox(
              height: 100,
              child: Stack(
                children: <Widget>[
                  Positioned(
                      bottom: 0,
                      child: Container(
                        height: 90,
                        width: MediaQuery.of(context).size.width,
                        color: const Color(0xff292e4e),
                        padding: const EdgeInsets.all(20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                InkWell(
                                  onTap: () {},
                                  child: Column(
                                    children: const <Widget>[
                                      Icon(Icons.check_circle,
                                          color: Colors.white),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "My Tasks",
                                        style: TextStyle(color: Colors.white),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                InkWell(
                                  onTap: () {},
                                  child: Column(
                                    children: const <Widget>[
                                      Icon(Icons.menu_rounded,
                                          color: Colors.white),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "Menu",
                                        style: TextStyle(color: Colors.white),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              width: 80,
                            ),
                            Column(
                              children: <Widget>[
                                InkWell(
                                  onTap: () {},
                                  child: Column(
                                    children: const <Widget>[
                                      Icon(Icons.content_paste,
                                          color: Colors.white),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "Quick",
                                        style: TextStyle(color: Colors.white),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                InkWell(
                                  onTap: () {},
                                  child: Column(
                                    children: const <Widget>[
                                      Icon(Icons.account_circle_outlined,
                                          color: Colors.white),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "Profile",
                                        style: TextStyle(color: Colors.white),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      )),
                  Positioned(
                      bottom: 5,
                      right: 0,
                      left: 15,
                      child: InkWell(
                          onTap: () {
                            _openPopup(context);
                          },
                          child: Container(
                            height: 80,
                            width: 80,
                            decoration: const BoxDecoration(
                                color: Color(0xfff96060),
                                shape: BoxShape.circle),
                            child: const Icon(Icons.add,
                                color: Colors.white, size: 40),
                          )))
                ],
              ),
            )
          ],
        ),
      ],
    );
  }
}
