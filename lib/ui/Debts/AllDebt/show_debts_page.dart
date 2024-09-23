import 'package:fai/database/model/customer_model.dart';
import 'package:fai/database/model/debt_model.dart';

import '../../../../import.dart';
import 'debt_item_widget.dart';

class ShowAllDebtPage extends StatefulWidget {
  static const String routeName = "ShowAllDebtPage";

  String? userId;
  bool? isUser;

  ShowAllDebtPage({this.userId,  this.isUser});

  @override
  State<ShowAllDebtPage> createState() => _ShowAllDebtPageState();
}

class _ShowAllDebtPageState extends State<ShowAllDebtPage> {
  var auth = FirebaseAuth.instance;
  User? user;
  late Stream<QuerySnapshot<DebtModel>> searchStream;
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    user = auth.currentUser;
    searchStream = MyDataBase.getDebtRealTimeUpdate(
      widget.isUser == false ? user?.uid ?? "" : widget.userId ?? "${user?.uid}",
    );
  }

  void handleSearch() {
    if (searchQuery.isNotEmpty) {
      searchStream = MyDataBase.getDebtCollection(
        widget.isUser == false ? user?.uid ?? "" :widget.userId ?? "${user?.uid}",
      )
          .where('clientName', isGreaterThanOrEqualTo: searchQuery)
          .where('clientName', isLessThanOrEqualTo: searchQuery + '\uf8ff')
          .snapshots();
    } else {
      searchStream = MyDataBase.getDebtRealTimeUpdate(
        widget.isUser == false ? user?.uid ?? "" :widget.userId ?? "${user?.uid}",
      );
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Directionality(
            textDirection: TextDirection.rtl,
            child: SizedBox(
              width: MediaQuery.of(context).size.width * .9,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: "البحث",
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      searchQuery = value;
                    });
                    handleSearch();
                  },
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          const Divider(),
          const IntrinsicHeight(
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: EdgeInsets.only(left: 20.0),
                    child: Center(
                      child: Text(
                        "المديونية",
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Center(
                    child: VerticalDivider(),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: EdgeInsets.only(right: 5.0),
                    child: Text(
                      "اسم العميل",
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(),
          Expanded(
            child: StreamBuilder<QuerySnapshot<DebtModel>>(
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                var debtList =
                    snapshot.data?.docs.map((doc) => doc.data()).toList();
                if (debtList?.isEmpty == true) {
                  return Center(
                    child: Text(
                      "!! فارغ",
                      style: GoogleFonts.abel(
                        fontSize: 30,
                      ),
                    ),
                  );
                }
                return ListView.builder(
                  itemBuilder: (context, index) {
                    final debt = debtList![index];
                    return DebtItem(debtModel: debt);
                  },
                  itemCount: debtList?.length ?? 0,
                );
              },
              stream: searchStream,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
