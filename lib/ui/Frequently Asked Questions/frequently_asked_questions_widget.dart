import 'package:fai/database/model/questions_model.dart';

import '../../import.dart';

class FrequentlyAskedQuestionsWidget extends StatelessWidget {

  QuestionsModel questionsModel;

  FrequentlyAskedQuestionsWidget({required this.questionsModel});

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
              child: Text(
                "${questionsModel.questions}",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                  "${questionsModel.answer}",
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  maxLines: 15),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0,vertical: 10,),
              child: Divider(
                thickness: 4,
                color: Color(0xffF4DFBA),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
