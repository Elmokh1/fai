import 'package:fai/database/model/debt_model.dart';

import '../../../../../database/model/invoice_model.dart';
import '../../../../../import.dart';

class Invoice extends StatefulWidget {

  DebtModel debtModel;

  Invoice({required this.debtModel});

  @override
  State<Invoice> createState() => _InvoiceState();
}

class _InvoiceState extends State<Invoice> {
  TextEditingController invoiceController= TextEditingController();

  var formKey = GlobalKey<FormState>();
  var auth = FirebaseAuth.instance;
  User? user;

  @override
  void initState() {
    super.initState();
    user = auth.currentUser;
  }
  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          CustomTextFormField(
            controller : invoiceController ,
            validator: (text) {
              if (text == null || text.trim().isEmpty) {
                return 'please enter Payment Details';
              }
            },
            Label : "Invoice",

          ),
          const Padding(
            padding: EdgeInsets.only(
              left: 20.0,
              top: 20,
              bottom: 5,
            ),
            child: Text(
              "Selected time",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Center(
            child: InkWell(
              onTap: () {
                showTaskDatePicker();
              },
              child: Text(
                "${MyDateUtils.formatTaskDate(selectedDate)}",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: SizedBox(
              width: double.infinity, // Set width to fill the screen
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(16),
                ),
                onPressed: () {
                  addInvoiceClient();
                },
                child: const Text(
                  'Add',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          )

        ],
      ),
    );
  }

  var selectedDate = DateTime.now();

  void showTaskDatePicker() async {
    var date = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now().subtract(Duration(days: 2)),
      lastDate: DateTime.now().add(
        Duration(days: 365),
      ),
    );
    if (date == null) return;
    setState(() {
      selectedDate = date;
    });
  }

  void addInvoiceClient() async {
    double newDebt = (double.parse(widget.debtModel.oldDebt?.toString() ?? '0.0')) + double.parse(invoiceController.text);
    if (formKey.currentState?.validate() == false) {
      return;
    }
    await MyDataBase.editDebt(
      user?.uid ?? "",
      widget.debtModel.id ?? "",
      newDebt,

    );
    DialogUtils.hideDialog(context);
    clientInvoiceModel clientInvoice = clientInvoiceModel(
      clientName: widget.debtModel.clientName,
      oldDebt: widget.debtModel.oldDebt,
      payment: double.parse(invoiceController.text??""),
      dateTime: selectedDate,
      newDebt:newDebt,
    );

    await MyDataBase.addClientInvoice(user?.uid ?? "", clientInvoice,widget.debtModel.id??"");
    Fluttertoast.showToast(
        msg: "Payment Add Successfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0);
    Navigator.pop(context);
  }

}
