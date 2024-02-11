import 'package:fai/database/model/debt_model.dart';
import 'package:fai/ui/main_page/Debts/AllDebt/client_details/client_details.dart';
import 'package:intl/intl.dart';

import '../../../../import.dart';


class DebtItem extends StatelessWidget {
  DebtModel debtModel;

  DebtItem({required this.debtModel});

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
                      "${debtModel.oldDebt?.round().toString()}",
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
                  child: VerticalDivider(
                  ),

                ),
              ),

              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.only(right: 5.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context, MaterialPageRoute(builder: (context) => ClientDetails(
                        debtModel
                      ),),);
                    },
                    child: Text(
                      "${debtModel.clientName}",
                      style: TextStyle(
                        fontSize: 12,
                      ),
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
