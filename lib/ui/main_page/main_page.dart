import 'package:fai/ui/Frequently%20Asked%20Questions/frequently_asked_questions.dart';
import 'package:fai/ui/main_page/Debts/debts.dart';
import 'package:fai/ui/post/addPost.dart';
import 'package:fai/ui/post/posts_review/post_view.dart';

import '../../import.dart';
import '../user_order/my_order_page.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width*.6,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.white,
              image: DecorationImage(
                image: AssetImage("assets/images/fai.png")
              )
            ),
            child: Center(
              child: Text(
                '',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.description),
            title: Text('خطوط السير والتقارير'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacementNamed(
                context,
                HomeScreen.routeName,
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.shopping_cart),
            title: Text('طلب اوردر'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacementNamed(
                context,
                Product.routeName,
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.history), // أيقونة للتعبير عن الزر
            title: Text('الاوردارات السابقه'), // عنوان الزر
            onTap: () {
              // إغلاق الدراور والانتقال للشاشة المناسبة
              Navigator.pop(context);
              Navigator.pushReplacementNamed(
                context,
                UserSalesScreen.routeName,
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.money), // أيقونة للتعبير عن الزر
            title: Text('المديونيات'), // عنوان الزر
            onTap: () {
              // إغلاق الدراور والانتقال للشاشة المناسبة
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DebtManagementPage(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.create),
            title: Text('كتابه منشور'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddPost(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.science_rounded),
            title: Text('التجارب'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PostView(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.help),
            title: Text('اسئله شائعه'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FrequentlyAskedQuestions(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.logout,color: Colors.red,),
            title: Text('تسجيل خروج',style: TextStyle(color: Colors.red),),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
