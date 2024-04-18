import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:timesheet/common/controllers/app_controller.dart';
import 'package:timesheet/common/controllers/superadmin_controllers/verify_all_shared_project_controller.dart';
import 'package:timesheet/utils/toast_notify.dart';
import 'package:timesheet/utils/widgets/dialog_verify_all_shared_project.dart';
import 'package:timesheet/utils/widgets/hr_cards/hr_projects_card.dart';

class VerifyAllSharedProjectScreen extends StatefulWidget {
  VerifyAllSharedProjectScreen({
    Key? key,
    required this.title,
    required this.name,
    required this.code,
    required this.startDate,
    required this.endDate,
    required this.projectId,
    required this.createdAt,
    required this.shareId,
    required this.shareTo,
    required this.projectOwner,
    required this.departmentId,
    required this.description,
    required this.departmentName,
    required this.sharedTo,
    required this.sharedBy,
  }) : super(key: key);

  final String title,
      name,
      code,
      startDate,
      endDate,
      createdAt,
      description,
      departmentName,
      sharedTo,
      sharedBy;
  final int projectId, shareId, shareTo, projectOwner, departmentId;

  @override
  State<VerifyAllSharedProjectScreen> createState() =>
      _VerifyAllSharedProjectScreenState();
}

class _VerifyAllSharedProjectScreenState
    extends State<VerifyAllSharedProjectScreen> {
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

          HRProjectsCard(
            ht: 250,
            wd: 400,
            duration: 100,
            name: widget.name,
            description: widget.description,
            code: widget.code,
            startDate: widget.startDate,
            endDate: widget.endDate,
            createdAt: widget.createdAt,
            deptName: widget.departmentName,
            sharedTo: widget.sharedTo,
            sharedBy: widget.sharedBy,
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
                        await VerifyAllSharedProjectController()
                            .verifyAllSharedProject(
                                widget.projectId!.toInt(),
                                widget.shareId,
                                widget.shareTo,
                                widget.projectOwner,
                                widget.departmentId,
                                '1',
                                widget.code,
                                '');
                        if (AppController.message != null) {
                          toast(AppController.message);
                          Get.back();
                          setState(() {
                            initState();
                          });
                        }
                        return;
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
                          content: DialogBoxVerfiyAllSharedProject(
                            projectId: widget.projectId,
                            shareId: widget.shareId,
                            sharedTo: widget.shareTo,
                            projectOwner: widget.projectOwner,
                            departmentId: widget.departmentId,
                            verify: '2',
                            projectCode: widget.code,
                            remark: '',
                          ),
                        ));
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
