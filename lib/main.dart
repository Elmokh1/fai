import 'package:fai/admin_screen/Upper_Egypt/upper_egypt.dart';
import 'package:fai/ui/Debts/AllDebt/show_debts_page.dart';
import 'package:fai/ui/HomeScreen/add_task/add_client_page.dart';
import 'package:fai/ui/client_interface/client_interface.dart';
import 'package:fai/ui/client_interface/customer_service/customer_service.dart';
import 'package:fai/ui/post/posts_review/post_view.dart';
import 'package:fai/ui/post/posts_review/post_widget.dart';
import 'package:fai/ui/register/client_register_screen.dart';
import 'package:fai/ui/register/register.dart';
import 'package:fai/ui/sections/edit/edit_prodduct.dart';
import 'package:fai/ui/user_interface/welcome_page.dart';
import 'package:fai/ui/user_order/my_order_page.dart';

import 'import.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // FcmHelper fcmHelper = FcmHelper();
  // await fcmHelper.initFcmMessage();
  runApp(
    ChangeNotifierProvider(
      create: (buildcontext) => appProvider(),
      child: BlocProvider(
        create: (context) => MyCubit(),
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var auth = FirebaseAuth.instance;
  User? user;

  @override
  void initState() {
    super.initState();
    user = auth.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // home: EditSections(showOrderNow: true),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true),
        scaffoldBackgroundColor: Colors.white,
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            backgroundColor: Colors.transparent, elevation: 0),
      ),
      initialRoute: AdminScreen.routeName,
      // home: PostView(),
      routes: {
        RegisterPage.routeName: (context) => RegisterPage(),
        LoginScreen.routeName: (context) => LoginScreen(),
        UpperEgyptScreen.routeName: (context) => UpperEgyptScreen(),
        HomeScreen.routeName: (context) => HomeScreen(),
        Splash.routeName: (context) => Splash(),
        AdminScreen.routeName: (context) => AdminScreen(),
        MapTRACK.routeName: (context) => MapTRACK(),
        // Product.routeName: (context) => Product(),
        SalesScreen.routeName: (context) => SalesScreen(),
        UserSalesScreen.routeName: (context) => UserSalesScreen(),
        AddNewTask.routeName: (context) => AddNewTask(),
        // MainPage.routeName: (context) =>  MainPage(),
        ShowAllDebtPage.routeName: (context) => ShowAllDebtPage(),
        ClientRegisterScreen.routeName: (context) => ClientRegisterScreen(),
        EngRegisterScreen.routeName: (context) => EngRegisterScreen(),
        WelcomePage.routeName: (context) => WelcomePage(),
        ClientInterFace.routeName: (context) => ClientInterFace(),
      },
    );
  }
}
