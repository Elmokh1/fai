import 'package:fai/ui/client_interface/client_interface.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../database/model/customer_model.dart';
import '../../import.dart';

class WelcomePage extends StatefulWidget {
  static const String routeName = "WelcomePage";

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  var auth = FirebaseAuth.instance;
  User? user;

  @override
  void initState() {
    super.initState();
    user = auth.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 80,
              child: TypewriterAnimatedTextKit(
                speed: Duration(milliseconds: 100),
                repeatForever: false,
                text: ["مرحبا بك من جديد إلى أجري هوك"],
                textStyle: GoogleFonts.cairo(
                  fontSize: 26,
                  color: Colors.green,
                ),
              ),
            ),
            SizedBox(
              height: 200,
              child: Image.asset("assets/images/agriLogo.png"),
            ),
            StreamBuilder<QuerySnapshot<CustomerModel>>(
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                var userList =
                    snapshot.data?.docs.map((doc) => doc.data()).toList();
                if (userList?.isEmpty == true) {
                  return Center(
                    child: Text(
                      "!! فاضي ",
                      style: GoogleFonts.abel(
                        fontSize: 30,
                      ),
                    ),
                  );
                }

                final pendingUser = userList![0];
                if (pendingUser.isCustomer == true &&
                    pendingUser.isFarmer == true &&
                    pendingUser.isEng == true) {
                  return InkWell(
                    onTap: () {
                      Navigator.pushReplacementNamed(context, HomeScreen.routeName);
                    },
                    child: Container(
                      width: 200,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Center(
                        // child: TypewriterAnimatedTextKit(
                        //   speed: Duration(milliseconds: 100),
                        //   repeatForever: false,
                        //   text: ["الاستمرار"],
                        //   textStyle: GoogleFonts.mogra(
                        //     fontSize: 20,
                        //     color: Colors.white,
                        //   ),
                        // ),
                        child: Text("الاستمرار",style: GoogleFonts.mogra(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          color: Colors.white,
                        ),),
                      ),
                    ),
                  );
                } else if (pendingUser.isAdmin == true&&pendingUser.isCustomer == false &&
                    pendingUser.isFarmer == false &&
                    pendingUser.isEng == false){
                  return InkWell(
                    onTap: () {
                      Navigator.pushReplacementNamed(context, AdminScreen.routeName);
                    },
                    child: Container(
                      width: 200,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Center(
                        child: Text("الاستمرار",style: GoogleFonts.mogra(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          color: Colors.white,
                        ),),
                      ),
                    ),
                  );
                }else {
                  return InkWell(
                    onTap: () {
                      Navigator.pushReplacementNamed(context, ClientInterFace.routeName);
                    },
                    child: Container(
                      width: 200,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Center(
                        child: Text("الاستمرار",style: GoogleFonts.mogra(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          color: Colors.white,
                        ),),
                      ),
                    ),
                  );
                }
              },
              stream: MyDataBase.getCustomerDataRealTimeUpdate(user!.uid),
            ),
          ],
        ),
      ),
    );
  }
}
