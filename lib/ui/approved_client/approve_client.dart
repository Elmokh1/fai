import 'package:fai/database/model/customer_model.dart';
import 'package:fai/ui/approved_client/pending_container.dart';

import '../../import.dart';

class ApproveClient extends StatefulWidget {

  @override
  State<ApproveClient> createState() => _ApproveClientState();
}

class _ApproveClientState extends State<ApproveClient> {
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
      appBar: AppBar(title:Text("Pending Client"),),
      body: Column(
        children: [
          Expanded(
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
                    final pendingUser = userList![index];
                    if (pendingUser.isCustomer == true &&pendingUser.isFarmer == false) {
                      return PendingContainer(pendingUser: pendingUser);
                    } else {
                      return SizedBox.shrink();
                    }
                  },
                  itemCount: userList?.length ?? 0,
                );
              },
              stream: MyDataBase.getCustomerRealTimeUpdate(
                user?.uid ?? "",
              ),
            ),
          )

        ],
      ),
    );
  }
}
