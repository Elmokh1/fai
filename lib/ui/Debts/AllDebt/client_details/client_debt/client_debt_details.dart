import 'package:fai/database/model/debt_model.dart';
import 'package:fai/database/model/invoice_model.dart';

import '../../../../../../import.dart';
import 'client_details_widget.dart';

class ClientDebtDetails extends StatefulWidget {
  DebtModel debtModel;

  ClientDebtDetails({required this.debtModel});

  @override
  State<ClientDebtDetails> createState() => _ClientDebtDetailsState();
}

class _ClientDebtDetailsState extends State<ClientDebtDetails> {
  var auth = FirebaseAuth.instance;
  User? user;
  late Stream<QuerySnapshot<clientInvoiceModel>> searchStream;
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    user = auth.currentUser;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
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
                        "التاريخ ",
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
                      "تحصيل / بيع",
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
            child: StreamBuilder<QuerySnapshot<clientInvoiceModel>>(
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                var clientInvoiceList =
                    snapshot.data?.docs.map((doc) => doc.data()).toList();
                if (clientInvoiceList?.isEmpty == true) {
                  return Center(
                    child: Text(
                      "لا توجد فواتير ",
                      style: GoogleFonts.abel(
                        fontSize: 30,
                      ),
                    ),
                  );
                }
                return ListView.builder(
                  itemBuilder: (context, index) {
                    final clientInvoice = clientInvoiceList![index];
                    return ClientDebtDetailsWidget(
                        clientInvoice: clientInvoice);
                  },
                  itemCount: clientInvoiceList?.length ?? 0,
                );
              },
              stream: MyDataBase.getClientInvoiceRealTimeUpdate(
                  user?.uid ?? "", widget.debtModel.id ?? ""),
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
