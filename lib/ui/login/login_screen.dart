import 'package:fai/import.dart';
import 'package:fai/ui/register/register.dart';
import 'package:fai/ui/user_interface/welcome_page.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = "Login";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController(text: "ahmedMokhtar");
  var emailController = TextEditingController(text: "");
  var passwordController = TextEditingController(text: "");
  var passwordConfirmationController =
      TextEditingController(text: "ahmedMokhtar");

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFFDFECDB),
        image: DecorationImage(
            image: AssetImage('assets/images/auth_pattern.png'),
            fit: BoxFit.fill),
      ),
      child: Scaffold(
          body: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .3,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 30.0),
                    child: Text(
                      "Welcome back!",
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  CustomTextFormField(
                    controller: emailController,
                    Label: "E mail",
                    // controller: nameController,
                    validator: (text) {
                      if (text == null || text.trim().isEmpty) {
                        return 'Please Enter Email ';
                      }
                      if (!ValidationUtils.isValidEmail(text)) {
                        return 'Please Enter a Valid Email';
                      }
                    },
                  ),
                  CustomTextFormField(
                    isPassword: true,
                    controller: passwordController,
                    Label: "Password",
                    // controller: nameController,
                    validator: (text) {
                      if (text == null || text.trim().isEmpty) {
                        return 'Please Enter The Password ';
                      }
                      if (text.length < 6) {
                        return "Password Must be 6 char";
                      }
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 12),
                      ),
                      onPressed: () {
                        Login();
                      },
                      child: const Text(
                        'Login',
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                            context, RegisterPage.routeName);
                      },
                      child: const Text("Don`t Have Account"))
                ],
              ),
            ),
          ),
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: const Text('Login'),
          )),
    );
  }

  FirebaseAuth authService = FirebaseAuth.instance;

  void Login() async {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("جاري التحميل...")),
    );

    // async - await
    if (formKey.currentState?.validate() == false) {
      return;
    }
    try {
      var result = await authService.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      var user = await MyDataBase.readCustomer(result.user?.uid ?? "");
      if (user == null) {
        DialogUtils.showMessage(context, "Error to ind user in db",
            posActionName: 'ok');
        return;
      }
      // إخفاء SnackBar بعد انتهاء الطلب
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("تم تسجيل الدخول بنجاح")),
      );
      Navigator.pushReplacementNamed(context, WelcomePage.routeName);

      var authProvider = Provider.of<appProvider>(context, listen: false);
      authProvider.updateCustomer(user);
    } on FirebaseAuthException catch (e) {
      String errorMessage = 'wrong email or password';
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("خطأ في البريد الإلكتروني أو كلمة المرور")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("خطأ في الاتصال تحقق من الإنترنت")),
      );
    }
  }
}
