import 'package:flutter/material.dart';
import 'package:meals_app/Screens/filters_screen.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            height: 120,
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            alignment: Alignment.centerLeft,
            color: Theme.of(context).accentColor,
            child: Text(
              "Cooking Up",
              style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 30,
                  color: Theme.of(context).primaryColor),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          buildListTile(Icons.restaurant, "Meals", () {
            Navigator.of(context).pushReplacementNamed('/');
          }),
          buildListTile(Icons.settings, "Filters", () {
            Navigator.of(context).pushReplacementNamed(FiltersScreen.rountName);
          })
        ],
      ),
    );
  }

  ListTile buildListTile(IconData icon, String title, VoidCallback tabHandler) {
    return ListTile(
      leading: Icon(
        icon,
        size: 26,
      ),
      title: Text(
        title,
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: "RobotoCondensed",
            fontSize: 24),
      ),
      onTap: tabHandler,
    );
  }
}
