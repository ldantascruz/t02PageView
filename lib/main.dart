import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(
        title: 'Flutter Demo Home Page',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
    required this.title,
    this.initialPage = 0,
  });

  final String title;
  final int initialPage;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentPage = 0;
  late final PageController pageController;

  @override
  void initState() {
    pageController = PageController(initialPage: widget.initialPage);
    currentPage = widget.initialPage;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: PageView(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          // HomeBody(),
          RefreshIndicator(
            child: ListView(children: const [
              CustomBody(
                title: 'Home',
                icon: Icons.home,
              ),
            ]),
            onRefresh: () async {
              await Future.delayed(const Duration(seconds: 2));
            },
          ),

          // NotificationPage(),
          const CustomBody(
            title: 'Notificações',
            icon: Icons.notifications,
          ),
          // ConfigurationPage(),
          const CustomBody(
            title: 'Configurações',
            icon: Icons.settings,
          ),
          // ProfilePage(),
          const CustomBody(
            title: 'Profile',
            icon: Icons.person,
          ),
        ],
      ),
      bottomNavigationBar: StatefulBuilder(
        builder: (context, setState) {
          return BottomNavigationBar(
            onTap: (value) {
              currentPage = value;
              setState(() {});
              pageController.animateToPage(
                value,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeIn,
              );
            },
            currentIndex: currentPage,
            backgroundColor: Colors.grey.shade200,
            unselectedItemColor: Colors.grey.shade700,
            selectedItemColor: Colors.blue,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.notifications),
                label: 'Notificações',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Configurações',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Perfil',
              ),
            ],
          );
        },
      ),
    );
  }
}

class CustomBody extends StatelessWidget {
  const CustomBody({
    Key? key,
    required this.title,
    required this.icon,
  }) : super(key: key);

  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            icon,
            size: 72.0,
          ),
          Text(
            title,
            style: Theme.of(context).textTheme.headline6,
          ),
        ],
      ),
    );
  }
}
