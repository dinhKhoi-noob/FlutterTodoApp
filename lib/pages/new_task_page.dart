import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTaskPage extends StatelessWidget {
  const NewTaskPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xfff96060),
        title: const Text(
          "New Task",
          style: TextStyle(
              color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),
      body: const NewTaskPageState(),
    );
  }
}

class NewTaskPageState extends StatefulWidget {
  const NewTaskPageState({Key? key}) : super(key: key);

  @override
  State<NewTaskPageState> createState() {
    return _NewTaskPageState();
  }
}

class _NewTaskPageState extends State<NewTaskPageState> {
  DateTime _selectedDate = DateTime.now();
  List<String> _assigneeList = ["John", "Harry", "Jenny"];

  Future<void> _openDatePicker(BuildContext context) async {
    final DateTime? datePicked = await showDatePicker(
        context: context,
        initialDate: _selectedDate,
        firstDate: DateTime(2020),
        lastDate: DateTime(2025));
    if (datePicked != null || datePicked != _selectedDate) {
      setState(() {
        _selectedDate = datePicked!;
      });
    }
  }

  Widget _renderAssigneeList() {
    List<Widget> _assigneeListWidget = _assigneeList
        .map((assignee) => Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: const BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.all(Radius.circular(5))),
            child: Text(
              assignee,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            )))
        .toList();
    Widget _addNewAssigneeButton = Container(
        child:
            IconButton(onPressed: () {}, icon: const Icon(Icons.add_circle)));
    _assigneeListWidget.add(_addNewAssigneeButton);
    return Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        children: _assigneeListWidget);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Stack(children: <Widget>[
        Container(height: 30, color: const Color(0xfff96060)),
        Positioned(
            bottom: 0,
            child: Container(
              height: 70,
              width: MediaQuery.of(context).size.width,
              color: Colors.black.withOpacity(0.8),
            )),
        Container(
          height: MediaQuery.of(context).size.height,
          margin: const EdgeInsets.fromLTRB(30, 0, 30, 20),
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              color: Colors.white),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  "Title",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.9),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: TextField(
                    decoration: const InputDecoration(
                        fillColor: Color(0xfffafafa),
                        filled: true,
                        hintText: "Example: Meet friend",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            gapPadding: 3)),
                    onChanged: (text) {},
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 30),
                  child: const Text(
                    "Description",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.9),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: TextField(
                    maxLines: 4,
                    minLines: 4,
                    decoration: const InputDecoration(
                        fillColor: Color(0xfffafafa),
                        filled: true,
                        hintText: "Enter Description",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            gapPadding: 3)),
                    onChanged: (text) {},
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Text(
                        "Due Date :",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        DateFormat.yMMMd().format(_selectedDate),
                        style: const TextStyle(fontSize: 16),
                      ),
                      IconButton(
                          onPressed: () {
                            _openDatePicker(context);
                          },
                          icon: const Icon(Icons.date_range))
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: const Text(
                    "Assignee",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: _renderAssigneeList(),
                ),
                Center(
                  child: InkWell(
                    onTap: () {
                      print("Hello");
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 30),
                      padding:const EdgeInsets.symmetric(horizontal: 100, vertical: 20),
                      decoration: const BoxDecoration(color: Color(0xfff96060)),
                      child: const Text(
                        "Create",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                          ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        )
      ]),
    );
  }
}
