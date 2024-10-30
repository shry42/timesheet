import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';
import 'package:timesheet/common/controllers/app_controller.dart';
import 'package:timesheet/common/controllers/hr_controllers/get_myteam_controller.dart';
import 'package:timesheet/common/screens/superadmin_screens/verify_users_timesheet_screen.dart';
import 'package:timesheet/common/screens/user_screens/user_netsed_screen.dart';
import 'package:timesheet/utils/widgets/hr_cards/my_team_card.dart';

class MyTeamScreen extends StatefulWidget {
  const MyTeamScreen({super.key, required this.title});
  final String title;

  @override
  State<MyTeamScreen> createState() => _MyTeamScreenState();
}

final MyTeamListController mtlc = MyTeamListController();
int? userId;

class _MyTeamScreenState extends State<MyTeamScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 213, 231, 214),
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
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
        Expanded(
          child: FutureBuilder(
            future: mtlc.getMyTeamList(),
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
                      Text('Loading team list...'),
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
                          '    Error loading teams\nPlease try again by logging out'),
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
                      Text('No teams to show'),
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
                            userId = snapshot.data![index].id;
                            if (AppController.verification == 1) {
                              Get.to(
                                VerifyUsersTimesheetScreen(
                                    title: 'Verify Timesheet',
                                    userId: userId.toString()),
                              );
                            } else {
                              Get.to(NestedUsersManagerScreen(
                                title: 'Users list',
                                userId: userId,
                              ));
                            }
                          },
                          child: MyTeamCard(
                              ht: 80,
                              wd: 400,
                              duration: 400,
                              name:
                                  "${snapshot.data![index].firstName} ${snapshot.data![index].lastName}",
                              email: snapshot.data![index].email.toString()),
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
  //
}
