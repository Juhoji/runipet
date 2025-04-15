import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'edit_profile_page.dart';
=======
import 'dart:ui';
>>>>>>> 348b71bd2384451461fb455467f1fa5166ee8a19

void main() {
  runApp(const LoonyPetApp());
}

class LoonyPetApp extends StatelessWidget {
  const LoonyPetApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
<<<<<<< HEAD
      debugShowCheckedModeBanner: false,
      home: MainPage(),
=======
      title: '루니펫',
      theme: ThemeData(useMaterial3: true),
      home: const HomeScreen(),
>>>>>>> 348b71bd2384451461fb455467f1fa5166ee8a19
    );
  }
}

<<<<<<< HEAD
class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    // ✅ 매번 build 시점에 날짜 확인 → 계절 배경 변경
    final String seasonBackground = (() {
      final month = DateTime.now().month;
      if (month >= 3 && month <= 5) return 'assets/spring.png';   // 봄
      if (month >= 6 && month <= 8) return 'assets/summer.png';   // 여름
      if (month >= 9 && month <= 11) return 'assets/autumn.png';  // 가을
      return 'assets/winter.png';                                 // 겨울
    })();
=======
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
>>>>>>> 348b71bd2384451461fb455467f1fa5166ee8a19

    return Scaffold(
      body: Stack(
        children: [
<<<<<<< HEAD
          // 🌸 계절 배경 이미지
          Positioned.fill(
            child: Image.asset(seasonBackground, fit: BoxFit.cover),
          ),

          // 👤 왼쪽 상단: 프로필 이미지 (클릭 시 이동)
          Positioned(
            top: 40,
            left: 20,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const EditProfilePage()),
                );
              },
              child: const CircleAvatar(
                radius: 24,
                backgroundImage: AssetImage('assets/profile.png'),
              ),
            ),
          ),

          // 📊 오른쪽 상단: 상태 정보 박스
          Positioned(
            top: 40,
            right: 20,
            child: Container(
              width: 120,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.8),
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text("누룽이", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  Text("Lv.5"),
                  Text("Exp: 40%"),
                  Text("상태: 배고픔"),
                  Text("체력: 50%"),
                ],
              ),
            ),
          ),

          // 🐶 중앙: 말풍선 + 강아지
          Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  margin: const EdgeInsets.only(bottom: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.black),
                  ),
                  child: const Text("배고파요", style: TextStyle(fontSize: 14)),
                ),
                Image.asset('assets/dog.png', height: 120),
              ],
            ),
          ),

          // 🍖 버튼: 먹이 주기 / 약 주기
          Positioned(
            bottom: 100,
            left: 40,
            right: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _ActionButton(text: "먹이 주기", color: Colors.orange),
                _ActionButton(text: "약 주기", color: Colors.brown),
              ],
            ),
          ),
        ],
      ),

      // ⛳ 하단 네비게이션 바
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.directions_run), label: "운동"),
          BottomNavigationBarItem(icon: Icon(Icons.store), label: "상점"),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: "소셜"),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: "설정"),
=======
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
>>>>>>> 348b71bd2384451461fb455467f1fa5166ee8a19
        ],
      ),
    );
  }
}

<<<<<<< HEAD
// 🧩 커스텀 버튼 위젯
class _ActionButton extends StatelessWidget {
  final String text;
  final Color color;

  const _ActionButton({required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // TODO: 먹이 주기, 약 주기 로직 연결
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      child: Text(text, style: const TextStyle(color: Colors.white)),
=======
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
>>>>>>> 348b71bd2384451461fb455467f1fa5166ee8a19
    );
  }
}

<<<<<<< HEAD
=======
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
>>>>>>> 348b71bd2384451461fb455467f1fa5166ee8a19
