import 'package:chat_app/services/auth/auth_service.dart';
import 'package:chat_app/pages/settings_page.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});
  void signout() {
    AuthService authService = AuthService();
    authService.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              DrawerHeader(
                  child: Center(
                child: Icon(
                  Icons.message,
                  color: Theme.of(context).colorScheme.primary,
                  size: 64,
                ),
              )),
              Padding(
                padding: EdgeInsets.only(left: 25),
                child: ListTile(
                  title: Text("HOME"),
                  leading: Icon(Icons.home),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 25),
                child: ListTile(
                  title: Text("SETTINGS"),
                  leading: Icon(Icons.settings),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SettingsPage()));
                  },
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 25),
            child: ListTile(
              title: Text("LOGOUT"),
              leading: Icon(Icons.logout),
              onTap: () {
                signout();
              },
            ),
          ),
        ],
      ),
    );
  }
}
