import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:gradient_bottom_navigation_bar/gradient_bottom_navigation_bar.dart';
import 'package:nested_navigators/nested_nav_item.dart';
import 'package:nested_navigators/nested_navigators.dart';
import 'package:nested_navigators_example/nested_nav_item_key.dart';
import 'package:nested_navigators_example/routes.dart';

class RootPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RootPageState();
}

Widget createNavyBar(
    {List<BottomNavigationBarItem> items,
    int currentIndex,
    Function(int index) onTap}) {
  return BottomNavyBar(
    selectedIndex: currentIndex,
    showElevation: true, // use this to remove appBar's elevation
    onItemSelected: onTap,
    items: [
      BottomNavyBarItem(
        icon: items[0].icon,
        title: items[0].title,
        activeColor: Colors.red,
      ),
      BottomNavyBarItem(
        icon: items[1].icon,
        title: items[1].title,
        activeColor: Colors.red,
      ),
      BottomNavyBarItem(
        icon: items[2].icon,
        title: items[2].title,
        activeColor: Colors.red,
      ),
    ],
  );
}

StatefulWidget createBottomGradientBar(
    {List<BottomNavigationBarItem> items,
    int currentIndex,
    Function(int index) onTap}) {
  return GradientBottomNavigationBar(
    backgroundColorStart: Colors.purple,
    backgroundColorEnd: Colors.deepOrange,
    items: items,
    currentIndex: currentIndex,
    onTap: onTap,
  );
}

class _RootPageState extends State<RootPage> {
  @override
  Widget build(BuildContext context) {
    return NestedNavigators(
      items: {
        NestedNavItemKey.blue: NestedNavigatorItem(
          initialRoute: Routes.blue,
          icon: Icons.access_time,
          text: "Blue",
        ),
        NestedNavItemKey.red: NestedNavigatorItem(
          initialRoute: Routes.red,
          icon: Icons.send,
          text: "Red",
        ),
        NestedNavItemKey.green: NestedNavigatorItem(
          initialRoute: Routes.green,
          icon: Icons.perm_identity,
          text: "Green",
        ),
      },
      generateRoute: Routes.generateRoute,


      drawer: (items, selectedItemKey, selectNavigator) => Drawer(
        child: ListView(
          children: _buildDrawersItems(items, selectedItemKey, selectNavigator),
        ),
      ),
      
      
      endDrawer: (items, selectedItemKey, selectNavigator) => Drawer(
        child: ListView(
          children: _buildDrawersItems(items, selectedItemKey, selectNavigator),
        ),
      ),
      injectedBottomNavigationBar: createNavyBar,
      buildBottomNavigationItem: (key, item, selected) =>
          BottomNavigationBarItem(
        icon: Icon(
          item.icon,
          color: Colors.purple,
        ),
        title: Text(
          item.text,
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }

  List<ListTile> _buildDrawersItems(
    Map<NestedNavItemKey, NestedNavigatorItem> items,
    NestedNavItemKey selectedItemKey,
    Function(NestedNavItemKey) selectNavigator,
  ) {
    return items.entries
        .map((entry) => ListTile(
              title: Text(
                entry.value.text,
                style: TextStyle(
                  color: entry.key == selectedItemKey ? Colors.purple : null,
                ),
              ),
              trailing: Icon(
                entry.value.icon,
                color: entry.key == selectedItemKey ? Colors.blue : null,
              ),
              onTap: () => selectNavigator(entry.key),
            ))
        .toList();
  }
}
