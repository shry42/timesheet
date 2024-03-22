import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:glassmorphism_ui/glassmorphism_ui.dart';

import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:timesheet/common/controllers/hr_controllers/hr_users_controller.dart';
import 'package:timesheet/common/screens/hr_screens/hr_create_users.dart';
import 'package:timesheet/common/screens/hr_screens/hr_update_users.dart';
import 'package:timesheet/utils/widgets/hr_cards/hr_users_card.dart';

class UsersHRScreen extends StatefulWidget {
  const UsersHRScreen({super.key, required this.title});
  final String title;

  @override
  State<UsersHRScreen> createState() => _UsersHRScreenState();
}

final HRUsersController hrUc = HRUsersController();

class _UsersHRScreenState extends State<UsersHRScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 213, 231, 214),
      // automaticallyImplyLeading: false,
      // shadowColor: Colors.black87,
      // elevation: 1,
      body: Column(children: [
        const SizedBox(height: 40),
        GlassContainer(
          height: 50,
          width: double.infinity,
          blur: 10,
          color: Colors.white.withOpacity(0.1),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.blue.withOpacity(0.8),
              const Color.fromARGB(255, 242, 236, 236).withOpacity(0.9),
            ],
          ),
          //--code to remove border
          border: const Border.fromBorderSide(BorderSide.none),
          shadowStrength: 10,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(16),
          shadowColor: Colors.white.withOpacity(0.24),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                Shimmer(
                  duration: const Duration(seconds: 2),
                  // This is NOT the default value. Default value: Duration(seconds: 0)
                  interval: const Duration(milliseconds: 20),
                  // This is the default value
                  color: Colors.white,
                  // This is the default value
                  colorOpacity: 1,
                  // This is the default value
                  enabled: true,
                  // This is the default value
                  direction: const ShimmerDirection.fromLTRB(),
                  child: GestureDetector(
                    onTap: () {
                      Get.to(HRCreateUsers(title: 'Create Uers'));
                    },
                    child: Container(
                      height: 30,
                      width: 100,
                      decoration: BoxDecoration(
                          border: Border.all(),
                          color: Colors.white70,
                          borderRadius: BorderRadius.circular(6)),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Center(
                            child: Text(
                              'Create Users',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
        Expanded(
          child: FutureBuilder(
            future: hrUc.getHRUsersList(),
            builder: (BuildContext ctx, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 50),
                      CircularProgressIndicator(),
                      SizedBox(height: 10),
                      Text('Loading users...'),
                    ],
                  ),
                );
              } else if (snapshot.hasError) {
                return const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 100),
                      Icon(Icons.error, color: Colors.red),
                      SizedBox(height: 60),
                      Text(
                          '    Error loading users\nPlease try again by logging out'),
                    ],
                  ),
                );
              } else if (snapshot.data == null || snapshot.data.isEmpty) {
                return const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 65),
                      Text('No users to show\ncreate users first!'),
                    ],
                  ),
                );
              } else {
                return Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        // reverse: true,
                        itemCount: snapshot.data.length,
                        itemBuilder: (ctx, index) => GestureDetector(
                          onTap: () async {
                            String firstName = snapshot.data[index].firstName;
                            String lastName = snapshot.data[index].lastName;
                            String email = snapshot.data[index].email;
                            String mobileNo = snapshot.data[index].mobileNo;
                            int isManager = snapshot.data[index].isManager;
                            int id = snapshot.data[index].id;
                            int reportingManagerId =
                                snapshot.data[index].reportingManager;
                            String reportingManagerWithName =
                                snapshot.data[index].reportingManagerWithName;
                            Get.to(HRUpdateUserScreen(
                              title: 'Update User',
                              id: id,
                              firstName: firstName,
                              lastName: lastName,
                              email: email,
                              mobileNo: mobileNo,
                              isManager: isManager.toString(),
                              reportingManagerId: reportingManagerId,
                              reportingManagerWithName:
                                  reportingManagerWithName,
                            ));
                          },
                          child: HRUsersCard(
                            ht: 140,
                            wd: 400,
                            duration: 200,
                            name:
                                ' ${snapshot.data[index].firstName} ${snapshot.data[index].lastName}',
                            email: snapshot.data[index].email,
                            mobile: snapshot.data[index].mobileNo,
                            reportingManager:
                                snapshot.data[index].reportingManagerWithName,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }
            },
          ),
        ),
      ]),
    );
  }
}