import 'package:fai/database/model/questions_model.dart';

import '../../import.dart';

class AddQuestionPage extends StatefulWidget {
  const AddQuestionPage({Key? key}) : super(key: key);

  @override
  State<AddQuestionPage> createState() => _AddQuestionPageState();
}

class _AddQuestionPageState extends State<AddQuestionPage> {
  var questionController = TextEditingController();
var answerController = TextEditingController();
var formKey = GlobalKey<FormState>();

@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: CustomTextFormField(
                  controller: questionController,
                  Label: " question",
                  // controller: nameController,
                  validator: (text) {
                    if (text == null || text.trim().isEmpty) {
                      return 'Please Enter Product Name ';
                    }
                  },
                ),
              ),
              SizedBox(height: 100,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: CustomTextFormField(
                  maxlines: 20,
                  controller: answerController,
                  Label: "answer",
                  // controller: nameController,
                  validator: (text) {
                    if (text == null || text.trim().isEmpty) {
                      return 'Please Enter Product Quantity ';
                    }
                  },
                ),
              ),
              SizedBox(height: 100,),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: ElevatedButton(

                  style: ElevatedButton.styleFrom(
                      fixedSize: Size(200, 80)
                  ),
                  onPressed: () {
                    Add();
                  },
                  child: const Text(
                    'Add',
                    style: TextStyle(fontSize: 24),
                  ),
                ),
              ),

            ],
          ),
        ),
      ),

    );
  }

  void Add() async {
    if (formKey.currentState?.validate() == false) {
      return;
    }
    QuestionsModel questionsModel = QuestionsModel(
      dateTime: DateTime.now(),
      answer: answerController.text,
      questions: questionController.text,

    );
    await MyDataBase.addQuestions(questionsModel);

    print('Questions added successfully');
    DialogUtils.hideDialog(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Questions added successfully")),
    );  }
}
