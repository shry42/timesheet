import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SubmittedTimesheetDialogScreen extends StatefulWidget {
  const SubmittedTimesheetDialogScreen(
      {super.key,
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
      required this.description});

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

  @override
  State<SubmittedTimesheetDialogScreen> createState() =>
      _SubmittedTimesheetDialogScreenState();
}

class _SubmittedTimesheetDialogScreenState
    extends State<SubmittedTimesheetDialogScreen> {
  @override
  void initState() {
    // getData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(shrinkWrap: true, children: [
      SingleChildScrollView(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
            child: TextFormField(
              readOnly: true,
              initialValue: widget.projectName,
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
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
            child: TextFormField(
              readOnly: true,
              initialValue: widget.taskName,
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
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
            child: TextFormField(
              readOnly: true,
              initialValue: widget.attrName,
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
                      color: const Color.fromARGB(255, 175, 189, 158),
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
                      readOnly: true,
                      initialValue: widget.mon,
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
                      color: Color.fromARGB(255, 175, 189, 158),
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
                      readOnly: true,
                      initialValue: widget.tue,
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
                      color: Color.fromARGB(255, 175, 189, 158),
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
                      readOnly: true,
                      initialValue: widget.wed,
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
                      color: Color.fromARGB(255, 175, 189, 158),
                    ),
                    height: 30,
                    width: 40,
                    child: Center(child: const Text('Thu')),
                  ),
                  SizedBox(height: 8),
                  Container(
                    // color: Colors.,
                    height: 30,
                    width: 40,
                    child: TextFormField(
                      readOnly: true,
                      initialValue: widget.thu,
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
                      color: Color.fromARGB(255, 175, 189, 158),
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
                      readOnly: true,
                      initialValue: widget.fri,
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
                      color: Color.fromARGB(255, 175, 189, 158),
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
                      readOnly: true,
                      initialValue: widget.sat,
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
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Container(
              height: 150,
              width: 400,
              child: TextFormField(
                readOnly: true,
                initialValue: widget.description,
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
        ]),
      ),
    ]);
  }
}
