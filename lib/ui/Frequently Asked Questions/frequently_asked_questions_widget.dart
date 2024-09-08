import 'package:fai/database/model/questions_model.dart';

import '../../import.dart';

class FrequentlyAskedQuestionsWidget extends StatelessWidget {

  QuestionsModel questionsModel;
  String qNum;

  FrequentlyAskedQuestionsWidget({required this.questionsModel,required this.qNum});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundColor:Color(0xff49688D) ,
                      radius: 15,
                      child: Text(qNum,style: TextStyle(color: Colors.white),),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: Text(
                        "${questionsModel.questions}؟",
                        style: GoogleFonts.cairo(fontSize: 18, fontWeight: FontWeight.bold,color: Color(0xff49688D)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 35,right: 35),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(width: .1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                    "${questionsModel.answer}",
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    maxLines: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
