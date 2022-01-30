import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class NavOption {
  final IconData icon;
  final String label;
  final Widget widget;

  const NavOption({
    required this.icon,
    required this.label,
    required this.widget,
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      home: HomePage(),
      theme: CupertinoThemeData(brightness: Brightness.light),
      title: 'Flutter NavigationBar',
    );
  }
}

class HomePage extends StatelessWidget {
  static const route = '/';

  static const options = <NavOption>[
    NavOption(icon: Icons.explore, label: 'Explore', widget: ExplorePage()),
    NavOption(icon: Icons.commute, label: 'Commute', widget: CommutePage()),
    NavOption(icon: Icons.bookmark_border, label: 'Saved', widget: SavedPage()),
  ];

  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var items = options
        .map(
          (option) => BottomNavigationBarItem(
            icon: Icon(option.icon),
            label: option.label,
          ),
        )
        .toList();

    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(items: items),
      tabBuilder: (context, index) => CupertinoTabView(
        builder: (context) => options[index].widget,
        // Unlike in Material, with Cupertino the routes
        // are define here instead of on the "App" widget.
        routes: {
          CommutePage.route: (_) => CommutePage(),
          ExplorePage.route: (_) => ExplorePage(),
          HomePage.route: (_) => HomePage(),
          SavedPage.route: (_) => SavedPage(),
        },
      ),
    );
  }
}

class MyPage extends StatelessWidget {
  final Widget child;
  final String title;

  const MyPage({
    Key? key,
    required this.title,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        backgroundColor: CupertinoColors.systemBlue,
        middle: Text(title),
      ),
      child: Center(child: child),
    );
  }
}

class CommutePage extends StatelessWidget {
  static const route = '/commute';

  const CommutePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyPage(
      title: 'Commute',
      child: Text('This is the Commute page.'),
    );
  }
}

class ExplorePage extends StatelessWidget {
  static const route = '/explore';

  const ExplorePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyPage(
      title: 'Explore',
      child: Column(
        mainAxisSize: MainAxisSize.min, // allows centering
        children: [
          Text('This is the Explore page.'),
          ElevatedButton(
            child: Text('Go To Saved'),
            onPressed: () {
              Navigator.pushNamed(context, SavedPage.route);
            },
          )
        ],
      ),
    );
  }
}

class SavedPage extends StatelessWidget {
  static const route = '/saved';

  const SavedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyPage(
      title: 'Saved',
      child: Text('This is the Saved page.'),
    );
  }
}
