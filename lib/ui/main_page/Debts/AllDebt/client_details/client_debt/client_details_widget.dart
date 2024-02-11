import 'package:fai/database/model/debt_model.dart';
import 'package:fai/database/model/invoice_model.dart';
import 'package:fai/ui/main_page/Debts/AllDebt/client_details/client_details.dart';
import 'package:intl/intl.dart';

import '../../../../../../import.dart';

class ClientDebtDetailsWidget extends StatelessWidget {
  clientInvoiceModel clientInvoice;

  ClientDebtDetailsWidget({required this.clientInvoice});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IntrinsicHeight(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Center(
                    child: Text(
                      ' ${DateFormat('yyyy-MM-dd').format(clientInvoice.dateTime!)}',
                      style: TextStyle(
                        fontSize: 12,
                        color: clientInvoice.isInvoice == true
                            ? Colors.green
                            : Colors.red,
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
                  padding: const EdgeInsets.only(right: 5.0),
                  child: Text(
                    "${clientInvoice.payment}",
                    style: TextStyle(
                      fontSize: 12,
                      color: clientInvoice.isInvoice == true
                          ? Colors.green
                          : Colors.red,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Divider(),
      ],
    );
  }
}
