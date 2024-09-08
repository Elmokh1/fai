import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fai/ui/sections/widget/product/poduct_details.dart';
import 'package:fai/ui/sections/widget/product/product%20review.dart';
import 'package:fai/ui/sections/widget/section/section%20review.dart';
import 'package:fai/ui/sections/widget/section/section_allproduct.dart';

import '../../../database/model/secttions_model.dart';
import '../../../import.dart';
import '../../Product/details_screen.dart';
import 'edit_pro.dart';
class EditSections extends StatefulWidget {
  bool showOrderNow;
  EditSections({
    required this.showOrderNow,
  });

  @override
  State<EditSections> createState() => _SectionsState();
}

class _SectionsState extends State<EditSections> {
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
    return Scaffold(
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
                                  builder: (context) => EditSectionAllProduct(
                                      sectionsModel: section,
                                      showOrederNow: widget.showOrderNow),
                                ),
                              );
                            },
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
