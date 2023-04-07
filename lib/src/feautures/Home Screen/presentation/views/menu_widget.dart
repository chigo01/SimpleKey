import 'package:flutter/material.dart';

class MenuPage extends StatelessWidget {
  const MenuPage(
      {Key? key, required this.currentItem, required this.onSelectedItem})
      : super(key: key);
  final MenuItem currentItem;
  final ValueChanged<MenuItem> onSelectedItem;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Spacer(),
          ...menuItems
              .map(
                (item) => ListTileTheme(
                  selectedColor: Colors.white,
                  child: ListTile(
                    selectedTileColor: Colors.grey.withOpacity(0.2),
                    minLeadingWidth: 20,
                    selected: item == currentItem,
                    leading: Icon(item.icon, color: Colors.white),
                    title: Text(
                      item.title,
                      style: const TextStyle(fontSize: 9, color: Colors.white),
                    ),
                    onTap: () {
                      // item.onTap();
                      onSelectedItem(item);
                    },
                  ),
                ),
              )
              .toList(),
          const Spacer(flex: 2),
        ],
      ),
    );
  }
}

class MenuItem {
  final String title;
  final IconData icon;
  // final Function() onTap;

  MenuItem(
    this.title,
    this.icon,
  );
}

List<MenuItem> menuItems = [
  MenuItem('Home', Icons.home),
  MenuItem('Post Property', Icons.home_work_sharp),
  MenuItem('Messages', Icons.chat),
  MenuItem('Profile', Icons.person),
  MenuItem("Notifications", Icons.notifications),
  MenuItem('Logout', Icons.logout),
];
