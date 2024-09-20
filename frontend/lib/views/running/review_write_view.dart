import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
// 임의의 지도 위젯 가져오기 (result_map.dart에서)
import '../../widgets/map/result_map.dart';

class ReviewWriteView extends StatefulWidget {
  const ReviewWriteView({super.key});

  @override
  ReviewWriteViewState createState() => ReviewWriteViewState();
}

class ReviewWriteViewState extends State<ReviewWriteView> {
  final String title = "유성천 옆 산책로";
  final String address = "대전광역시 문화원로 80";
  final String time = "2024-09-06 09:24:27";
  String content =
      "오늘 날씨 너무 선선해!\n선선한 날씨에 뛰니까 10km도 뛸 수 있었당\n다음주에는 10km 1시간 내로 도전 !!!";

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
    _contentController.text = content;
  }

  @override
  void dispose() {
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          '기록 작성',
          style: TextStyle(fontSize: 20, color: Colors.black),
        ),
        backgroundColor: Colors.white,
        toolbarHeight: 56,
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
                        // 제목과 시간, 주소
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title,
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(height: 6),
                            Row(
                              children: [
                                Image.asset(
                                  'assets/icons/location.png',
                                  width: 20,
                                  height: 20,
                                ),
                                SizedBox(width: 5),
                                Expanded(
                                  child: Text(
                                    address,
                                    style: TextStyle(
                                        fontSize: 16, color: Color(0xffA0A0A0)),
                                  ),
                                ),
                                Text(
                                  time,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Color(0xffA0A0A0),
                                  ),
                                ),
                              ],
                            ),
                          ],
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
                              content = value;
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
                            _buildDetailItem('10km', '운동 거리'),
                            _buildDetailItem('01:06:56', '운동 시간'),
                            _buildDetailItem('67%', '러닝 경사도'),
                            _buildDetailItem('480kcal', '소모 칼로리'),
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

  Widget _buildDetailItem(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w400,
            color: Color(0xff1EA6FC),
          ),
        ),
        SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            color: Color(0xffA0A0A0),
          ),
        ),
      ],
    );
  }
}
