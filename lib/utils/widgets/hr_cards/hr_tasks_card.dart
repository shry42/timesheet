import 'package:flutter/material.dart';

class HRTasksCard extends StatelessWidget {
  const HRTasksCard({
    Key? key,
    this.ht,
    this.wd,
    this.duration,
    required this.description,
    required this.createdAt,
    this.remark,
    // required this.id,
    required this.task,
  }) : super(key: key);

  final double? ht;
  final double? wd;
  final dynamic duration;
  // final String id;
  final String task;
  final String createdAt;
  final String description;
  final String? remark;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          margin: const EdgeInsets.symmetric(horizontal: 18),
          elevation: 8,
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(25),
          ),
          //  color: Color.fromARGB(243, 199, 80, 11),
          // //color: Colors.red,
          child: AnimatedContainer(
            duration: Duration(milliseconds: duration),
            height: ht,
            width: wd,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              gradient: const LinearGradient(
                colors: [
                  Color.fromARGB(243, 56, 232, 68),
                  Color.fromARGB(255, 151, 223, 126),
                ],
              ),
            ),
            child: SingleChildScrollView(
              // physics: const NeverScrollableScrollPhysics(),
              child: Column(children: [
                // Padding(
                //   padding: const EdgeInsets.only(top: 15, left: 18),
                //   child: Row(
                //     children: [
                //       Flexible(
                //         child: Text(
                //           'id   :   $id',
                //           style: const TextStyle(
                //             fontSize: 18,
                //             fontWeight: FontWeight.bold,
                //             color: Colors.white,
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.only(top: 15, left: 18),
                  child: Row(
                    children: [
                      Flexible(
                        child: Text(
                          'Task :  $task',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 3, left: 18),
                  child: Row(
                    children: [
                      Flexible(
                        child: Text(
                          'CreatedAt :  $createdAt',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 3, left: 18),
                  child: Row(
                    children: [
                      Flexible(
                        child: Text(
                          'Description :  $description',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                if (remark != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 3, left: 18),
                    child: Row(
                      children: [
                        Flexible(
                          child: Text(
                            'Remark :  $remark',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                const SizedBox(height: 10),
              ]),
              //
            ),
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
