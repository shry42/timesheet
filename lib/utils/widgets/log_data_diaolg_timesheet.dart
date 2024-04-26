import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:timesheet/common/models/hr_models/get_timesheet_log_model.dart';

class Dialog_log_timesheet_screen extends StatefulWidget {
  const Dialog_log_timesheet_screen({
    super.key,
    required this.projectName,
    required this.taskName,
    required this.attrName,
    required this.projectId,
    required this.taskId,
    required this.attrId,
    required this.mon,
    required this.tue,
    required this.wed,
    required this.thu,
    required this.fri,
    required this.sat,
    required this.description,
    // required this.index,
    // required this.entry,
    required this.updateNewEntry,
    this.date1,
    this.date2,
    this.date3,
    this.date4,
    this.date5,
    this.date6,
    this.departmentId,
    this.logId,
  });

  final String projectName;
  final String taskName;
  final String attrName;
  final String description;

  final String mon;
  final String tue;
  final String wed;
  final String thu;
  final String fri;
  final String sat;

  final int projectId;
  final int taskId;
  final int attrId;
  // final int index;
  // final TimesheetEntry entry;
  final String? date1;
  final String? date2;
  final String? date3;
  final String? date4;
  final String? date5;
  final String? date6;
  final int? departmentId;
  final int? logId;

  final Function(TimesheetEntry) updateNewEntry;

//

//
  @override
  State<Dialog_log_timesheet_screen> createState() =>
      _Dialog_log_timesheet_screenState();
}

class _Dialog_log_timesheet_screenState
    extends State<Dialog_log_timesheet_screen> {
  TextEditingController projectNamecont = TextEditingController();
  TextEditingController taskNamecont = TextEditingController();
  TextEditingController attrNamecont = TextEditingController();
  TextEditingController decriptionCont = TextEditingController();

  TextEditingController monCont = TextEditingController();
  TextEditingController tueCont = TextEditingController();
  TextEditingController wedCont = TextEditingController();
  TextEditingController thuCont = TextEditingController();
  TextEditingController friCont = TextEditingController();
  TextEditingController satCont = TextEditingController();

  void updateTimesheetEntry() {
    final monHours = int.tryParse(monCont.text) ?? 0;
    final tueHours = int.tryParse(tueCont.text) ?? 0;
    final wedHours = int.tryParse(wedCont.text) ?? 0;
    final thuHours = int.tryParse(thuCont.text) ?? 0;
    final friHours = int.tryParse(friCont.text) ?? 0;
    final satHours = int.tryParse(satCont.text) ?? 0;

    if (monHours > 8 ||
        tueHours > 8 ||
        wedHours > 8 ||
        thuHours > 8 ||
        friHours > 8 ||
        satHours > 8) {
      // Show an error message if any of the day's hours exceed 8
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('day\'s hours cannot exceed 8')),
      );
      return;
    }

    if (decriptionCont.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Description cannot be empty')),
      );
      return;
    }

    // Create a new timesheet entry with the input data
    TimesheetEntry newEntry = TimesheetEntry(
      projectId: widget.projectId!,
      taskId: widget.taskId!,
      attrId: widget.attrId!,
      departmentId: widget.departmentId,
      description: decriptionCont.text,
      logId: widget.logId,
      taskDetails: {
        widget.date1.toString(): monHours.toString(),
        widget.date2.toString(): tueHours.toString(),
        widget.date3.toString(): wedHours.toString(),
        widget.date4.toString(): thuHours.toString(),
        widget.date5.toString(): friHours.toString(),
        widget.date6.toString(): satHours.toString(),
      },
    );

    // Call the updateNewEntry function passed in from the CreateTimesheetScreen widget
    // with a single argument that contains both the index and the new TimesheetEntry object
    widget.updateNewEntry(newEntry);

    // Navigateback to the parent screen
    Navigator.pop(context);
  }

  @override
  void initState() {
    // getData();

    projectNamecont.text = widget.projectName;
    taskNamecont.text = widget.taskName;
    attrNamecont.text = widget.attrName;
    decriptionCont.text = widget.description;

    monCont.text = widget.mon;
    tueCont.text = widget.tue;
    wedCont.text = widget.wed;
    thuCont.text = widget.thu;
    friCont.text = widget.fri;
    satCont.text = widget.sat;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Logged Timesheet Data'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(children: [
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 6,
              ),
              child: TextFormField(
                readOnly: true,
                controller: projectNamecont,
                onChanged: (value) {
                  // AppController.setemailId(emailController.text);
                  // c.userName.value = emailController.text;
                },
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  labelText: 'Project Name ',
                  // hintText: 'username',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
              child: TextFormField(
                readOnly: true,
                controller: taskNamecont,
                onChanged: (value) {
                  // AppController.setemailId(emailController.text);
                  // c.userName.value = emailController.text;
                },
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  labelText: 'Task Name ',
                  // hintText: 'username',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
              child: TextFormField(
                readOnly: true,
                controller: attrNamecont,
                onChanged: (value) {
                  // AppController.setemailId(emailController.text);
                  // c.userName.value = emailController.text;
                },
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  labelText: 'Attribute  Name ',
                  // hintText: 'username',
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Column(children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: const Color.fromARGB(255, 175, 189, 208),
                      ),
                      height: 30,
                      width: 40,
                      child: const Center(child: Text('Mon')),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      // color: Colors.,
                      height: 30,
                      width: 40,
                      child: TextFormField(
                        controller: monCont,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 4, horizontal: 6),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            hintText: 'hrs'),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ]),
                ),

                //
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Column(children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Color.fromARGB(255, 175, 189, 208),
                      ),
                      height: 30,
                      width: 40,
                      child: Center(child: const Text('Tue')),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      // color: Colors.,
                      height: 30,
                      width: 40,
                      child: TextFormField(
                        controller: tueCont,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 4, horizontal: 6),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            hintText: 'hrs'),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ]),
                ),
                //
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Column(children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Color.fromARGB(255, 175, 189, 208),
                      ),
                      height: 30,
                      width: 40,
                      child: Center(child: const Text('Wed')),
                    ),
                    SizedBox(height: 8),
                    Container(
                      // color: Colors.,
                      height: 30,
                      width: 40,
                      child: TextFormField(
                        controller: wedCont,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 4, horizontal: 6),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            hintText: 'hrs'),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ]),
                ),

                //
              ],
            ),

            //SECOND ROW

            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Column(children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: const Color.fromARGB(255, 175, 189, 208),
                      ),
                      height: 30,
                      width: 40,
                      child: const Center(child: Text('Thu')),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      // color: Colors.,
                      height: 30,
                      width: 40,
                      child: TextFormField(
                        controller: thuCont,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 4, horizontal: 6),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            hintText: 'hrs'),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ]),
                ),

                //
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Column(children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Color.fromARGB(255, 175, 189, 208),
                      ),
                      height: 30,
                      width: 40,
                      child: Center(child: const Text('Fri')),
                    ),
                    SizedBox(height: 8),
                    Container(
                      // color: Colors.,
                      height: 30,
                      width: 40,
                      child: TextFormField(
                        controller: friCont,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 4, horizontal: 6),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            hintText: 'hrs'),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ]),
                ),
                //
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Column(children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Color.fromARGB(255, 175, 189, 208),
                      ),
                      height: 30,
                      width: 40,
                      child: Center(child: const Text('Sat')),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      // color: Colors.,
                      height: 30,
                      width: 40,
                      child: TextFormField(
                        controller: satCont,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 4, horizontal: 6),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            hintText: 'hrs'),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ]),
                ),
                //
              ],
            ),

            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Container(
                height: 200,
                width: 400,
                child: TextFormField(
                  controller: decriptionCont,
                  textAlign: TextAlign.center,
                  // controller: _description,
                  decoration: InputDecoration(
                    hintText: 'Enter description here...',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  maxLines: 200,
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: updateTimesheetEntry,
              child: const Text('Save'),
            ),
          ]),
        ),
      ),
    );
  }
}
