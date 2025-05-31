import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'edit_profile_page.dart';
import 'social_page.dart';
import 'shop_page.dart';
import 'app_state.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => AppState(),
      child: const LoonyPetApp(),
    ),
  );
}

class LoonyPetApp extends StatelessWidget {
  const LoonyPetApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: NavigationRoot(),
    );
  }
}

class NavigationRoot extends StatefulWidget {
  const NavigationRoot({super.key});

  @override
  State<NavigationRoot> createState() => _NavigationRootState();
}

class _NavigationRootState extends State<NavigationRoot> {
  int _currentIndex = 0;
  String _gender = 'male';
  List<Map<String, dynamic>> _friends = [
    {'name': '종천', 'level': 3},
    {'name': '원상', 'level': 4},
  ];

  void _updateGender(String gender) {
    setState(() {
      _gender = gender;
    });
  }

  void _addFriend(Map<String, dynamic> user) {
    setState(() {
      _friends.add(user);
    });
  }

  void _deleteFriend(String name) {
    setState(() {
      _friends.removeWhere((user) => user['name'] == name);
    });
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      MainPage(gender: _gender, onGenderChanged: _updateGender),
      const ShopPage(),
      SocialPage(
        gender: _gender,
        friends: _friends,
        onFriendAccepted: _addFriend,
        onFriendDeleted: _deleteFriend,
      ),
      const Center(child: Text("설정 페이지 준비 중")),
    ];

    return Scaffold(
      body: pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.directions_run), label: "운동"),
          BottomNavigationBarItem(icon: Icon(Icons.store), label: "상점"),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: "소셜"),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: "설정"),
        ],
      ),
    );
  }
}

class MainPage extends StatelessWidget {
  final String gender;
  final Function(String) onGenderChanged;

  const MainPage({super.key, required this.gender, required this.onGenderChanged});

  @override
  Widget build(BuildContext context) {
    final seasonBackground = (() {
      final month = DateTime.now().month;
      if (month >= 3 && month <= 5) return 'assets/spring.png';
      if (month >= 6 && month <= 8) return 'assets/summer.png';
      if (month >= 9 && month <= 11) return 'assets/fall.png';
      return 'assets/winter.png';
    })();

    final profileImagePath = 'assets/profile_$gender.png';

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(seasonBackground, fit: BoxFit.cover),
          ),
          Positioned(
            top: 40,
            left: 20,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => EditProfilePage(onGenderChanged: onGenderChanged),
                  ),
                );
              },
              child: CircleAvatar(
                radius: 24,
                backgroundImage: AssetImage(profileImagePath),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
