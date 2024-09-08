import 'package:fai/database/model/questions_model.dart';
import 'package:fai/ui/Frequently%20Asked%20Questions/frequently_asked_questions_widget.dart';

import '../../import.dart';

class FrequentlyAskedQuestions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/customer_back.jpeg"),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(80.0),
          child: Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: AppBar(
              backgroundColor: Color(0xff49688D),
              title: Text(
                "سؤال وجواب",
                style: GoogleFonts.cairo(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
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
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(
              height: 30,
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot<QuestionsModel>>(
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  var questionList =
                      snapshot.data?.docs.map((doc) => doc.data()).toList();
                  if (questionList?.isEmpty == true) {
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
                      final question = questionList![index];
                      return FrequentlyAskedQuestionsWidget(
                        questionsModel: question,
                        qNum: (index + 1).toString(),
                      );
                    },
                    itemCount: questionList?.length ?? 0,
                  );
                },
                stream: MyDataBase.getQuestionsRealTimeUpdate(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
