import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class EditProfilePage extends StatefulWidget {
  final Function(String)? onGenderChanged; // 콜백 전달 가능하도록

  const EditProfilePage({super.key, this.onGenderChanged});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  File? _profileImage;
  String _selectedGender = 'male'; // 기본값 남성

  final TextEditingController _nicknameController = TextEditingController(text: '러너');
  final TextEditingController _petNameController = TextEditingController(text: '누룽이');
  final TextEditingController _todayStepsController = TextEditingController();
  final TextEditingController _goalStepsController = TextEditingController();

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  void _updateGender(String value) {
    setState(() {
      _selectedGender = value;
    });
    if (widget.onGenderChanged != null) {
      widget.onGenderChanged!(value); // 부모에게 알려주기
    }
  }

  @override
  Widget build(BuildContext context) {
    final genderAssetPath = 'assets/profile_${_selectedGender}.png';

    return Scaffold(
      appBar: AppBar(title: const Text("프로필")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              // 👤 프로필 이미지
              CircleAvatar(
                radius: 50,
                backgroundImage: _profileImage != null
                    ? FileImage(_profileImage!)
                    : AssetImage(genderAssetPath) as ImageProvider,
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: _pickImage,
                child: const Text("프로필 이미지 변경"),
              ),

              // 🧑 성별 선택
              const SizedBox(height: 20),
              const Align(alignment: Alignment.centerLeft, child: Text("성별")),
              ListTile(
                title: const Text("남성"),
                leading: Radio<String>(
                  value: 'male',
                  groupValue: _selectedGender,
                  onChanged: _updateGender,
                ),
              ),
              ListTile(
                title: const Text("여성"),
                leading: Radio<String>(
                  value: 'female',
                  groupValue: _selectedGender,
                  onChanged: _updateGender,
                ),
              ),

              // 🧑 닉네임 입력
              const SizedBox(height: 20),
              const Align(alignment: Alignment.centerLeft, child: Text("닉네임")),
              TextField(
                controller: _nicknameController,
                decoration: const InputDecoration(border: OutlineInputBorder()),
              ),

              // 🐾 펫 이름 입력
              const SizedBox(height: 20),
              const Align(alignment: Alignment.centerLeft, child: Text("동물 이름")),
              TextField(
                controller: _petNameController,
                onChanged: (_) => setState(() {}),
                decoration: const InputDecoration(border: OutlineInputBorder()),
              ),

              // 📊 걸음 수 관련
              const SizedBox(height: 30),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.orange.shade100,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.black),
                ),
                child: Row(
                  children: [
                    Image.asset('assets/dog.png', height: 50),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("루니펫: ${_petNameController.text} Lv.5"),
                          TextField(
                            controller: _todayStepsController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(labelText: "오늘 걸음 수"),
                          ),
                          TextField(
                            controller: _goalStepsController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(labelText: "목표 걸음 수"),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),

              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("프로필이 저장되었습니다")),
                  );
                },
                child: const Text("저장"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
