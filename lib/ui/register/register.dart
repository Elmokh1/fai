import 'package:fai/ui/register/client_register_screen.dart';
import 'package:flutter_glow/flutter_glow.dart';

import '../../import.dart';

class RegisterPage extends StatefulWidget {
  static const String routeName = "RegisterScreen";

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool radioSelected = false;
  bool visitorRadioSelected = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/customer_back.jpeg"),
            fit: BoxFit.cover
          )
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Text(
                        "موظف",
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
                        groupValue: radioSelected,
                        checkColor: Colors.white,
                        color: Colors.blueAccent,
                        onChange: (value) {
                          setState(() {
                            radioSelected = true;
                          });
                        },
                      ),
                    ],
                  ),
                  const SizedBox(width: 32),
                  Column(
                    children: [
                      Text(
                        "زائر / عميل",
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
                        checkColor: Colors.white,
                        color: Colors.blueAccent,
                        groupValue: radioSelected,
                        onChange: (value) {
                          setState(() {
                            radioSelected = false;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                child: radioSelected == true
                    ? EngRegisterScreen()
                    : ClientRegisterScreen(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
