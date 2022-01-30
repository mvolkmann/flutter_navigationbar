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
    return MaterialApp(
      title: 'Flutter NavigationBar',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Home(),
      routes: {
        '/commute': (_) => CommutePage(),
        '/explore': (_) => ExplorePage(),
        '/saved': (_) => SavedPage(),
      },
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
    return Scaffold(
      body: Center(
        child: options[_pageIndex].widget,
      ),
      // Uncomment one of the next two lines.
      bottomNavigationBar: getBottomNavigationBar(),
      //bottomNavigationBar: getNavigationBar(),
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
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(child: child),
    );
  }
}

class CommutePage extends StatelessWidget {
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
  const ExplorePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyPage(
      title: 'Explore',
      child: Column(
        children: [
          Text('This is the Explore page.'),
          ElevatedButton(
            child: Text('Go To Saved'),
            onPressed: () {
              Navigator.pushNamed(context, '/saved');
            },
          )
        ],
      ),
    );
  }
}

class SavedPage extends StatelessWidget {
  const SavedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyPage(
      title: 'Saved',
      child: Text('This is the Saved page.'),
    );
  }
}
