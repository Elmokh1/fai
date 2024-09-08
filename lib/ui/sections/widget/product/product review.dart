import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../database/model/customer_model.dart';
import '../../../../import.dart';

class ProductView extends StatefulWidget {
  final AddProductModel addProductModel;

  ProductView({required this.addProductModel});

  @override
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  var auth = FirebaseAuth.instance;
  User? user;

  @override
  void initState() {
    super.initState();
    user = auth.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SizedBox(
        height: 140,
        child: Stack(
          alignment: AlignmentDirectional.centerEnd,
          children: [
            Container(
              width: 200,
              height: 140,
            ),
            Positioned(
              right: 0,
              child: Container(
                width: 150,
                height: 90,
                decoration: BoxDecoration(
                  // color: Color(0xff494949),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  // border: Border.all(
                  //   color: const Color(0xff65451F).withOpacity(.6),
                  // ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${widget.addProductModel.product}",
                        maxLines: 2,
                        style: GoogleFonts.inter(
                          color: Colors.black,
                          fontSize: 11,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      StreamBuilder<QuerySnapshot<CustomerModel>>(
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

                          final pendingUser = userList![0];
                          if (pendingUser.isCustomer == true &&
                              pendingUser.isFarmer == true &&
                              pendingUser.isEng == true) {
                            return Text("${widget.addProductModel.price} LE",style: TextStyle(
                              color: Colors.red
                            ),);
                          } else if (pendingUser.isCustomer == true &&
                              pendingUser.isFarmer == true &&
                              pendingUser.isEng == false) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("${widget.addProductModel.price} LE",style: TextStyle(
                                  color: Colors.red
                              ),),
                            );
                          }
                          return Text("");
                        },
                        stream: MyDataBase.getCustomerDataRealTimeUpdate(user!.uid),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              left: 0,
              child: Container(
                width: 100,
                height: 140,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      "${widget.addProductModel.imageUrl}",
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
