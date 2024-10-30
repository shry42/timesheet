import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:timesheet/common/controllers/pass_reset_controllers/password_reset_for_otp_controller.dart';
import 'package:timesheet/common/controllers/pass_reset_controllers/reset_with_otp_controller.dart';

class ResestPassScreenByOtpScreen extends StatefulWidget {
  const ResestPassScreenByOtpScreen({super.key, required this.empId});
  final String empId;

  @override
  State<ResestPassScreenByOtpScreen> createState() =>
      _ResestPassScreenByOtpScreenState();
}

class _ResestPassScreenByOtpScreenState
    extends State<ResestPassScreenByOtpScreen> {
  TextEditingController empIdController = TextEditingController();
  TextEditingController newPassController = TextEditingController();
  TextEditingController conPassController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  final PasswordResetWithOtpController prwoc = PasswordResetWithOtpController();

  final PasswordResetForOtpController prfoc =
      PasswordResetForOtpController(); // for final call to change password

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    empIdController.text = widget.empId;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Change Password"),
        shadowColor: const Color.fromARGB(255, 117, 198, 25),
        backgroundColor: const Color.fromARGB(255, 159, 237, 70),
      ),
      body: SingleChildScrollView(
        // physics: NeverScrollableScrollPhysics(),
        child: Form(
          key: _formKey,
          child: Container(
            child: FutureBuilder(
                future: prwoc.resetWithOtp(widget.empId),
                builder: (BuildContext ctx, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: 200),
                          CircularProgressIndicator(),
                          SizedBox(height: 10),
                          Center(
                              child: Text(
                                  '     Generating mail...\nHold on for Seconds...')),
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
                              '    Error sending Mail\nPlease try again by logging out'),
                        ],
                      ),
                    );
                  }
                  // else if (snapshot.data == null || snapshot.data.isEmpty) {
                  //   return const Center(
                  //     child: Column(
                  //       mainAxisAlignment: MainAxisAlignment.center,
                  //       crossAxisAlignment: CrossAxisAlignment.center,
                  //       children: [
                  //         SizedBox(height: 65),
                  //         Text('Unable to send Mail'),
                  //       ],
                  //     ),
                  //   );
                  // }
                  else {
                    return Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 60.0),
                          child: Center(
                            child: SizedBox(
                                width: 250,
                                height: 200,
                                /*decoration: BoxDecoration(
                                //color: Colors.red,
                                borderRadius: BorderRadius.circular(50.0)),*/
                                child: Image.asset(
                                    'assets/images/gegadyne_logo.jpg')),
                          ),
                        ),
                        Padding(
                          //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: TextFormField(
                            controller: empIdController,
                            onChanged: (value) {
                              // AppController.setemailId(emailController.text);
                              // c.userName.value = emailController.text;
                            },
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                labelText: 'Employee code',
                                hintText: 'Employee code'),
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  value == "") {
                                return 'Please enter a valid Employee code';
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15.0, right: 15.0, top: 15, bottom: 0),
                          //padding: EdgeInsets.symmetric(horizontal: 15),
                          child: TextFormField(
                            obscureText: true,
                            controller: newPassController,
                            onChanged: (value) {
                              // c.password.value = passController.text;
                            },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              labelText: 'New Password',
                              hintText: 'New Password',
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please enter password";
                              } else if (!RegExp(
                                      r'^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[!@#$%^&*]).{8,}$')
                                  .hasMatch(value)) {
                                return "Please enter a valid password (must be at least 8 characters long, contain 1 special character, 1 capital letter, and 1 number)";
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15.0, right: 15.0, top: 15, bottom: 0),
                          //padding: EdgeInsets.symmetric(horizontal: 15),
                          child: TextFormField(
                            obscureText: true,
                            controller: conPassController,
                            onChanged: (value) {
                              // c.password.value = passController.text;
                            },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              labelText: 'Confirm Password',
                              hintText: 'Enter conmfirm password',
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please re enter password";
                              } else if (conPassController.text !=
                                  conPassController.text) {
                                return "Password mismatch";
                              }
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15.0, right: 15.0, top: 15, bottom: 0),
                          //padding: EdgeInsets.symmetric(horizontal: 15),
                          child: TextFormField(
                            controller: otpController,
                            onChanged: (value) {
                              // c.password.value = passController.text;
                            },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              labelText: 'OTP',
                              hintText: 'Enter OTP',
                            ),
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  value == "") {
                                return 'Please enter OTP';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(height: 30),
                        Shimmer(
                          duration: const Duration(seconds: 2),
                          interval: const Duration(seconds: 1),
                          color: Colors.white,
                          colorOpacity: 1,
                          enabled: true,
                          direction: const ShimmerDirection.fromLTRB(),
                          child: Container(
                            height: 50,
                            width: 250,
                            decoration: BoxDecoration(
                                color: Colors.greenAccent,
                                borderRadius: BorderRadius.circular(30)),
                            child: ElevatedButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  await prfoc.resetPass(
                                      empIdController.text,
                                      newPassController.text,
                                      conPassController.text,
                                      otpController.text);
                                }
                              },
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Center(
                                    child: Text(
                                      'Submit',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 25),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 130,
                        ),
                      ],
                    );
                  }
                }),
          ),
        ),
      ),
    );
  }
}
