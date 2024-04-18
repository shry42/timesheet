import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';
import 'package:timesheet/common/controllers/project_share_controllers/project_shared_to_me_controller.dart';
import 'package:timesheet/common/screens/hr_screens/hr_assign_project.dart';
import 'package:timesheet/utils/widgets/hr_cards/hr_projects_card.dart';

class ProjectSharedToMeScreen extends StatefulWidget {
  const ProjectSharedToMeScreen({super.key, required this.title});
  final String title;

  @override
  State<ProjectSharedToMeScreen> createState() =>
      _ProjectSharedToMeScreenState();
}

final ProjectSharedToMeController pstmc = ProjectSharedToMeController();

class _ProjectSharedToMeScreenState extends State<ProjectSharedToMeScreen> {
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
                const SizedBox(width: 10),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
        Expanded(
          child: FutureBuilder(
            future: pstmc.getProjectSharedToMe(),
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
                      Text('Loading received Projects...'),
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
                          '    Error loading projects\nPlease try again by logging out'),
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
                      Text('No Received projects to show!'),
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
                            Get.to(HRUserAssignAddProjectList(
                              title: 'User Project list',
                              projectId: snapshot.data[index].id,
                              code: snapshot.data[index].code,
                              departmentId:
                                  snapshot.data[index].sharedProjectDepartment,
                            ));
                          },
                          child: HRProjectsCard(
                            ht: 220,
                            wd: 400,
                            duration: 400,
                            name: snapshot.data[index].name.toString(),
                            description:
                                snapshot.data[index].description.toString(),
                            code: snapshot.data[index].code.toString(),
                            startDate:
                                snapshot.data[index].startDate.toString(),
                            endDate: snapshot.data[index].endDate.toString(),
                            createdAt: snapshot.data[index].createdAt
                                .toString()
                                .split("T")[0],
                            sharedBy:
                                '${snapshot.data[index].firstName}  ${snapshot.data[index].lastName}',
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
