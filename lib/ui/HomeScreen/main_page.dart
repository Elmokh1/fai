import 'package:fai/ui/Frequently%20Asked%20Questions/frequently_asked_questions.dart';
import 'package:fai/ui/approved_client/approve_client.dart';
import 'package:fai/ui/post/addPost.dart';
import 'package:fai/ui/post/posts_review/post_view.dart';
import 'package:fai/ui/sections/sections.dart';

import '../../import.dart';
import '../Debts/debts.dart';
import '../user_order/my_order_page.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width * .6,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
                color: Colors.white,
                image: DecorationImage(
                    image: AssetImage("assets/images/fai.png"))),
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
            leading: Icon(Icons.add_shopping_cart),
            title: Text('طلب اوردر '),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Sections(
                    showOrderNow: true,

                  ),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.shopping_cart),
            title: Text('السله'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CartPage(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.history),
            title: Text('الاوردارات السابقه'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacementNamed(
                context,
                UserSalesScreen.routeName,
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.money),
            title: Text('المديونيات'),
            onTap: () {
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
            leading: Icon(Icons.pending_actions),
            title: Text('الموافقه علي العملاء'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ApproveClient(),
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
            leading: Icon(
              Icons.logout,
              color: Colors.red,
            ),
            title: Text(
              'تسجيل خروج',
              style: TextStyle(color: Colors.red),
            ),
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
          ),
        ],
      ),
    );
  }
}
