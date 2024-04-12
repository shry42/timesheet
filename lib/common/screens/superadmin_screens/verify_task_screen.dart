import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:timesheet/common/bottom_navigations/hr_bottom_navigation.dart';
import 'package:timesheet/common/controllers/app_controller.dart';
import 'package:timesheet/common/controllers/superadmin_controllers/verify_task_controller.dart';
import 'package:timesheet/utils/widgets/hr_cards/hr_tasks_card.dart';
import 'package:timesheet/utils/widgets/reject_verify_dialog_task.dart';

class VerifyTaskScreen extends StatefulWidget {
  VerifyTaskScreen({
    Key? key,
    required this.title,
    required this.remark,
    required this.taskName,
    required this.description,
    required this.taskId,
    required this.createdAt,
  }) : super(key: key);

  final String title, taskName, description, createdAt;
  final String? remark;
  final int taskId;

  @override
  State<VerifyTaskScreen> createState() => _VerifyTaskScreenState();
}

class _VerifyTaskScreenState extends State<VerifyTaskScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 213, 231, 214),
      body: Column(
        children: [
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
              child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                Text(
                  widget.title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ]),
            ),
          ),

          const SizedBox(height: 20),

          HRTasksCard(
            ht: 150,
            wd: 400,
            duration: 100,
            task: widget.taskName,
            description: widget.description,
            createdAt: widget.createdAt,
            remark: widget.remark == null ? 'N/A' : widget.remark.toString(),
          ),
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Shimmer(
                  duration: const Duration(seconds: 2),
                  interval: const Duration(seconds: 1),
                  color: Colors.white,
                  colorOpacity: 1,
                  enabled: true,
                  direction: const ShimmerDirection.fromLTRB(),
                  child: Container(
                    height: 40,
                    width: 118,
                    decoration: BoxDecoration(
                      // color: Colors.greenAccent,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ElevatedButton(
                      onPressed: () async {
                        await VerifyTaskController()
                            .verifyTask(widget.taskId!.toInt(), '1', '');
                        if (AppController.message != null) {
                          Get.defaultDialog(
                            title: "Success!",
                            middleText: "${AppController.message}",
                            textConfirm: "OK",
                            confirmTextColor: Colors.white,
                            onConfirm: () async {
                              AppController.setmessage(null);
                              Get.offAll(const BottomNavHR(
                                initialIndex: 3,
                              ));
                            },
                          );
                          return;
                        }
                      },
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: Text(
                              'Approve',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 18),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )),
              Shimmer(
                  duration: const Duration(seconds: 2),
                  interval: const Duration(seconds: 1),
                  color: Colors.white,
                  colorOpacity: 1,
                  enabled: true,
                  direction: const ShimmerDirection.fromLTRB(),
                  child: Container(
                    height: 40,
                    width: 118,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ElevatedButton(
                      onPressed: () async {
                        await Get.to(Get.defaultDialog(
                          backgroundColor:
                              const Color.fromARGB(255, 195, 215, 196),
                          title: 'Add Remark',
                          content: DialogBoxVerfiyRemarkTask(
                              taskId: widget.taskId, verify: '2'),
                        ));

                        // await VerifyProjectController()
                        //     .verifyProject(widget.projectId!.toInt(), '1');
                        if (AppController.message != null) {
                          Get.defaultDialog(
                            title: "Success!",
                            middleText: "${AppController.message}",
                            textConfirm: "OK",
                            confirmTextColor: Colors.white,
                            onConfirm: () async {
                              AppController.setmessage(null);
                              Get.offAll(const BottomNavHR(
                                initialIndex: 3,
                              ));
                            },
                          );
                          return;
                          // toast(AppController.message);
                        }
                      },
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: Text(
                              'Reject',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 18),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )),
            ],
          ),
          const SizedBox(height: 30),
          //
        ],
      ),
    );
  }
}

//
