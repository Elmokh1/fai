import 'package:fai/database/my_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../database/model/customer_model.dart';


class PendingContainer extends StatelessWidget {
  final CustomerModel pendingUser;

  const PendingContainer({required this.pendingUser});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        width: double.infinity,
        height: 200,
        margin: EdgeInsets.all(40),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            Text(
              "${pendingUser.name}",
              style: GoogleFonts.mogra(
                fontSize: 40,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: (){
                    MyDataBase.editCustomer(pendingUser?.id ?? "", true, true);
                  },
                  child: Icon(
                    Icons.check_circle,
                    size: 40,
                    color: Colors.green,
                  ),
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.3),
                InkWell(
                  onTap: (){
                    MyDataBase.editCustomer(pendingUser?.id ?? "", false, true);
                  },
                  child: Icon(
                    Icons.cancel,
                    size: 40,
                    color: Colors.red,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
