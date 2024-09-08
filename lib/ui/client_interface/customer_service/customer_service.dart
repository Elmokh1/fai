import '../../../import.dart';

class CustomerService extends StatelessWidget {
  static const String routeName = "CustomerService";

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height*1,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/customer_back.jpeg"),
                fit: BoxFit.fill)),
        child: Column(
          children: [
            SizedBox(height: 40,),
            CircleAvatar(
              radius: 90,
              backgroundColor: Colors.transparent,
              backgroundImage: AssetImage("assets/images/agriLogo.png"),
            ),
            Container(
              height: 60,
              width: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Color(0xff49688D),
              ),
              child: Center(
                child: Text(
                  "رسالتنا",
                  style: GoogleFonts.habibi(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 30),
                ),
              ),
            ),
            Directionality(
              textDirection: TextDirection.rtl,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "من هنا بدأت أجرى هوك للتنميه الزراعيه تعمل على توفير المركبات التى تقدم افضل الحلول للمشاكل الزراعيه بمصر بالعمل مع جميع الجهات العلميه و البحثيه و كذلك توجيه المزارع على كيفيه الاستفاده من هذه المركبات و حسن توظيفها .",
                  style: GoogleFonts.habibi(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 12),
                ),
              ),
            ),
            Container(
              height: 60,
              width: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Color(0xff49688D),
              ),
              child: Center(
                child: Text(
                  "رؤيتنا",
                  style: GoogleFonts.habibi(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 30),
                ),
              ),
            ),
            Directionality(
              textDirection: TextDirection.rtl,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "من الشركات الواعدة في السوق المصري التي تسعي للنهوض بالقطاع الزراعي في مصر والشرق الاوسط للوصول الي منتج عالي الجوده والقيمه .",
                  style: GoogleFonts.habibi(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 12),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                    height: 50,
                    width: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(
                          Icons.email_rounded,
                          color: Colors.blueAccent,
                        ),
                        Text("agrihawk6@gmail.com"),
                      ],
                    )),
                Container(
                    height: 50,
                    width: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(
                            'assets/images/whatsicon.png',
                            width: 30,
                            height: 30,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("+20 107 054 5997"),
                        ),
                      ],
                    )),
              ],
            ),
            SizedBox(height: 10,),
            Container(
              height: 60,
              width: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Color(0xff49688D),
              ),
              child: Center(
                child: Text(
                  "العنوان",
                  style: GoogleFonts.habibi(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 30),
                ),
              ),
            ),

            Container(
              margin: EdgeInsets.all(10),
              width: double.infinity,
              height: 40,
              color: Colors.white,
              child: Center(
                child: Row(
                  children: [
                    Icon(Icons.location_on,color: Colors.red,),
                    Text("Zagazig - Alghasham - Almuslamy Tower - 10th floor",style: TextStyle(
                      color: Color(0xff49688D),
                      fontWeight: FontWeight.bold,
                    ),maxLines: 2,),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10,),
            Container(
              margin: EdgeInsets.all(10),
              width: double.infinity,
              height: 40,
              color: Colors.white,
              child: Center(
                child: Row(
                  children: [
                    Icon(Icons.location_on,color: Colors.red,),
                    Expanded(
                      child: Text("Minya - Taha Hussein Street - in front of the club wall - Alexandrian Tower",style: TextStyle(
                        color: Color(0xff49688D),
                        fontWeight: FontWeight.bold,
                      ),),
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () async {
                try {
                  await FirebaseAuth.instance.signOut();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("تم تسجيل الخروج بنجاح")),
                  );
                  Navigator.pushReplacementNamed(context, LoginScreen.routeName);
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("حدث خطأ أثناء تسجيل الخروج: $e")),
                  );
                }
              },
              child: Container(
                height: 60,
                width: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color:Colors.red,
                ),
                child: Center(
                  child: Text(
                    "تسجيل الخروج",
                    style: GoogleFonts.habibi(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ),
              ),
            ),



          ],
        ),
      ),
    );
  }
}
