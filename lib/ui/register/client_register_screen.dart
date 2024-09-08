import 'package:fai/database/model/eng_model.dart';
import 'package:fai/ui/user_interface/welcome_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_glow/flutter_glow.dart';
import '../../database/model/customer_model.dart';
import '../../import.dart';
import '../../validation_utils.dart';
import '../componant/custom_text_field.dart';
import '../login/login_screen.dart';

class ClientRegisterScreen extends StatefulWidget {
  static const String routeName = "ClientRegister";

  @override
  State<ClientRegisterScreen> createState() => _ClientRegisterScreenState();
}

class _ClientRegisterScreenState extends State<ClientRegisterScreen> {
  var formkey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var passwordConfirmationController = TextEditingController();
  bool radioSelected = true;
  String? selectedSection;
  String? selectedSectionId;
  String? engName;
  String? engId;
  @override
  String? deviceToken;
  @override
  void initState() {
    super.initState();
    initDeviceToken();
  }

  Future<void> initDeviceToken() async {
    String? token;
    try {
      token = await FirebaseMessaging.instance.getToken();
    } on PlatformException catch (e) {
      print('Failed to get device token: ${e.message}');
    }
    setState(() {
      deviceToken = token;
    });
  }
  Widget build(BuildContext context) {
    return  Form(
          key: formkey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 30,),

                Directionality(
                  textDirection: TextDirection.rtl,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: Text(
                      "مرحبا بك ❤️ ",
                      style: GoogleFonts.tajawal(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                CustomTextFormField(
                  controller: nameController,
                  validator: (text) {
                    if (text == null || text.trim().isEmpty) {
                      return 'Please Enter full Name ';
                    }
                  },

                  Label: "Full name",
                ),
                CustomTextFormField(
                  controller: emailController,
                  Label: "E mail",
                  // controller: nameController,
                  validator: (text) {
                    if (text == null || text.trim().isEmpty) {
                      return 'Please Enter Email ';
                    }
                    if (!ValidationUtils.isValidEmail(text)) {
                      return 'Please Enter a Valid Email';
                    }
                  },
                ),
                CustomTextFormField(
                  isPassword: true,
                  controller: passwordController,
                  Label: "Password",
                  // controller: nameController,
                  validator: (text) {
                    if (text == null || text.trim().isEmpty) {
                      return 'Please Enter The Password ';
                    }
                    if (text.length < 6) {
                      return "Password Must be 6 char";
                    }
                  },
                ),
                CustomTextFormField(
                  isPassword: true,
                  controller: passwordConfirmationController,
                  Label: "Password Confirmation",
                  // controller: nameController,
                  validator: (text) {
                    if (text == null || text.trim().isEmpty) {
                      return 'Please Enter Password Confirmation ';
                    }
                    if (passwordController.text != text) {
                      return "password doesn't match";
                    }
                  },
                ),
                SizedBox(height: 20,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Text(
                          "عميل",
                          style: GoogleFonts.poppins(
                            decoration: TextDecoration.none,
                            color: Color(0xff6D4404),
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        GlowRadio<bool>(
                          value: false,
                          groupValue: radioSelected,
                          checkColor: Colors.white,
                          color: Colors.blueAccent,
                          onChange: (value) {
                            setState(() {
                              radioSelected = false;
                              print(radioSelected);
                            });
                          },
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          "زائر ",
                          style: GoogleFonts.poppins(
                            decoration: TextDecoration.none,
                            color: Color(0xff6D4404),
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        GlowRadio<bool>(
                          value: true,
                          checkColor: Colors.white,
                          color: Colors.blueAccent,
                          groupValue: radioSelected,
                          onChange: (value) {
                            setState(() {
                              radioSelected = true;
                              print(radioSelected);

                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 20,),
                radioSelected == false ? Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: StreamBuilder<QuerySnapshot<CustomerModel>>(
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text(snapshot.error.toString());
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      var engList = snapshot.data?.docs.map((doc) => doc.data()).toList();
                      print(engList.toString());

                      bool hasUserWithRequiredAttributes = engList?.any((user) {
                        return user.isEng == true && user.isFarmer == true && user.isCustomer == true&& user.isAdmin ==false;
                      }) ?? false;

                      if (hasUserWithRequiredAttributes) {
                        if (engList?.isEmpty == true) {
                          return Center(
                            child: Text(
                              "لا يوجد مهندسين ",
                              style: GoogleFonts.abel(
                                fontSize: 30,
                              ),
                            ),
                          );
                        }
                        return Container(
                          height: 50,
                          child: ListView.builder(
                            itemBuilder: (context, index) {
                              final eng = engList![index];
                              return Container(
                                width: 342,
                                height: 48,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                    color: const Color(0xffB6B6B6),
                                  ),
                                ),
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                child: Container(
                                  height: 48,
                                  child: DropdownButton<String>(
                                    hint: Text("برجاء اختيار مهندس"),
                                    isExpanded: true,
                                    value: selectedSection,
                                    items: engList?.map((user) {
                                      return DropdownMenuItem<String>(
                                        value: user.name,
                                        child: Text(user.name ?? ""),
                                      );
                                    }).toList(),
                                    onChanged: (newValue) {
                                      setState(() {
                                        selectedSection = newValue;
                                        var selectedSectionData = engList?.firstWhere(
                                              (section) => section.name == newValue,
                                          orElse: () => CustomerModel(),
                                        );
                                        if (selectedSectionData != null) {
                                          engId = selectedSectionData.id;
                                          engName = selectedSectionData.name;
                                          print('Selected section ID: ${selectedSectionData.id}');
                                        }
                                        selectedSectionId = selectedSectionData?.id;
                                      });
                                    },
                                  ),
                                ),
                              );
                            },
                            itemCount: 1, // Use the length of sectionList
                          ),
                        );
                      } else {
                        return Center(
                          child: Text(
                            "لا يوجد مستخدم يجمع بين الصفات المطلوبة",
                            style: GoogleFonts.abel(
                              fontSize: 30,
                            ),
                          ),
                        );
                      }
                    },
                    stream: MyDataBase.getCustomerRealTimeUpdateInAdmin(),
                  ),

                ): SizedBox(height: 2,),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 30.0, left: 30, right: 30, bottom: 10),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    onPressed: () {
                      register();
                    },
                    child: const Text(
                      'Register',
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                          context, LoginScreen.routeName);
                    },
                    child: const Text("Already Have Account")),
              ],
            ),
          ),
        );
  }
  FirebaseAuth authService = FirebaseAuth.instance;

  void register() async {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("جاري التحميل...")),
    );
    if (formkey.currentState?.validate() == false) {
      return;
    }

    DialogUtils.showLoadingDialog(context, 'Loading...');
    try {

      var result = await authService.createUserWithEmailAndPassword(email: emailController.text, password: passwordController.text);
      if(radioSelected==true){
        var myUser =CustomerModel(
          name: nameController.text,
          email: emailController.text,
          id: result.user?.uid,
          isCustomer:false ,
          isFarmer: true,
          isEng: false,
          isAdmin: false,
          token: deviceToken,
        );
        await MyDataBase.addCustomer(myUser);
        var aurthprovider = Provider.of<appProvider>(context,listen: false);
        aurthprovider.updateCustomer(myUser);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("تم تسجيل الدخول بنجاح")),
        );
        Navigator.pushReplacementNamed(context, WelcomePage.routeName);
      }
      else if(radioSelected==false){
        var myUser =CustomerModel(
          name: nameController.text,
          email: emailController.text,
          id: result.user?.uid,
          isCustomer:true ,
          isFarmer: false,
          isAdmin: false,
          isEng: false,
          engId: engId,
          engName: engName,
          token:deviceToken,
        );
        await MyDataBase.addCustomer(myUser);
        var aurthprovider = Provider.of<appProvider>(context,listen: false);
        aurthprovider.updateCustomer(myUser);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("تم تسجيل الدخول بنجاح")),
        );
        Navigator.pushReplacementNamed(context, WelcomePage.routeName);
      }

    } on FirebaseAuthException catch (e) {
      DialogUtils.hideDialog(context);
      String errorMessage = 'Something went wrong';
      if (e.code == 'weak-password') {
        errorMessage = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        errorMessage = 'The account already exists for that email.';
      }
      DialogUtils.showMessage(context, errorMessage, posActionName: 'ok');
    } catch (e) {
      DialogUtils.hideDialog(context);
      String errorMessage = 'Something went wrong';
      DialogUtils.showMessage(context, errorMessage,
          posActionName: 'cancel', negActionName: 'Try Again', negAction: () {
            register();
          });
    }
  }
}
