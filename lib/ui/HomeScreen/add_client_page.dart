// import 'package:flutter/material.dart';
//
// import '../../MyDateUtils.dart';
// import 'addTaskBottomSheet.dart';
//
// class AddNewTask extends StatefulWidget {
//   static const routeName = "AddNewTask";
//
//   @override
//   State<AddNewTask> createState() => _AddNewTaskState();
// }
//
// class _AddNewTaskState extends State<AddNewTask> {
//
//
//
//   bool showAddTaskBottom = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//       ),
//       body: Column(
//         children: [
//           InkWell(
//             onTap: () {
//               setState(() {
//                 showAddTaskBottom = true;
//               });
//             },
//             child: Center(
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: Colors.green,
//                   borderRadius: BorderRadius.circular(50),
//                 ),
//                 padding: EdgeInsets.all(5),
//                 child: Center(child: Text("Add New Client")),
//                 height: 50,
//                 width: 150,
//               ),
//             ),
//           ),
//           SizedBox(height: 30,),
//           Visibility(
//             visible: showAddTaskBottom,
//             child: Container(
//               child: AddTaskBottomSheet(),
//             ),
//           ),
//           Spacer(),
//           Container(
//             width: 200,
//             height: 100,
//             padding: EdgeInsets.all(20),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(50),
//             ),
//             child: Column(
//               children: [
//                 Text(
//                   "Selected time",
//                   style: TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//                 Center(
//                   child: InkWell(
//                     onTap: () {
//                       showTaskDatePicker();
//                     },
//                     child: Text(
//                       "${MyDateUtils.formatTaskDate(selectedDate)}",
//                       style: TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.w500,
//                         color: Colors.red,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           ElevatedButton(
//             style: ElevatedButton.styleFrom(
//               padding: const EdgeInsets.all(16),
//             ),
//             onPressed: () {
//               // addTask();
//             },
//             child: const Text(
//               'Add ',
//               style: TextStyle(fontSize: 18),
//             ),
//           )
//         ],
//       ),
//     );
//   }
//
//   var selectedDate = DateTime.now();
//
//   void showTaskDatePicker() async {
//     var date = await showDatePicker(
//       context: context,
//       initialDate: selectedDate,
//       firstDate: DateTime.now().subtract(Duration(days: 2)),
//       lastDate: DateTime.now().add(
//         Duration(days: 365),
//       ),
//     );
//     if (date == null) return;
//     setState(() {
//       selectedDate = date;
//     });
//   }
// }
//
