import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/controllers/user_course_controller.dart';
import 'package:frontend/views/running/widgets/record_map.dart';
import 'package:get/get.dart';
import '../../controllers/record_controller.dart';
import '../../widgets/button/wide_button.dart';
import '../../widgets/map/result_map.dart';
import '../../widgets/review_record_item.dart';

class RegisterView extends StatelessWidget {
  RegisterView({super.key});
  final TextEditingController courseNameController = TextEditingController();
  final TextEditingController reviewController = TextEditingController();
  final UserCourseController userCourseController =
      Get.put(UserCourseController());
  final RecordController recordController = Get.find<RecordController>();

  @override
  Widget build(BuildContext context) {
    // Get.lazyPut<RecordController>(() => RecordController());
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final int recordId = int.tryParse(Get.parameters['id'] ?? '0') ?? 0;
    final RxBool isButtonDisabled = false.obs;
    final RxBool isLoading = false.obs;

    return PopScope(
        onPopInvokedWithResult: (popType, result) async {
          if (popType) {
            Get.offNamed('/record');
          }
          Get.delete<UserCourseController>();
        },
        child: Scaffold(
          appBar: AppBar(
            scrolledUnderElevation: 0,
            centerTitle: true,
            title: Text('러닝 코스 등록',
                style: TextStyle(fontSize: 20, color: Colors.black)),
            backgroundColor: Colors.white,
            toolbarHeight: 56,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(
                    () {
                      final record = recordController.recordDetail.value!;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextField(
                            controller: courseNameController,
                            onChanged: (value) {
                              userCourseController.isButtonActive.value =
                                  value.isNotEmpty;
                            },
                            decoration: InputDecoration(
                              hintText: '코스 이름을 입력해주세요',
                              border: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black)),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black)),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.blueAccent)),
                            ),
                            cursorColor: Colors.blueAccent,
                            cursorErrorColor: Colors.red,
                          ),
                          SizedBox(height: 20),
                          GestureDetector(
                              onTap: () async {
                                await userCourseController.pickImage();
                              },
                              child: Stack(
                                children: [
                                  Container(
                                    height: screenHeight * 0.3,
                                    width: screenWidth,
                                    child: userCourseController
                                                .selectedImage.value !=
                                            null
                                        ? Image.file(
                                            userCourseController
                                                .selectedImage.value!,
                                            fit: BoxFit.cover,
                                          )
                                        : record.url != null &&
                                                record.url!.isNotEmpty
                                            ? Image.network(
                                                record.url!,
                                                fit: BoxFit.cover,
                                                errorBuilder: (context, error,
                                                    stackTrace) {
                                                  return Center(
                                                    child: Image.asset(
                                                      'assets/images/main/course_default.png',
                                                      width: 80,
                                                      height: 80,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  );
                                                },
                                              )
                                            : Center(
                                                child: Image.asset(
                                                  'assets/images/main/course_default.png',
                                                  width: 80,
                                                  height: 80,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                  ),
                                  if (userCourseController
                                          .selectedImage.value ==
                                      null)
                                    Positioned(
                                      bottom: screenHeight * 0.1,
                                      right: screenWidth / 2 - 83,
                                      child: CircleAvatar(
                                        radius: 12,
                                        backgroundColor: Color(0xFF1EA6FC),
                                        child: Icon(
                                          Icons.add,
                                          size: 16,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                ],
                              )),
                          SizedBox(height: 28),
                          Text(
                            '코스 설명',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 16),
                          TextField(
                            controller: reviewController,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.grey.shade100,
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide.none),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide.none),
                            ),
                            cursorColor: Colors.blueAccent,
                            maxLength: 300,
                            maxLines: null,
                          ),
                          SizedBox(height: 50),
                          recordController.isLoading.isTrue
                              ? Center(child: CircularProgressIndicator())
                              : recordController.recordDetail.value == null
                                  ? Center(child: Text('기록이 없습니다.'))
                                  : Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '기록 상세',
                                          style: TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        SizedBox(height: 24),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            ReviewRecordItem(
                                              value:
                                                  record.runningDistance ?? 0.0,
                                              label: '운동 거리',
                                            ),
                                            ReviewRecordItem(
                                              value: (record.finishDate !=
                                                          null &&
                                                      record.startDate != null)
                                                  ? DateTime.parse(
                                                          record.finishDate!)
                                                      .difference(
                                                          DateTime.parse(record
                                                              .startDate!))
                                                      .inSeconds
                                                  : 0,
                                              label: '운동 시간',
                                            ),
                                            ReviewRecordItem(
                                              value: recordController
                                                      .courseDetail
                                                      .value
                                                      ?.averageSlope ??
                                                  0.0,
                                              label: '러닝 경사도',
                                            ),
                                            ReviewRecordItem(
                                              value: recordController
                                                      .recordDetail
                                                      .value!
                                                      .calorie ??
                                                  0.0,
                                              label: '소모 칼로리',
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 30),
                                        AbsorbPointer(
                                          absorbing: true,
                                          child: SizedBox(
                                            height: 300,
                                            child: RecordMap(height: 250),
                                          ),
                                        ),
                                      ],
                                    ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: Obx(() {
            if (userCourseController.isImageUploading.value) {
              // 이미지 업로드 중일 때
              return Padding(
                padding: const EdgeInsets.all(20),
                child: WideButton(
                  text: '이미지 업로드 중',
                  isActive: false,
                  onTap: null,
                ),
              );
            } else if (isLoading.value) {
              // 유저 코스 등록 중
              return const Scaffold(
                body: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '유저 코스 등록 중',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 20),
                      CircularProgressIndicator(),
                    ],
                  ),
                ),
              );
            } else {
              // 이미지 업로드가 완료된 후 버튼 활성화
              return Padding(
                padding: const EdgeInsets.all(20),
                child: WideButton(
                  text: '유저 코스 등록',
                  isActive: userCourseController.isButtonActive.value &&
                      recordController.recordDetail.value != null,
                  onTap: userCourseController.isButtonActive.value &&
                          recordController.recordDetail.value != null &&
                          !isButtonDisabled.value &&
                          !isLoading.value
                      ? () async {
                          isButtonDisabled.value = true;
                          isLoading.value = true;

                          final record = recordController.recordDetail.value!;

                          await userCourseController.addUserCourse({
                            'name': courseNameController.text,
                            'recordId': record.recordId ?? 0,
                            'address': record.address ?? 0,
                            'content': reviewController.text.isNotEmpty
                                ? reviewController.text
                                : '리뷰 없음',
                            'averageTime': (record.finishDate != null &&
                                    record.startDate != null)
                                ? _calculateTimeDifferenceWithDate(
                                    record.startDate!, record.finishDate!)
                                : '2024-10-08T00:00:00',
                            'courseLength': record.runningDistance,
                            'courseType': 'user',
                            'averageCalorie': record.calorie ?? 0.0,
                            'lat': record.lat ?? 0.0,
                            'lng': record.lng ?? 0.0,
                            'url':
                                'https://runnerway.s3.ap-northeast-2.amazonaws.com/test/test2.json',
                            'courseImage': {
                              'url': userCourseController.selectedImage.value !=
                                          null &&
                                      userCourseController
                                          .selectedImage.value!.path.isNotEmpty
                                  ? await userCourseController.s3ImageUpload
                                      .uploadImage2(
                                          userCourseController
                                              .selectedImage.value!,
                                          "uploads/course_images")
                                  : (record.url != null &&
                                          record.url!.isNotEmpty
                                      ? record.url
                                      : 'default_url'),
                              'path': userCourseController
                                      .selectedImage.value?.path ??
                                  'path/to/image',
                            },
                          });

                          isLoading.value = false;
                          Get.offNamed('/record');
                        }
                      : null,
                ),
              );
            }
          }),
        ));
  }
}

// 시간에 날짜도 추가하는 메서드
String _calculateTimeDifferenceWithDate(String startDate, String finishDate) {
  final duration =
      DateTime.parse(finishDate).difference(DateTime.parse(startDate));
  String twoDigits(int n) => n.toString().padLeft(2, '0');
  final parsedStartDate = DateTime.parse(startDate);
  final datePart =
      "${parsedStartDate.year}-${twoDigits(parsedStartDate.month)}-${twoDigits(parsedStartDate.day)}";
  final hours = twoDigits(duration.inHours);
  final minutes = twoDigits(duration.inMinutes.remainder(60));
  final seconds = twoDigits(duration.inSeconds.remainder(60));
  return "$datePart" + "T$hours:$minutes:$seconds";
}
