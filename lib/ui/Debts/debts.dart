import '../../../import.dart';
import 'AllDebt/show_debts_page.dart';
import 'add_client_bottomsheet.dart';

class DebtManagementPage extends StatefulWidget {
  String? userId;
  bool? isAdmin;

  DebtManagementPage({this.userId, this.isAdmin});

  @override
  _DebtManagementPageState createState() => _DebtManagementPageState();
}

class _DebtManagementPageState extends State<DebtManagementPage> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Debt Management'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery
                  .of(context)
                  .size
                  .height * .05,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      showAddClientModal();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Container(
                          height: MediaQuery
                              .of(context)
                              .size
                              .height * 0.3,
                          child: Center(
                            child: Text(
                              "اضافه عميل",
                              style: GoogleFonts.acme(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>
                              ShowAllDebtPage(
                                userId: widget.isAdmin == false ?  "" : widget.userId ?? "",

                                isUser:widget.isAdmin ?? false,
                              ),)
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Container(
                          height: MediaQuery
                              .of(context)
                              .size
                              .height * 0.3,
                          child: Center(
                            child: Text(
                              "المديونيات",
                              style: GoogleFonts.acme(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery
                  .of(context)
                  .size
                  .height * .2,
            ),
          ],
        ),
      ),
    );
  }

  void showAddClientModal() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(
              bottom: MediaQuery
                  .of(context)
                  .viewInsets
                  .bottom,
            ),
            child: AddClientBottomSheet(isUser: widget.isAdmin ?? false,),
          ),
        );
      },
    );
  }
}
