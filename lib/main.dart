import 'package:flutter/material.dart';
import 'dart:ui';

void main() {
  runApp(const LoonyPetApp());
}

class LoonyPetApp extends StatelessWidget {
  const LoonyPetApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '루니펫',
      theme: ThemeData(useMaterial3: true),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  String _getSeasonAsset() {
    final month = DateTime.now().month;

    if (month >= 3 && month <= 5) {
      return 'assets/spring.png'; // 봄
    } else if (month >= 6 && month <= 8) {
      return 'assets/summer.png'; // 여름
    } else if (month >= 9 && month <= 11) {
      return 'assets/autumn.png'; // 가을
    } else {
      return 'assets/winter.png'; // 겨울
    }
  }

  @override
  Widget build(BuildContext context) {
    final backgroundImage = _getSeasonAsset();

    return Scaffold(
      body: Stack(
        children: [
          // 배경 계절 이미지
          Positioned.fill(
            child: Image.asset(
              backgroundImage,
              fit: BoxFit.cover,
            ),
          ),

          // 메인 UI
          SafeArea(
            child: Column(
              children: [
                // 상단: 프로필 이미지
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const ProfilePage()),
                          );
                        },
                        child: const CircleAvatar(
                          radius: 24,
                          backgroundImage: AssetImage('assets/user.png'),
                        ),
                      ),
                      // 오른쪽 공백
                      const SizedBox(width: 40),
                    ],
                  ),
                ),

                const SizedBox(height: 40),

                // 중앙 캐릭터와 빠른 시작
                Column(
                  children: [
                    Image.asset('assets/character.png', height: 100),
                    const SizedBox(height: 10),
                    const Text(
                      "최고 웨이브 20",
                      style: TextStyle(fontSize: 14, color: Colors.black87),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        // 운동 시작 기능
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.yellow[700],
                        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: const Text(
                        "빠른 시작!",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),

                const Spacer(),

                // 하단 탭
                Container(
                  color: Colors.white.withOpacity(0.9),
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      TabItem(icon: Icons.home, label: "홈"),
                      TabItem(icon: Icons.pets, label: "가상동물"),
                      TabItem(icon: Icons.group, label: "친구"),
                      TabItem(icon: Icons.settings, label: "설정"),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TabItem extends StatelessWidget {
  final IconData icon;
  final String label;

  const TabItem({super.key, required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: Colors.grey[800]),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("내 프로필"),
        backgroundColor: Colors.green[300],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/user.png'),
            ),
            SizedBox(height: 20),
            Text(
              "머모오너죠",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text("최고 웨이브: 20", style: TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}