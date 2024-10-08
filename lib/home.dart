import 'package:firstapp/settings.dart';
import 'package:firstapp/widget/button.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final String? name;

  const HomePage({super.key, this.name});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      appBar: AppBar(
        title: const Text("NeX\$kill"),
      ),
      drawerScrimColor: Colors.transparent,
      drawerEnableOpenDragGesture: true,
      drawer: Drawer(
        backgroundColor: Colors.red,
        child: Column(
          children: [
            DrawerHeader(
                child: Container(
              height: 80,
              width: 80,
              child: CircleAvatar(
                child: Image.asset("assets/nexskill.png"),
              ),
            )),
            ListTile(
              leading: Icon(Icons.password_rounded, color: Colors.white),
              title: Text(
                "Change Password",
                style: TextStyle(color: Colors.white),
              ),
              trailing:
                  Icon(Icons.arrow_forward_ios_rounded, color: Colors.white),
            ),
            ListTile(
              leading: Icon(Icons.email, color: Colors.white),
              title: Text(
                "Change Email",
                style: TextStyle(color: Colors.white),
              ),
              trailing:
                  Icon(Icons.arrow_forward_ios_rounded, color: Colors.white),
            ),
            ListTile(
              leading: Icon(Icons.logout, color: Colors.white),
              title: Text(
                "LogOut",
                style: TextStyle(color: Colors.white),
              ),
              trailing:
                  Icon(Icons.arrow_forward_ios_rounded, color: Colors.white),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  "Good Morning!",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                ),
                Text(
                  " ${widget.name}",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: Colors.red),
                ),
              ],
            ),
            CustomButton(
              text: 'Please Hit Button',
              onTap: () {
                Navigator.push(context,MaterialPageRoute(builder: (context) => SettingsScreen()));
                print("You Hit Me !");
              },
              color: Colors.red,
              borderRadius: 8.0,
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.red,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: "Settings"),
        ],
      ),
    );
  }
}
