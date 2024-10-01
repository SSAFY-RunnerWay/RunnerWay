import 'dart:developer';

import 'package:frontend/models/personal_image.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../models/running_review_model.dart';
import '../services/running_review_service.dart';

class RunningReviewController extends GetxController {
  final RunningReviewService _service = RunningReviewService();

  final details = {
    'title': "유성천 옆 산책로",
    'address': "대전광역시 문화원로 80",
    'time': DateTime(2024, 9, 6, 9, 24, 27),
    'image': '',
    'content': "",
  }.obs;

  final records = [10.0, 4016, 67.0, 480].obs;

  final Rx<File?> selectedImage = Rx<File?>(null);
  final content = "".obs;
  final courseId = 0.obs;

  void updateContent(String value) {
    content.value = value;
    details['content'] = value;
  }

  Future<void> pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      selectedImage.value = File(pickedFile.path);
      details['image'] = pickedFile.path;
    }
  }

  String calculateTime(int totalSeconds) {
    int hours = totalSeconds ~/ 3600;
    int minutes = (totalSeconds % 3600) ~/ 60;
    int seconds = totalSeconds % 60;
    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  Future<void> onRegisterTapped() async {
    try {
      double distance = records[0].toDouble(); // 거리 (미터)
      int timeInSeconds = records[1].toInt(); // 시간 (초)

      String score = calculateTime(timeInSeconds); // 시간을 문자열로 변환

      final review = RunningReviewModel(
        courseId: courseId.value,
        score: score, // score는 문자열로 전달
        runningDistance: distance,
        calorie: records[3].toDouble(),
        averagePace: records[2].toDouble(),
        comment: content.value,
        startDate: details['time'] as DateTime,
        finishDate:
            (details['time'] as DateTime).add(Duration(seconds: timeInSeconds)),
        personalImage: PersonalImage(
          url: selectedImage.value?.path ?? '',
          path: selectedImage.value?.path ?? '',
        ),
      );

      await _service.submitReview(review);
      Get.snackbar('성공', '리뷰가 성공적으로 등록되었습니다.');
      Get.back();
    } catch (e) {
      Get.snackbar('오류', '리뷰 등록 중 오류가 발생했습니다: $e');
      log('$e');
    }
  }
}
