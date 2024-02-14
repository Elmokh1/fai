import 'package:fai/database/model/questions_model.dart';
import 'package:fai/ui/Frequently%20Asked%20Questions/frequently_asked_questions_widget.dart';

import '../../import.dart';

class FrequentlyAskedQuestions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("اسئله شائعه"),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
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
                var questionList = snapshot.data?.docs.map((doc) => doc.data()).toList();
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
                      return FrequentlyAskedQuestionsWidget(questionsModel: question);

                  },
                  itemCount: questionList?.length ?? 0,
                );
              },
              stream: MyDataBase.getQuestionsRealTimeUpdate(),
            ),
          ),
        ],
      ),
    );
  }
}
