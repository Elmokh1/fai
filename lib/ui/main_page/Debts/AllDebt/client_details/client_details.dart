import 'package:fai/database/model/debt_model.dart';
import 'package:fai/ui/main_page/Debts/AllDebt/client_details/client_debt/client_debt_details.dart';
import 'package:fai/ui/main_page/Debts/AllDebt/client_details/invoice.dart';
import 'package:fai/ui/main_page/Debts/AllDebt/client_details/recive_payment.dart';

import '../../../../../import.dart';

class ClientDetails extends StatefulWidget {
  DebtModel debtModel;

  ClientDetails(this.debtModel);

  @override
  State<ClientDetails> createState() => _ClientDetailsState();
}

class _ClientDetailsState extends State<ClientDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("${widget.debtModel.clientName}"),
      ),
      body:
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * .03,
              ),
              InkWell(
                onTap: () {
                  showReceivePaymentModal();
                },
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.2,
                      child: Center(
                        child: Text(
                          "تحصيل",
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
              InkWell(
                onTap: () {
                  showInvoiceClientModal();
                },
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.2,
                      child: Center(
                        child: Text(
                          "بيع",
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
              InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ClientDebtDetails(debtModel: widget.debtModel),));
                },
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.2,
                      child: Center(
                        child: Text(
                          " المديونيه",
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
              SizedBox(
                height: MediaQuery.of(context).size.height * .1,
              ),
            ],
          ),
    );
  }

  void showReceivePaymentModal() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child:ReceivePayment(debtModel: widget.debtModel,) ,
          ),
        );
      },
    );
  }

  void showInvoiceClientModal() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child:Invoice(debtModel: widget.debtModel,) ,
          ),
        );
      },
    );
  }
}
