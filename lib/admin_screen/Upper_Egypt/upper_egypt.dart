import 'package:fai/admin_screen/question/add_questions_page.dart';
import 'package:fai/database/model/customer_model.dart';
import 'package:fai/import.dart';
import 'package:fai/database/model/eng_model.dart' as MyUser;

class UpperEgyptScreen extends StatefulWidget {
  static const routeName = "UpperEgyptScreen";

  @override
  State<UpperEgyptScreen> createState() => _UpperEgyptScreenState();
}

class _UpperEgyptScreenState extends State<UpperEgyptScreen> {
  DateTime selectedDate = DateTime.now();
  DateTime focusedDate = DateTime.now();
  MyUser.EngModel? user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: Container(
              height: MediaQuery.of(context).size.height * 1,
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
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      final user = userList![index];
                      if(user.isEng == true&& user.isFarmer==true&&user.isCustomer==true&&user.isUpperEgypt==true){
                        return UserItem(user: user);
                      }
                      return SizedBox(height: 1,);

                    },
                    itemCount: userList?.length ?? 0,
                  );
                },
                stream: MyDataBase.getCustomerRealTimeUpdateInAdmin(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
