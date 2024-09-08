

import '../../../../database/model/customer_model.dart';
import '../../../../import.dart';

class ProductViewInSection extends StatefulWidget {
  final AddProductModel addProductModel;

  ProductViewInSection({required this.addProductModel});

  @override
  State<ProductViewInSection> createState() => _ProductViewInSectionState();
}


class _ProductViewInSectionState extends State<ProductViewInSection> {
  var auth = FirebaseAuth.instance;
  User? user;

  @override
  void initState() {
    super.initState();
    user = auth.currentUser;
    print(user?.uid ?? "");
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SizedBox(
        height: 140,
        width: double.infinity,
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Container(
            width: 240,
            height: 140,
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xff65451F).withOpacity(.6)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 6,
                  child: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            image:
                                NetworkImage("${widget.addProductModel.imageUrl}"))),
                  ),
                ),
                Row(
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Center(
                            child: Text(
                              "${widget.addProductModel.product}",
                              style: GoogleFonts.inter(
                                color: const Color(0xff65451F),
                                // fontSize: 15,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
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
                              return Padding(
                                padding: const EdgeInsets.only(top: 6.0),
                                child: Text(
                                  "${widget.addProductModel.price}EG",
                                  style: GoogleFonts.inter(
                                    color: const Color(0xff65451F),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              );
                            } else if (pendingUser.isCustomer == true &&
                                pendingUser.isFarmer == true &&
                                pendingUser.isEng == false) {
                              return Padding(
                                padding: const EdgeInsets.only(top: 6.0),
                                child: Text(
                                  "${widget.addProductModel.price}EG",
                                  style: GoogleFonts.inter(
                                    color: const Color(0xff65451F),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              );

                            }
                            return Text("");
                          },
                          stream: MyDataBase.getCustomerDataRealTimeUpdate(user!.uid),
                        ),

                      ],
                    ),
                    Spacer(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
