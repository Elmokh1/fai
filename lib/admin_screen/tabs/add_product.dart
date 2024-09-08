import 'dart:io';

import 'package:fai/import.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

import '../../database/model/secttions_model.dart';

class AddProduct extends StatefulWidget {
  static const String routeName = "AddProduct";

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  var nameController = TextEditingController();
  var PriceController = TextEditingController();
  var desController = TextEditingController();
  TextEditingController sectionController = TextEditingController();

  var formKey = GlobalKey<FormState>();
  ImagePicker imagePicker = ImagePicker();
  String? imageUrl;
  bool loading = false;
  String? selectedSection;
  String? selectedSectionId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              // CustomTextFormField(
              //   Label: 'اسم الفئه',
              //   controller: sectionController,
              //   validator: (text) {
              //     if (text == null || text.trim().isEmpty) {
              //       return 'please enter section name';
              //     }
              //   },
              // ),
              // const SizedBox(
              //   height: 10,
              // ),
              // Padding(
              //   padding: const EdgeInsets.all(20.0),
              //   child: ElevatedButton(
              //       style: ElevatedButton.styleFrom(
              //           padding: const EdgeInsets.all(16)),
              //       onPressed: () {
              //         addSection();
              //       },
              //       child: const Text(
              //         'Add ',
              //         style: TextStyle(fontSize: 18),
              //       )),
              // ),
              InkWell(
                onTap: () async {
                  XFile? xfile = await imagePicker.pickImage(
                    source: ImageSource.gallery,
                  );
                  if (xfile == null) return;
                  String uniqueFileName =
                      DateTime.now().millisecondsSinceEpoch.toString();
                  Reference referencRoot = FirebaseStorage.instance.ref();
                  Reference referencDirImages = referencRoot.child('images');
                  Reference referencImageToUpLoad =
                      referencDirImages.child(uniqueFileName);
                  try {
                    setState(() {
                      loading = true;
                    });
                    await referencImageToUpLoad.putFile(File(xfile.path));
                    imageUrl = await referencImageToUpLoad.getDownloadURL();
                    print("imageUrl:$imageUrl");
                  } catch (error) {
                    print(error);
                  }
                  setState(() {
                    loading = false;
                  });
                },
                child: CircleAvatar(
                  radius: 80,
                  backgroundColor: Colors.black,
                  child: loading
                      ? const CircularProgressIndicator()
                      : imageUrl == null
                          ? const Icon(Icons.image)
                          : CircleAvatar(
                              radius: 75,
                              backgroundImage: NetworkImage(
                                imageUrl ?? "",
                              ),
                            ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: CustomTextFormField(
                    controller: nameController,
                    Label: "اسم المنتج",
                    validator: (text) {
                      if (text == null || text.trim().isEmpty) {
                        return 'Please Enter Product Name ';
                      }
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: CustomTextFormField(
                    controller: PriceController,
                    Label: "السعر",
                    // controller: nameController,
                    validator: (text) {
                      if (text == null || text.trim().isEmpty) {
                        return 'Please Enter Product Price ';
                      }
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: CustomTextFormField(
                    controller: desController,
                    Label: "التفاصيل",
                    lines: 1,
                    maxlines: 100,
                    validator: (text) {
                      if (text == null || text.trim().isEmpty) {
                        return 'Please Enter Product Details ';
                      }
                    },
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: StreamBuilder<QuerySnapshot<SectionsModel>>(
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
                        var sectionList = snapshot.data?.docs
                            .map((doc) => doc.data())
                            .toList();
                        print(sectionList.toString());
                        if (sectionList?.isEmpty == true) {
                          return Center(
                            child: Text(
                              "لا توجد فئات ",
                              style: GoogleFonts.abel(
                                fontSize: 30,
                              ),
                            ),
                          );
                        }
                        return Container(
                          height: 50,
                          child: ListView.builder(
                            itemBuilder: (context, index) {
                              final section = sectionList![index];
                              return Container(
                                width: 342,
                                height: 48,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                    color: const Color(0xffB6B6B6),
                                  ),
                                ),
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Directionality(
                                  textDirection: TextDirection.rtl,
                                  child: Container(
                                    height: 48,
                                    child: DropdownButton<String>(
                                      value: selectedSection,
                                      items: sectionList?.map((section) {
                                        return DropdownMenuItem<String>(
                                          value: section.name,
                                          child: Text(section.name ?? ""),
                                        );
                                      }).toList(),
                                      onChanged: (newValue) {
                                        setState(() {
                                          selectedSection = newValue;
                                          var selectedSectionData =
                                              sectionList?.firstWhere(
                                            (section) =>
                                                section.name == newValue,
                                            orElse: () => SectionsModel(),
                                          );
                                          if (selectedSectionData != null) {
                                            print(
                                                'Selected section ID: ${selectedSectionData.id}');
                                          }
                                          selectedSectionId =
                                              selectedSectionData?.id;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              );
                            },
                            itemCount: 1, // Use the length of sectionList
                          ),
                        );
                      },
                      stream: MyDataBase.getSectionsRealTimeUpdate(),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(fixedSize: Size(200, 80)),
                  onPressed: () {
                    addProduct();
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

  void addProduct() async {
    if (formKey.currentState?.validate() == false) {
      return;
    }
    AddProductModel addProductModel = AddProductModel(
      imageUrl: imageUrl,
      des: desController.text,
      price: int.parse(PriceController.text),
      product: nameController.text,
    );

    await MyDataBase.addAddProduct(
      selectedSectionId ?? "",
      addProductModel,
    );

    DialogUtils.hideDialog(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Product added successfully")),
    );  }  }
// void addSection() async {
//
//   // if (formKey.currentState?.validate() == false) {
//   //   return;
//   // }
//   SectionsModel sections = SectionsModel(
//       name: sectionController.text
//   );
//
//
//   await MyDataBase.addSections(
//       sections);
//   DialogUtils.hideDialog(context);
//   Fluttertoast.showToast(
//       msg: "Section Add Successfully",
//       toastLength: Toast.LENGTH_SHORT,
//       gravity: ToastGravity.TOP,
//       timeInSecForIosWeb: 1,
//       backgroundColor: Colors.green,
//       textColor: Colors.white,
//       fontSize: 16.0);
// }

