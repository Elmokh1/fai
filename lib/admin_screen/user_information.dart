
import 'package:fai/database/model/customer_model.dart';
import 'package:fai/import.dart';
import 'package:fai/database/model/eng_model.dart' as MyUser;



class UserInformation extends StatefulWidget {

  CustomerModel user;
  UserInformation(this.user);

  @override
  State<UserInformation> createState() => _UserInformationState();
}

class _UserInformationState extends State<UserInformation> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    var tabs = [
      NotDone(widget.user),
      ReportDone(widget.user),
    ];
    return Scaffold(
      appBar: AppBar(
        actions: [
          InkWell(
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SalesScreen(
                    user: widget.user,
                  ),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: Icon(
                Icons.add_business_sharp,
                size: 30,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
      body: tabs[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.list,
                size: 32,
              ),
              label: ''),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.check_circle,
                size: 32,
              ),
              label: ''),
        ],
      ),
    );
  }


}
