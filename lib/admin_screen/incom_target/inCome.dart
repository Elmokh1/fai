import 'package:fai/admin_screen/incom_target/compare_page.dart';
import 'package:fai/import.dart';
import 'package:fai/database/model/user_model.dart' as MyUser;

class IncomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot<MyUser.UserModel>>(
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                var userList = snapshot.data?.docs.map((doc) => doc.data()).toList();
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
                    final singleUser = userList?[2];
                    return InkWell(
                      onTap: () {
                        print(singleUser?.name);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ComparePage(user: singleUser!),
                          ),
                        );
                      },
                      child: IncomeItem(user: singleUser),
                    );
                  },
                  itemCount: userList?.length ?? 0,
                );
              },
              stream: MyDataBase.getUserRealTimeUpdate(),
            ),
          ),
        ],
      ),
    );
  }
}
