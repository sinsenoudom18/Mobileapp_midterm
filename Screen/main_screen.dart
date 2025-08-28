import 'package:flutter/material.dart';
import 'package:pos/Screen/home_screen.dart';
import 'package:pos/Screen/menu_screen.dart';
import 'package:pos/Screen/profile_screen.dart';
import 'package:pos/Screen/login_screen.dart';
import 'package:pos/Helper/style.dart'; // ✅ make sure this exists

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    HomeScreen(),
    ProfileScreen(),
    MenuScreen(),
  ];

  final List<String> _titles = const [
    "Welcome to Home",
    "Welcome to Profile",
    "Welcome to Menu",
  ];

  void setIndex(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _profile() {
  // Navigate to Profile Screen
  Navigator.push(
    context,
    MaterialPageRoute(builder: (_) => const ProfileScreen()),
  );
}

void _menu() {
  // Navigate to Menu Screen
  Navigator.push(
    context,
    MaterialPageRoute(builder: (_) => const MenuScreen()),
  );
}

void _logout() {
  // Navigate back to Login Screen
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (_) => const LoginScreen()),
  );
}

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text(_titles[_currentIndex]),
      centerTitle: true,
      backgroundColor: Stylecolor.primary, // use Stylecolor
      elevation: 4,
    ),

    body: SafeArea(
      child: _pages[_currentIndex],
    ),

    floatingActionButton: FloatingActionButton(
      onPressed: () {
        setIndex(0); // jump to Home page
      },
      backgroundColor: Stylecolor.primary,
      child: const Icon(Icons.home),
    ),

    bottomNavigationBar: BottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: setIndex,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Stylecolor.primary,
      unselectedItemColor: Colors.grey,
      elevation: 8,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        BottomNavigationBarItem(icon: Icon(Icons.menu), label: "Menu"),
      ],
    ),

    drawer: Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const UserAccountsDrawerHeader(
            accountName: Text("Dom"),
            accountEmail: Text("dom@gmail.com"),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.person, size: 40, color: Colors.orange),
            ),
            decoration: BoxDecoration(color: Color.fromARGB(255, 33, 24, 82)),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text("Home"),
            onTap: () {
              setIndex(0);
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text("Profile"),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ProfileScreen()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.menu),
            title: const Text("Menu"),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const MenuScreen()),
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text("Log Out", style: TextStyle(color: Colors.red)),
            onTap: _logout,
          ),
        ],
      ),
    ),
  );


  }
}
