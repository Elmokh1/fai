import 'package:fai/import.dart';

import '../../../database/model/debt_model.dart';

class AddClientBottomSheet extends StatefulWidget {

  @override
  State<AddClientBottomSheet> createState() => _AddClientBottomSheetState();
}

class _AddClientBottomSheetState extends State<AddClientBottomSheet> {
  TextEditingController clientNameController = TextEditingController();
  TextEditingController oldDebtController = TextEditingController(text: "0");

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
    return Container(
      color: Colors.white,
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Text(
                'Add Client',
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
            CustomTextFormField(
              Label: 'اسم العميل  ',
              controller: clientNameController,
              validator: (text) {
                if (text == null || text.trim().isEmpty) {
                  return 'please enter Client name';
                }
              },
            ),
            const SizedBox(
              height: 10,
            ),
            CustomTextFormField(
              Label: " المديونيه ",
              controller: oldDebtController,
              validator: (text) {
                if (text == null || text.trim().isEmpty) {
                  return 'please enter debts';
                }
                return null;
              },
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(16)),
                  onPressed: () {
                    addClient();
                  },
                  child: const Text(
                    'Add ',
                    style: TextStyle(fontSize: 18),
                  )),
            )
          ],
        ),
      ),
    );
  }

  void addClient() async {
    double oldDebt = double.parse(oldDebtController.text);

    if (formKey.currentState?.validate() == false) {
      return;
    }
    DebtModel debtModel = DebtModel(
      clientName: clientNameController.text,
      oldDebt: oldDebt,
    );

    await MyDataBase.addDebt(
      user?.uid ?? "",
      debtModel
    );
    DialogUtils.hideDialog(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("تم اضافه العميل ")),
    );
  }


}
