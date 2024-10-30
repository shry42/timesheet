import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:timesheet/common/bottom_navigations/hr_bottom_navigation.dart';
import 'package:timesheet/common/controllers/app_controller.dart';
import 'package:timesheet/common/controllers/hr_controllers/delete_attribute_controller.dart';
import 'package:timesheet/common/controllers/hr_controllers/hr_update_attribute_controller.dart';

class HRUpdateAttribute extends StatefulWidget {
  HRUpdateAttribute({
    super.key,
    required this.description,
    required this.attributeName,
    required this.attributeId,
    required this.title,
  });

  final String title, attributeName, description;
  final int attributeId;

  @override
  State<HRUpdateAttribute> createState() => _HRUpdateAttributeState();
}

class _HRUpdateAttributeState extends State<HRUpdateAttribute> {
  final TextEditingController attributeName = TextEditingController();
  final TextEditingController description = TextEditingController();
  final UpdateAttributeController uac = Get.put(UpdateAttributeController());

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    // Initialize the controllers with the provided values
    attributeName.text = widget.attributeName;
    description.text = widget.description;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 213, 231, 214),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(children: [
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
                      interval: const Duration(milliseconds: 20),
                      color: Colors.white,
                      colorOpacity: 1,
                      enabled: true,
                      direction: const ShimmerDirection.fromLTRB(),
                      child: GestureDetector(
                        onTap: () async {
                          await DeleteAttributeController()
                              .deleteAttribute(widget.attributeId);
                          if (AppController.message != null) {
                            Get.defaultDialog(
                              title: "Success!",
                              middleText: "${AppController.message}",
                              textConfirm: "OK",
                              confirmTextColor: Colors.white,
                              onConfirm: () async {
                                AppController.setmessage(null);
                                Get.offAll(const BottomNavHR(
                                  initialIndex: 4,
                                ));
                              },
                            );
                            return;
                          }
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
                                  'Delete Attribute',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 12),
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
            const SizedBox(height: 30),
            Column(children: [
              Padding(
                //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
                child: TextFormField(
                  controller: attributeName,
                  // initialValue: widget.firstName,
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
                    labelText: 'Attribute Name ',
                    // hintText: 'username',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter Attribute name";
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                child: TextFormField(
                  controller: description,
                  // initialValue: widget.lastName,
                  onChanged: (value) {
                    // AppController.setemailId(emailController.text);
                    // c.userName.value = emailController.text;
                  },
                  decoration: InputDecoration(
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    labelText: 'Description',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter description";
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 20),
              Shimmer(
                duration: const Duration(seconds: 2),
                interval: const Duration(seconds: 1),
                color: Colors.white,
                colorOpacity: 1,
                enabled: true,
                direction: const ShimmerDirection.fromLTRB(),
                child: Container(
                  height: 42,
                  width: 160,
                  decoration: BoxDecoration(
                      color: Colors.greenAccent,
                      borderRadius: BorderRadius.circular(30)),
                  child: ElevatedButton(
                    onPressed: () async {
                      //taskID and remark is only mandatory
                      if (_formKey.currentState!.validate()) {
                        await uac.updateAttribute(
                          attributeName.text,
                          description.text,
                          widget.attributeId,
                        );
                      }
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Text(
                            'Update',
                            style: TextStyle(color: Colors.black, fontSize: 25),
                          ),
                        ),
                        Icon(
                          Icons.energy_savings_leaf,
                          color: Color.fromARGB(255, 78, 225, 83),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ]),
            const SizedBox(
              height: 30,
            ),
          ]),
        ),
      ),

      // backgroundColor: Colors.transparent,
    );
  }
}
