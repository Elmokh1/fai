import 'package:fai/import.dart';
import 'package:fai/database/model/eng_model.dart' as MyUser;
import 'package:fai/ui/user_interface/welcome_page.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';

import '../../database/model/customer_model.dart';



class EngRegisterScreen extends StatefulWidget {
  static const String routeName = "EngRegister";

  @override
  State<EngRegisterScreen> createState() => _EngRegisterScreenState();
}

class _EngRegisterScreenState extends State<EngRegisterScreen> {
  var formkey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var passwordConfirmationController = TextEditingController();

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
  @override
  Widget build(BuildContext context) {
    return Form(
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

                  Label: "First name",
                  // controller: nameController,
                  // validator: validator,
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

        var myUser =CustomerModel(
          name: nameController.text,
          email: emailController.text,
          id: result.user?.uid,
          isCustomer:false ,
          isFarmer: false,
          isEng: true,
          isAdmin: false,
          isUpperEgypt: false,
          token:deviceToken,
        );
        await MyDataBase.addCustomer(myUser);
        var aurthprovider = Provider.of<appProvider>(context,listen: false);
        aurthprovider.updateCustomer(myUser);
        DialogUtils.hideDialog(context);
        DialogUtils.showMessage(
          context,
          "User Register Successfully",
          posActionName: "ok",
          posAction: () {
            Navigator.pushReplacementNamed(context, WelcomePage.routeName);
          },
          dismissible: false,
        );

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
