import 'package:fai/database/fcm_helper.dart';
import 'package:fai/ui/HomeScreen/add_task/add_client_page.dart';
import 'package:fai/ui/main_page/Debts/AllDebt/show_debts_page.dart';
import 'package:fai/ui/main_page/Debts/debts.dart';
import 'package:fai/ui/main_page/main_page.dart';
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
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // textTheme: const TextTheme(
        //   headline4: TextStyle(
        //       fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
        // ),
        appBarTheme: const AppBarTheme(
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true),
        // scaffoldBackgroundColor: const Color(0xFFDFECDB),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            backgroundColor: Colors.transparent, elevation: 0),
      ),
      initialRoute: Splash.routeName,
      routes: {
        RegisterScreen.routeName: (context) => RegisterScreen(),
        LoginScreen.routeName: (context) => LoginScreen(),
        HomeScreen.routeName: (context) => HomeScreen(),
        Splash.routeName: (context) => Splash(),
        AdminScreen.routeName: (context) => AdminScreen(),
        MapTRACK.routeName: (context) => MapTRACK(),
        Product.routeName: (context) => Product(),
        SalesScreen.routeName: (context) => SalesScreen(),
        UserSalesScreen.routeName: (context) => UserSalesScreen(),
        AddNewTask.routeName: (context) => AddNewTask(),
        MainPage.routeName: (context) =>  MainPage(),
        ShowAllDebtPage.routeName: (context) => ShowAllDebtPage(),
      },
    );
  }
}
