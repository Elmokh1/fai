import 'package:fai/import.dart';
import 'package:fai/ui/Frequently%20Asked%20Questions/frequently_asked_questions.dart';
import 'package:fai/ui/client_interface/customer_service/customer_service.dart';
import 'package:fai/ui/post/posts_review/post_view.dart';
import 'package:fai/ui/sections/sections.dart';
import 'package:flutter/material.dart';

class ClientInterFace extends StatefulWidget {
  static const String routeName = "ClientInterFace";

  @override
  State<ClientInterFace> createState() => _ClientInterFaceState();
}

class _ClientInterFaceState extends State<ClientInterFace> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.transparent,
      body: tabs[selectedIndex],
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40.0),
        child: ClipRRect(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(40),topRight: Radius.circular(40)),
          child: BottomAppBar(
            color: Color(0xff49688D),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                      icon: selectedIndex == 0
                          ? CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 50,
                          child:Center(child: Icon(Icons.chat, size: 30, color: Colors.red)))
                          : Icon(Icons.chat, size: 24, color: Colors.white),
                      onPressed: () {
                        setState(() {
                          selectedIndex = 0;
                        });
                      },
                    ),
                    IconButton(
                      icon: selectedIndex == 1
                          ? CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 50,
                          child:Center(child: Icon(Icons.local_drink, size: 30, color: Colors.red)))
                          : Icon(Icons.local_drink, size: 24, color: Colors.white),
                      onPressed: () {
                        setState(() {
                          selectedIndex = 1;
                        });
                      },
                    ),
                    IconButton(
                      icon: selectedIndex == 2
                          ? CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 50,
                          child:Center(child: Icon(Icons.help, size: 30, color: Colors.red)))
                          : Icon(Icons.help, size: 24, color: Colors.white),
                      onPressed: () {
                        setState(() {
                          selectedIndex = 2;
                        });
                      },
                    ),
                    IconButton(
                      icon: selectedIndex == 3
                          ? CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 50,
                          child: Center(
                            child: Icon(Icons.support_agent,
                                size: 30, color: Colors.red),
                          ))
                          : Icon(Icons.support_agent, size: 24, color: Colors.white),
                      onPressed: () {
                        setState(() {
                          selectedIndex = 3;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  var tabs = [
    PostView(),
    Sections(
      showOrderNow: false,
    ),
    FrequentlyAskedQuestions(),
    CustomerService(),
  ];
}
