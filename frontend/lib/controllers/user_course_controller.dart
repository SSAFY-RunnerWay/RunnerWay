import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:frontend/controllers/auth_controller.dart';
import 'package:frontend/controllers/record_controller.dart';
import 'package:get/get.dart';
import 'package:frontend/services/user_course_service.dart';
import 'dart:developer';
import 'dart:io';
import 'package:frontend/utils/s3_image_upload.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class UserCourseController extends GetxController {
  final UserCourseService _userCourseService = UserCourseService();
  final AuthController _authController = Get.find<AuthController>();
  final RecordController recordController = Get.put(RecordController());
  final _storage = FlutterSecureStorage();

  final S3ImageUpload s3ImageUpload = S3ImageUpload();
  final ImagePicker _picker = ImagePicker();
  var selectedImage = Rx<File?>(null);
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var isButtonActive = false.obs;
  var isImageUploading = false.obs;

  // 이미지 선택 함수
  Future<void> pickImage() async {
    isImageUploading.value = true;
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      selectedImage.value = File(pickedFile.path);
      String? uploadedImageUrl = await s3ImageUpload.uploadImage2(
        selectedImage.value!,
        "uploads/course_images",
      );

      if (uploadedImageUrl != null) {
        log("업로드된 이미지 URL: $uploadedImageUrl");
      } else {
        // Get.snackbar('오류', '이미지 업로드에 실패했습니다.');
      }
    }
    isImageUploading.value = false;
  }

  // 유저 코스 등록
  Future<void> addUserCourse(
      Map<String, Object> userCourseRegistRequestDto) async {
    isLoading(true);
    try {
      // 토큰 storage에서 가져오기
      String? token = await _storage.read(key: 'ACCESS_TOKEN');
      if (token == null) {
        throw Exception('토큰이 없어요');
      }

      // 디코드해서 memberId 추출
      Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
      String memberId = decodedToken['id'].toString();
      log('Decoded memberId: $memberId');

      // 유효한 recordId 가져오기
      final recordId = recordController.recordDetail.value?.recordId ?? 0;
      if (recordId == 0) {
        throw Exception('유효한 recordId가 필요합니다.');
      }

      // 데이터가 제대로 들어가 있는지 확인
      userCourseRegistRequestDto['recordId'] = recordId;
      userCourseRegistRequestDto['memberId'] = memberId;
      log('usercousrse컨트롤러 data: $userCourseRegistRequestDto');

      // 유저 코스 등록 메서드 호출
      final response =
          await _userCourseService.addUserCourse(userCourseRegistRequestDto);

      if (response != null) {
        final response2 =
            await _userCourseService.uploadJson(response, recordId.toString());
      }

      // Get.snackbar('성공', '유저 코스 추가가 완료되었습니다.');
    } catch (e) {
      errorMessage('유저 코스 추가 중 오류 발생 controller: $e');
      log(errorMessage.value);
    } finally {
      isLoading(false);
    }
  }
}
