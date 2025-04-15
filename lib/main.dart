import 'package:flutter/material.dart';
import 'edit_profile_page.dart';

void main() {
  runApp(const LoonyPetApp());
}

class LoonyPetApp extends StatelessWidget {
  const LoonyPetApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainPage(),
    );
  }
}

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

    return Scaffold(
      body: Stack(
        children: [
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
        ],
      ),
    );
  }
}

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
    );
  }
}

