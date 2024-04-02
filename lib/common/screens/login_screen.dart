import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:timesheet/common/bottom_navigations/hr_bottom_navigation.dart';
import 'package:timesheet/common/bottom_navigations/superadmin_navigation.dart';
import 'package:timesheet/common/controllers/app_controller.dart';
import 'package:timesheet/common/controllers/login_controllers.dart';
import 'package:timesheet/common/custom_painter.dart';
import 'package:timesheet/utils/toast_notify.dart';

class LoginPage extends StatelessWidget {
  final loginController lc = Get.put(loginController());
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Positioned(
                right: 40,
                top: 290,
                width: 80,
                height: 150,
                child: FadeInUp(
                  from: 120,
                  duration: const Duration(seconds: 1),
                  child: Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/playstore.png'),
                      ),
                    ),
                  ),
                ),
              ),
              Form(
                key: _formKey,
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 400,
                        child: CustomPaint(
                          painter: RPSCustomPainter(),
                          child: Stack(
                            children: <Widget>[
                              Positioned(
                                left: 30,
                                width: 80,
                                height: 200,
                                child: FadeInUp(
                                    duration: const Duration(seconds: 1),
                                    child: Container(
                                      decoration: const BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  'assets/images/light-1.png'))),
                                    )),
                              ),
                              Positioned(
                                left: 140,
                                width: 80,
                                height: 150,
                                child: FadeInUp(
                                  duration: const Duration(milliseconds: 1200),
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                            'assets/images/light-2.png'),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                right: 40,
                                top: 40,
                                width: 80,
                                height: 150,
                                child: FadeInUp(
                                    duration:
                                        const Duration(milliseconds: 1300),
                                    child: Container(
                                      decoration: const BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  'assets/images/clock.png'))),
                                    )),
                              ),
                              Positioned(
                                child: FadeInUp(
                                    duration:
                                        const Duration(milliseconds: 1600),
                                    child: Container(
                                      margin: const EdgeInsets.only(top: 50),
                                      child: const Center(
                                        child: Text(
                                          "Login",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 40,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    )),
                              )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: Column(
                          children: <Widget>[
                            FadeInUp(
                                duration: const Duration(milliseconds: 1800),
                                child: Container(
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color: const Color.fromRGBO(
                                              188, 190, 230, 1)),
                                      boxShadow: const [
                                        BoxShadow(
                                            color: Color.fromRGBO(
                                                143, 148, 251, .2),
                                            blurRadius: 20.0,
                                            offset: Offset(0, 10))
                                      ]),
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                        padding: const EdgeInsets.all(8.0),
                                        child: TextFormField(
                                          controller: emailController,
                                          onChanged: (value) {
                                            // AppController.setemailId(emailController.text);
                                            lc.email.value =
                                                emailController.text;
                                          },
                                          decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: "email",
                                              hintStyle: TextStyle(
                                                  color: Colors.grey[700])),
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty ||
                                                value == "") {
                                              return 'Please enter a valid email';
                                            }
                                            return null;
                                          },
                                        ),
                                      )
                                    ],
                                  ),
                                )),
                            const SizedBox(height: 12),
                            FadeInUp(
                                duration: const Duration(milliseconds: 1800),
                                child: Container(
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color: const Color.fromRGBO(
                                              188, 190, 230, 1)),
                                      boxShadow: const [
                                        BoxShadow(
                                            color: Color.fromRGBO(
                                                143, 148, 251, .2),
                                            blurRadius: 20.0,
                                            offset: Offset(0, 10))
                                      ]),
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                        padding: const EdgeInsets.all(8.0),
                                        child: TextFormField(
                                          controller: passController,
                                          onChanged: (value) {
                                            lc.password.value =
                                                passController.text;
                                          },
                                          obscureText: true,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: "Password",
                                            hintStyle: TextStyle(
                                                color: Colors.grey[700]),
                                          ),
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty ||
                                                value == "") {
                                              return 'Please enter a password';
                                            }
                                            return null;
                                          },
                                        ),
                                      )
                                    ],
                                  ),
                                )),
                            const SizedBox(
                              height: 30,
                            ),
                            FadeInUp(
                                duration: const Duration(milliseconds: 1900),
                                child: Shimmer(
                                  child: GestureDetector(
                                    onTap: () async {
                                      if (_formKey.currentState!.validate()) {
                                        await lc.loginUser();
                                        if (AppController.message != null) {
                                          Get.defaultDialog(
                                            title: "Unauthorized!",
                                            middleText:
                                                "${AppController.message}",
                                            textConfirm: "OK",
                                            confirmTextColor: Colors.white,
                                            onConfirm: () async {
                                              AppController.setmessage(null);
                                              Get.back(); // Close the dialog
                                            },
                                          );
                                          return;
                                        } else if (lc.role == 'hrManager') {
                                          await Get.offAll(const BottomNavHR(),
                                              transition:
                                                  Transition.rightToLeft);
                                          // } else {
                                          //   Get.offAll(const MyMeetingsScreen(
                                          //       title: 'My Meetings'));
                                          //   // Get.offAll(const UserSettingsScreen(
                                          //   //   title: 'User Profile',
                                          //   // ));
                                          // }
                                        } else if (lc.role == 'superAdmin') {
                                          await Get.offAll(
                                              const BottomNavSuperAdmin(),
                                              transition:
                                                  Transition.rightToLeft);
                                        } else {
                                          toast(
                                              'Please fill credentials correctly');
                                        }
                                        // Get.offAll(BottomNaviagtionBarScreen());
                                      }
                                    },
                                    child: Container(
                                      height: 50,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          gradient:
                                              const LinearGradient(colors: [
                                            Color.fromARGB(255, 117, 198, 25),
                                            Color.fromARGB(255, 165, 240, 79),
                                          ])),
                                      child: const Center(
                                        child: Text(
                                          "Login",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ),
                                )),
                            const SizedBox(
                              height: 70,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
