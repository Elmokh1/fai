import 'dart:io';

import 'package:fai/import.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

import '../../database/model/secttions_model.dart';

class EditPriceItem extends StatefulWidget {
  AddProductModel addProductModel;

  EditPriceItem({required this.addProductModel});

  @override
  State<EditPriceItem> createState() => _SaleInvoiceItemState();
}

class _SaleInvoiceItemState extends State<EditPriceItem> {
  late TextEditingController priceController;

  ImagePicker imagePicker = ImagePicker();
  String? imageUrl;
  bool loading = false;
  String? selectedSection;
  String? selectedSectionId;

  @override
  void initState() {
    super.initState();
    priceController =
        TextEditingController(text: widget.addProductModel.price.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: EdgeInsets.all(40),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14.0),
          color: Colors.white,
        ),
        child: Column(
          children: [
            Row(
              children: [
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
                    radius: 20,
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
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 7.0),
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(12.0)),
                  child: Text(widget.addProductModel.product ?? ""),
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      widget.addProductModel.price =
                          int.parse(priceController.text);
                      addProduct();
                    });
                  },
                  child: Text("ok"),
                )
              ],
            ),
            CustomTextFormField(
              Label: "السعر",
              controller: priceController,
              validator: (p0) {},
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
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      var sectionList =
                          snapshot.data?.docs.map((doc) => doc.data()).toList();
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
                                          (section) => section.name == newValue,
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
            InkWell(
              onTap: ()async{
                await MyDataBase.deleteProoooduct(
                  widget.addProductModel.id ?? "",
                );

              },
                child: Icon(
              Icons.delete,
              color: Colors.red,
            )),
          ],
        ),
      ),
    );
  }

  void addProduct() async {
    AddProductModel addProductModel = AddProductModel(
      imageUrl: imageUrl,
      des: widget.addProductModel!.des,
      price: widget.addProductModel.price,
      product: widget.addProductModel.product,
    );

    await MyDataBase.addAddProduct(
      selectedSectionId ?? "",
      addProductModel,
    );
    await MyDataBase.deleteProoooduct(
      widget.addProductModel.id ?? "",
    );

    DialogUtils.hideDialog(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("تم تعديل المنتج")),
    );  }
}
