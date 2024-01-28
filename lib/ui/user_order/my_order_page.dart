import 'package:fai/import.dart';
import 'package:fai/ui/user_order/user_order_item.dart';

import '../../admin_screen/sales/order_item.dart';

class UserSalesScreen extends StatefulWidget {
  static const String routeName = "UserSalesScreen";

  @override
  State<UserSalesScreen> createState() => _NotDoneState();
}

class _NotDoneState extends State<UserSalesScreen> {
  DateTime selectedDate = DateTime.now();
  DateTime focusedDate = DateTime.now();
  Set<Marker> markerSet = {};
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
      appBar: AppBar(),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.now().subtract(Duration(days: 365)),
            lastDay: DateTime.now().add(Duration(days: 365)),
            focusedDay: focusedDate,
            calendarFormat: CalendarFormat.week,
            selectedDayPredicate: (day) {
              return isSameDay(selectedDate, day);
            },
            onFormatChanged: (format) => null,
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                this.selectedDate = selectedDay;
                this.focusedDate = focusedDay;
                print(selectedDay);
              });
            },
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: StreamBuilder<QuerySnapshot<OrderModel>>(
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text("Error: ${snapshot.error}");
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.data == null) {
                    return Text("Data is null");
                  }
                  var OrdersList =
                      snapshot.data!.docs.map((doc) => doc.data()).toList();
                  print("OrdersList: $OrdersList"); // Add this line to debug
                  if (OrdersList.isEmpty) {
                    return Center(
                      child: Text(
                        "No orders available",
                        style: GoogleFonts.abel(
                          fontSize: 30,
                        ),
                      ),
                    );
                  }

                  return ListView.builder(
                    itemBuilder: (context, index) {
                      final order = OrdersList[index];
                      // if (order.accept == true){
                      //   return SizedBox.shrink();
                      // }
                      return UserOrderItem(
                        orderModel: order,
                        userId: user!.uid,
                      );
                    },
                    itemCount: OrdersList.length,
                  );
                },
                stream: MyDataBase.getOrderRealTimeUpdate(
                  user!.uid,
                  MyDateUtils.dateOnly(selectedDate).millisecondsSinceEpoch,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
