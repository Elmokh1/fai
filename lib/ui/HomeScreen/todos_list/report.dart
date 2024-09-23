import 'package:fai/import.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReportModal extends StatefulWidget {
  Task task;

  ReportModal({
    required this.task,
  });

  @override
  State<ReportModal> createState() => _ReportModalState();
}

class _ReportModalState extends State<ReportModal> {
  var locationManger = Location();
  var formKey = GlobalKey<FormState>();
  TextEditingController ReportController = TextEditingController();
  TextEditingController IncomeController = TextEditingController(text: "0");
  var auth = FirebaseAuth.instance;
  User? user;

  @override
  void initState() {
    super.initState();
    user = auth.currentUser;
    askUserForPermissionAndService();
  }

  askUserForPermissionAndService() async {
    await requestPermission();
    await requestService();
    getUserLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Report',
                  style: Theme.of(context).textTheme.headline4,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            CustomTextFormField(
              Label: "التحصيل",
              controller: IncomeController,
              validator: (text) {
                if (text == null || text.trim().isEmpty) {
                  return 'please enter Report';
                }
                return null;
              },
            ),
            CustomTextFormField(
              lines: 1,
              maxlines: 20,
              Label: "Report",
              controller: ReportController,
              validator: (text) {
                if (text == null || text.trim().isEmpty) {
                  return 'please enter Report';
                }
                return null;
              },
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: InkWell(
                onTap: () {
                  if (formKey.currentState?.validate() == false) {
                    return;
                  }
                  addReport();
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 40, top: 5),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    width: 300,
                    height: 100,
                    child: Center(
                      child: Text(
                        "Add",
                        style: GoogleFonts.poppins(fontSize: 40),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 50,
            ),
          ],
        ),
      ),
    );
  }

  var selectedDate = DateTime.now();
  double? latitude;
  double? longitude;

  void drawUserMarker() async {
    var canGetLocation = await canUseGps();
    if (!canGetLocation) return;
    var locationData = await locationManger.getLocation();
  }

  Future<LocationData?> getUserLocation() async {
    var canGetLocation = await canUseGps();

    if (!canGetLocation) {
      return null;
    }
    var locationData = await locationManger.getLocation();
    setState(() {
      latitude = locationData.latitude;
      longitude = locationData.longitude;
    });
    print(locationData.latitude);
    print(locationData.longitude);
    return null;
  }

  Future<bool> isLocationServiceEnabled() async {
    return await locationManger.serviceEnabled();
  }

  Future<bool> requestService() async {
    var enabled = await locationManger.requestService();
    return enabled;
  }

  Future<bool> isPermissionGranted() async {
    var permissionStatus = await locationManger.hasPermission();
    return permissionStatus == PermissionStatus.granted;
  }

  Future<bool> requestPermission() async {
    var permissionStatus = await locationManger.requestPermission();
    return permissionStatus == PermissionStatus.granted;
  }

  Future<bool> canUseGps() async {
    var permissionGranted = await isPermissionGranted();
    if (!permissionGranted) {
      return false;
    }
    var isServiceEnabled = await isLocationServiceEnabled();
    if (!isServiceEnabled) {
      return false;
    }
    return true;
  }

  void addReport() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var reportsList = prefs.getStringList('reports') ?? [];
    reportsList.add('${ReportController.text}, ${DateTime.now()}');
    await prefs.setStringList('reports', reportsList);

    var incomesList = prefs.getStringList('incomes') ?? [];
    incomesList.add('${IncomeController.text}, ${DateTime.now()}');
    await prefs.setStringList('incomes', incomesList);

    double Dincome = double.parse(IncomeController.text);

    Report report = Report(
      long: longitude ?? 0.0,
      lat: latitude ?? 0.0,
      report: ReportController.text,
      dateTime: selectedDate,
      income: Dincome,
    );

    appProvider reportProvider =
        Provider.of<appProvider>(context, listen: false);
    var taskId = await reportProvider.currentTask?.id;
    var userId = await reportProvider.currentUser?.id;
    print(taskId);
    await MyDataBase.addReport(
      user?.uid ?? "",
      widget.task.id ?? "",
      report,

    );
    Income income = Income(
      DailyInCome: Dincome,
      clientName: widget.task.title,
      dateTime: selectedDate,
    );
    await MyDataBase.addIncome(
      user?.uid ?? "",
      income,
    );
    await MyDataBase.editTaskIncome(
        user?.uid ?? "", widget.task.id ?? "", Dincome);
    DialogUtils.hideDialog(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("تم اضافه التقرير بنجاح ")),
    );    var authProvider = Provider.of<appProvider>(context, listen: false);
    authProvider.updateReport(report);
  }
}
