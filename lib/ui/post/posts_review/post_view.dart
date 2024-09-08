import 'package:fai/database/model/add_post_model.dart';
import 'package:fai/ui/post/posts_review/post_widget.dart';

import '../../../import.dart';

class PostView extends StatefulWidget {


  @override
  State<PostView> createState() => _PostViewState();
}

class _PostViewState extends State<PostView> {
  var auth = FirebaseAuth.instance;
  User? user;

  @override
  void initState() {
    super.initState();
    user = auth.currentUser;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    "Posts",
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    style: GoogleFonts.aBeeZee(
                      color: Colors.white,
                      fontSize: 40,
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
      body: Column(
        children: [
          SizedBox(height: 15,),
          Expanded(
            child: StreamBuilder<QuerySnapshot<AddPostModel>>(
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                var postList = snapshot.data?.docs.map((doc) => doc.data()).toList();
                if (postList?.isEmpty == true) {
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
                  itemBuilder: (context, index) {
                    final post = postList![index];
                      return Directionality(textDirection: TextDirection.rtl,child: PostWidget(addPostModel: post,));
                  },
                  itemCount: postList?.length ?? 0,
                );
              },
              stream: MyDataBase.getAddPostsRealTimeUpdate(
              ),
            ),
          ),
        ],
      ),
    );
  }
}
