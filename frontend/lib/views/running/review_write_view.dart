import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../widgets/button/register_button.dart';
import '../../widgets/map/result_map.dart';
import '../../widgets/review_record_item.dart';
import '../../widgets/review_info_item.dart'; // LocationInfo 위젯 import

class ReviewWriteView extends StatefulWidget {
  const ReviewWriteView({super.key});

  @override
  ReviewWriteViewState createState() => ReviewWriteViewState();
}

class ReviewWriteViewState extends State<ReviewWriteView> {
  // 제목, 주소, 시간, 내용 등을 하나의 Map으로 관리
  final Map<String, dynamic> details = {
    'title': "유성천 옆 산책로",
    'address': "대전광역시 문화원로 80",
    'time': DateTime(2024, 9, 6, 9, 24, 27), // DateTime 객체
    'image': '',
    'content': "",
  };

  final List<num> records = const [10, 4016, 67, 480];

  File? _selectedImage;
  final TextEditingController _contentController = TextEditingController();

  // 이미지 선택 함수
  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _contentController.text = details['content'];
  }

  @override
  void dispose() {
    _contentController.dispose();
    super.dispose();
  }

  void onRegisterTapped(int index) {
    // 여기에 등록 로직을 구현하세요.
    print("Register button tapped");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        centerTitle: true,
        title: Text(
          '기록 작성',
          style: TextStyle(fontSize: 20, color: Colors.black),
        ),
        backgroundColor: Colors.white,
        toolbarHeight: 56,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 16), // 오른쪽 패딩 추가
            child: RegisterButton(onItemTapped: onRegisterTapped),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // LocationInfo 위젯 사용하여 데이터 표시
                        LocationInfo(
                          title: details['title'],
                          address: details['address'],
                          time: details['time'],
                        ),
                        SizedBox(height: 20),
                        // 선택된 이미지 또는 기본 이미지 표시
                        GestureDetector(
                          onTap: _pickImage,
                          child: _selectedImage != null
                              ? Image.file(
                                  _selectedImage!,
                                  fit: BoxFit.cover,
                                  height: 200,
                                  width: double.infinity,
                                )
                              : Image.asset(
                                  'assets/images/review_default_image.png',
                                  fit: BoxFit.cover,
                                  height: 200,
                                  width: double.infinity,
                                ),
                        ),
                        SizedBox(height: 28),
                        // 러닝 리뷰
                        Text(
                          '러닝 리뷰',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 16),
                        // 리뷰 작성 가능한 텍스트 필드
                        TextField(
                          controller: _contentController,
                          maxLines: null,
                          decoration: InputDecoration(
                            hintText: '리뷰를 작성해주세요...',
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (value) {
                            setState(() {
                              details['content'] = value;
                            });
                          },
                        ),
                        SizedBox(height: 50),
                        // 기록 상세
                        Text(
                          '기록 상세',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 40),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ReviewRecordItem(value: records[0], label: '운동 거리'),
                            ReviewRecordItem(value: records[1], label: '운동 시간'),
                            ReviewRecordItem(
                                value: records[2], label: '러닝 경사도'),
                            ReviewRecordItem(
                                value: records[3], label: '소모 칼로리'),
                          ],
                        ),
                        SizedBox(height: 44),
                      ],
                    ),
                  ),
                  // 지도 터치 막아둠
                  AbsorbPointer(
                    absorbing: true,
                    child: SizedBox(
                      height: 300,
                      child: const ResultMap(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
