
import '../../../../database/model/customer_model.dart';
import '../../../../import.dart';



class ProductDetails extends StatefulWidget {
  AddProductModel addProductModel;
  bool showOrederNow;
  ProductDetails({required this.addProductModel,required this.showOrederNow});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 120),
    vsync: this,
  )..repeat();
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.bounceOut,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("${widget.addProductModel.product}",style: GoogleFonts.cairo(),),
      ),
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * .8,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 50,
                          ),
                          Center(
                            child: AnimatedBuilder(
                              animation: _controller,
                              builder: (context, child) => RotationTransition(
                                  turns: _animation,
                                  child: CircleAvatar(
                                    radius: 109,
                                    backgroundColor: Colors.black,
                                    child: CircleAvatar(
                                      radius: 109,
                                      backgroundColor: Colors.grey.shade300,
                                      child: InkWell(
                                        onTap: () {
                                          print(
                                              widget.addProductModel.imageUrl);
                                        },
                                        child: CircleAvatar(
                                          backgroundColor: Colors.white,
                                          radius: 100,
                                          backgroundImage: NetworkImage(
                                              "${widget.addProductModel.imageUrl}"),
                                        ),
                                      ),
                                    ),
                                  )),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text(
                              "اسم المنتج : ${widget.addProductModel.product}",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),

                          StreamBuilder<QuerySnapshot<CustomerModel>>(
                            builder: (context, snapshot) {
                              if (snapshot.hasError) {
                                return Text(snapshot.error.toString());
                              }
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              var userList =
                              snapshot.data?.docs.map((doc) => doc.data()).toList();
                              if (userList?.isEmpty == true) {
                                return Center(
                                  child: Text(
                                    "!! فاضي ",
                                    style: GoogleFonts.abel(
                                      fontSize: 30,
                                    ),
                                  ),
                                );
                              }

                              final pendingUser = userList![0];
                              if (pendingUser.isCustomer == true &&
                                  pendingUser.isFarmer == true &&
                                  pendingUser.isEng == true) {
                                return
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Text(
                                    "سعر المنتج  : EG${widget.addProductModel.price}",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                );
                              }
                              else  if (pendingUser.isCustomer == true &&
                                  pendingUser.isFarmer == true &&
                                  pendingUser.isEng == false)  {
                                return  Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Row(
                                    children: [
                                      Text(
                                        "سعر المنتج :",
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        " ${widget.addProductModel.price}",
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }
                              return Text("");
                            },
                            stream: MyDataBase.getCustomerDataRealTimeUpdate(user!.uid),
                          ),

                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text(
                              "التفاصيل : \n${widget.addProductModel.des}"
                                  .trim(),
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              showItemModal();
            },
            child:widget.showOrederNow == true ?  Container(
              width: 240,
              height: 60,
              decoration: BoxDecoration(
                color: Color(0xff65451F),
                borderRadius: BorderRadius.circular(50),
              ),
              child: Center(
                child:  Text(
                  "اطلب الان ",
                  style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w700),
                ),
              ),
            ) : SizedBox(),
          ),
        ],
      ),
    );
  }

  void showItemModal() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: AddItemBottomSheet(
              addProductModel: widget.addProductModel,
            ),
          ),
        );
      },
    );
  }
}
