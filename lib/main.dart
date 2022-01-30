import 'package:flutter/material.dart';
import './extensions/widget_extensions.dart';

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
    return MaterialApp(
      title: 'Flutter NavigationBar',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      //home: const HomePage(),
      initialRoute: HomePage.route,
      routes: {
        CommutePage.route: (_) => CommutePage(),
        ExplorePage.route: (_) => ExplorePage(),
        HomePage.route: (_) => HomePage(),
        SavedPage.route: (_) => SavedPage(),
      },
    );
  }
}

class HomePage extends StatefulWidget {
  static const route = '/';

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const options = <NavOption>[
    NavOption(icon: Icons.explore, label: 'Explore', widget: ExplorePage()),
    NavOption(icon: Icons.commute, label: 'Commute', widget: CommutePage()),
    NavOption(icon: Icons.bookmark_border, label: 'Saved', widget: SavedPage()),
  ];

  var _pageIndex = 0;

  // First option.
  BottomNavigationBar getBottomNavigationBar() {
    return BottomNavigationBar(
      items: [
        for (var option in options)
          BottomNavigationBarItem(
            icon: Icon(option.icon),
            label: option.label,
          )
      ],
      onTap: (int index) {
        setState(() => _pageIndex = index);
      },
      currentIndex: _pageIndex,
      selectedItemColor: Colors.green,
    );
  }

  // Second option.
  NavigationBar getNavigationBar() {
    return NavigationBar(
      destinations: [
        for (var option in options)
          NavigationDestination(
            icon: Icon(option.icon),
            label: option.label,
          )
      ],
      onDestinationSelected: (int index) {
        setState(() => _pageIndex = index);
      },
      selectedIndex: _pageIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: options[_pageIndex].widget,
        ),
        // Uncomment one of the next two lines.
        getBottomNavigationBar(), // more attractive
        //getNavigationBar(), // less attractive
      ],
    ).border();
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
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(child: child),
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
