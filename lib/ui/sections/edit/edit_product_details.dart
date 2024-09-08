import 'dart:io';

import 'package:fai/import.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

import '../../../database/model/secttions_model.dart';


class EditProductDetails extends StatefulWidget {
  AddProductModel addProductModel;
  String SecId;
  EditProductDetails({required this.addProductModel,required this.SecId});

  @override
  State<EditProductDetails> createState() => _SaleInvoiceItemState();
}

class _SaleInvoiceItemState extends State<EditProductDetails> {
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
    return Scaffold(
      body: Padding(
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
                ],
              ),
              InkWell(
                  onTap: ()async{
                    await MyDataBase.deleteProduct(
                      widget.SecId,
                      widget.addProductModel.id ?? "",
                    );

                  },
                  child: Icon(
                    Icons.delete,
                    color: Colors.red,
                  )),
              SizedBox(height: 30,),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    print(widget.SecId);
                    print(widget.addProductModel.id);
                    widget.addProductModel.price = int.parse(priceController.text);
                    addProduct();
                  });
                },
                child: Text("ok"),
              )

            ],
          ),
        ),
      ),
    );
  }

  void addProduct() async {
    // AddProductModel addProductModel = AddProductModel(
    //   imageUrl: imageUrl,
    //   des: widget.addProductModel!.des,
    //   price: widget.addProductModel.price,
    //   product: widget.addProductModel.product,
    // );

    await MyDataBase.editProduct(
      widget.SecId ?? "",
      widget.addProductModel.id ?? "",
      int.parse(priceController.text),
      imageUrl ?? "",
    );

    DialogUtils.hideDialog(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("تم")),
    );  }
}
