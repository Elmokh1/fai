import 'package:flutter/material.dart';
import 'package:fai/import.dart';
import 'main_page.dart';
import '../user_order/my_order_page.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = "HomeScreen";



  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainDrawer(),
      body: tabs[selectedIndex],
      appBar: AppBar(
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        shape: const StadiumBorder(
          side: BorderSide(width: 4, color: Colors.white),
        ),
        onPressed: () {
          // showAddTaskSheet();
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddNewTask()),
          );
        },
        child: const Icon(
          Icons.add,
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        child: BottomNavigationBar(
          currentIndex: selectedIndex,
          onTap: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.list,
                size: 20,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.check_circle,
                size: 20,
              ),
              label: '',
            ),
          ],
        ),
      ),
    );
  }

  var tabs = [
    TodoList(),
    Done(),
  ];
}