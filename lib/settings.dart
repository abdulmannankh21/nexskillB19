import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lime,
      appBar: AppBar(
        title: const Text("NeX\$kill"),
      ),
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
      drawerScrimColor: Colors.transparent,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: GestureDetector(
        onTap: () {
          Navigator.pop(context);
          print("Going Back from setting screen");
        },
        child: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
                child: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ))),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.red,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.logout,color: Colors.grey,), label: " "),
          BottomNavigationBarItem(icon: Icon(Icons.add,color: Colors.grey,), label: "Add"),
          BottomNavigationBarItem(icon: Icon(Icons.menu,color: Colors.grey,), label: " "),
          BottomNavigationBarItem(icon: Icon(Icons.note,color: Colors.grey,), label: " "),
        ],
      ),

      // ElevatedButton(onPressed: (){
      //   print("On Back");
      // }, child: Text("On Back")),
    );
  }
}
