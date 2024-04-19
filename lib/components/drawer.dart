import 'package:flutter/material.dart';
import 'package:notes_offline/components/drawer_tile.dart';
import 'package:notes_offline/pages/settings_page.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              // drawer logo
              DrawerHeader(
                child: Center(
                  child: Icon(
                    Icons.menu_book_rounded,
                    color: Theme.of(context).colorScheme.inversePrimary,
                    size: 72,
                  ),
                ),
              ),

              const SizedBox(
                height: 25,
              ),

              DrawerTile(
                  icon: Icons.home,
                  title: 'Notes',
                  onTap: () => Navigator.pop(context)),

              DrawerTile(
                  icon: Icons.settings,
                  title: 'Settings',
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SettingsPage(),
                      ),
                    );
                  })
            ],
          ),
        ],
      ),
    );
  }
}
