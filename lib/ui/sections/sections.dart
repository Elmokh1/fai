import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fai/ui/sections/widget/product/poduct_details.dart';
import 'package:fai/ui/sections/widget/product/product%20review.dart';
import 'package:fai/ui/sections/widget/section/section%20review.dart';
import 'package:fai/ui/sections/widget/section/section_allproduct.dart';

import '../../database/model/secttions_model.dart';
import '../../import.dart';
import '../Product/details_screen.dart';

class Sections extends StatefulWidget {
  bool showOrderNow;


  Sections({
    required this.showOrderNow,

  });

  @override
  State<Sections> createState() => _SectionsState();
}

class _SectionsState extends State<Sections> {
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
    String userId = user?.uid ?? "";
    return   Scaffold(
      backgroundColor: Color(0xffD9EBFC),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(80.0),
          child: Padding(
            padding: EdgeInsets.only(left:20, right: 20),
            child: AppBar(
              backgroundColor: Color(0xff49688D),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      "AGRI HAWK PRODUCTION TECHNOLOGY",
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      style: GoogleFonts.aBeeZee(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              centerTitle: true,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50),
                ),
              ),
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: [
              Expanded(
                child: StreamBuilder<QuerySnapshot<SectionsModel>>(
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text(snapshot.error.toString());
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    var sectionList =
                        snapshot.data?.docs.map((doc) => doc.data()).toList();
                    if (sectionList?.isEmpty == true) {
                      return Center(
                        child: Text(
                          "!! فاضي ",
                          style: GoogleFonts.abel(
                            fontSize: 30,
                          ),
                        ),
                      );
                    }

                    return ListView.builder(
                      itemCount: sectionList?.length ?? 0,
                      itemBuilder: (context, index) {
                        final section = sectionList![index];
                        final secId = section.id;

                        return Column(
                          children: [
                            InkWell(
                              child: SectionReview(sections: section),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SectionAllProduct(sectionsModel: section, showOrederNow: widget.showOrderNow),
                                  ),
                                );
                              },
                            ),
                            StreamBuilder<QuerySnapshot<AddProductModel>>(
                              builder: (context, snapshot) {
                                if (snapshot.hasError) {
                                  return Text(snapshot.error.toString());
                                }
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                                var productList = snapshot.data?.docs
                                    .map((doc) => doc.data())
                                    .toList();
                                if (productList?.isEmpty == true) {
                                  return Center(
                                    child: Text(
                                      "!! فاضي ",
                                      style: GoogleFonts.abel(
                                        fontSize: 30,
                                      ),
                                    ),
                                  );
                                }

                                return Directionality(
                                  textDirection: TextDirection.rtl,
                                  child: Container(
                                    height: 150,
                                    width: double.infinity,
                                    child: ListView.builder(
                                      itemCount: productList?.length ?? 0,
                                      scrollDirection: Axis.horizontal,
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) {
                                        final product = productList![index];
                                        return InkWell(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    ProductDetails(
                                                        addProductModel:
                                                            product,
                                                        showOrederNow: widget
                                                            .showOrderNow),
                                              ),
                                            );
                                          },
                                          child: ProductView(addProductModel: product),
                                        );
                                      },
                                    ),
                                  ),
                                );
                              },
                              stream: MyDataBase.getAddProductsRealTimeUpdate(
                                  secId ?? ""),
                            ),
                            SizedBox(
                              height: 50,
                            )
                          ],
                        );
                      },
                    );
                  },
                  stream: MyDataBase.getSectionsRealTimeUpdate(),
                ),
              ),
            ],
          ),
        ),

    );
  }
}
