import 'package:flutter/material.dart';

class MyTeamCard extends StatelessWidget {
  const MyTeamCard({
    Key? key,
    this.ht,
    this.wd,
    this.duration,
    required this.name,
    required this.email,
  }) : super(key: key);

  final double? ht;
  final double? wd;
  final dynamic duration;
  final String name;
  final String email;

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
              physics: const NeverScrollableScrollPhysics(),
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.only(top: 15, left: 18),
                  child: Row(
                    children: [
                      Flexible(
                        child: Text(
                          'Name   :   $name',
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
                          'Email :  $email',
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
