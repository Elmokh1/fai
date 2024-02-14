import 'dart:io';

import 'package:fai/database/model/add_post_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

import '../../import.dart';

class AddPost extends StatefulWidget {
  static const String routeName = "AddPost";

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  var titleController = TextEditingController();
  var contentController = TextEditingController();
  ImagePicker imagePicker = ImagePicker();
  String? imageUrl;
  bool loading = false;
  var formKey = GlobalKey<FormState>();

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
      appBar: AppBar(),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                CustomTextFormField(
                  Label: "العنوان",
                  controller: titleController,
                  validator: (text) {
                    if (text == null || text.trim().isEmpty) {
                      return 'Please Enter Title ';
                    }
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                CustomTextFormField(
                  Label: "المحتوي",
                  maxlines: 20,
                  controller: contentController,
                  validator: (text) {
                    if (text == null || text.trim().isEmpty) {
                      return 'Please Enter Title ';
                    }
                  },
                ),
                Container(
                  width: double.infinity,
                  height: 200,
                  color: Colors.white,
                  child: Center(
                    child: InkWell(
                      onTap: () async {
                        XFile? xfile = await imagePicker.pickImage(
                          source: ImageSource.gallery,
                        );
                        if (xfile == null) return;
                        String uniqueFileName =
                        DateTime.now().millisecondsSinceEpoch.toString();
                        Reference referencRoot = FirebaseStorage.instance.ref();
                        Reference referencDirImages =
                        referencRoot.child('images');
                        Reference referencImageToUpLoad =
                        referencDirImages.child(uniqueFileName);
                        try {
                          setState(() {
                            loading = true;
                          });
                          await referencImageToUpLoad.putFile(File(xfile.path));
                          imageUrl =
                          await referencImageToUpLoad.getDownloadURL();
                          print("imageUrl:$imageUrl");
                        } catch (error) {
                          print(error);
                        }
                        setState(() {
                          loading = false;
                        });
                      },
                      child:
                      loading
                          ? const CircularProgressIndicator() // رمز الانتظار
                          : imageUrl == null
                          ? const Icon(Icons.image)
                          : Image.network(
                        imageUrl!,
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue.withOpacity(.7),
                          fixedSize: const Size(200, 100),
                          padding: const EdgeInsets.all(16)),
                      onPressed: () {
                        addPost();
                      },
                      child: const Text(
                        'نشر ',
                        style: TextStyle(fontSize: 30, color: Colors.white),
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void addPost() async {
    if (formKey.currentState?.validate() == false) {
      return;
    }
    AddPostModel addPost = AddPostModel(
      dateTime: DateTime.now(),
      photo: imageUrl,
      title: titleController.text,
      content: contentController.text,
      uId: user?.email ??"",
    );

    await MyDataBase.addAddPost(
      addPost,
    );

    DialogUtils.hideDialog(context);
    Fluttertoast.showToast(
        msg: "Post Added Successfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
