import 'dart:developer' as dev;
import 'dart:io';
import 'dart:convert';
import 'dart:math';
import 'package:path_provider/path_provider.dart';
import 'package:frontend/models/running_record_model.dart';

class FileService {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _tmpFile async {
    final path = await _localPath;
    return File('$path/tmp.json');
  }

  Future<void> resetJson() async {
    try {
      final file = await _tmpFile;
      if (await file.exists()) {
        await file.delete();
        print('tmp.json has been deleted successfully.');
      } else {
        print('tmp.json does not exist.');
      }
    } catch (e) {
      print('Error appending to file: $e');
      throw e;
    }
  }

  Future<void> appendRunningRecord(RunningRecord record) async {
    try {
      final file = await _tmpFile;

      // Read the existing file content
      List<dynamic> records = [];
      if (await file.exists()) {
        String contents = await file.readAsString();
        // Parse the existing JSON content
        records = jsonDecode(contents) as List<dynamic>;
      }

      // Add the new record
      records.add(record.toJson());

      // Write the updated list back to the file
      await file.writeAsString(jsonEncode(records), mode: FileMode.writeOnly);

      print('Successfully appended record to file: ${file.path}');
    } catch (e) {
      print('Error appending to file: $e');
      throw e;
    }
  }

  // Future<void> appendRunningRecord(RunningRecord record) async {
  //   try {
  //     final file = await _tmpFile;
  //     final jsonRecord = json.encode(record.toJson());
  //
  //     if (await file.exists()) {
  //       // 파일이 존재하면 마지막 ] 를 제거하고 새 레코드를 추가
  //       String contents = await file.readAsString();
  //       contents = contents.substring(0, contents.length - 1); // 마지막 ] 제거
  //       await file.writeAsString('$contents,\n$jsonRecord]',
  //           mode: FileMode.writeOnlyAppend);
  //     } else {
  //       // 파일이 존재하지 않으면 새로 생성
  //       await file.writeAsString('[\n$jsonRecord]', mode: FileMode.writeOnly);
  //     }
  //
  //     print('Successfully appended record to file: ${file.path}');
  //   } catch (e) {
  //     print('Error appending to file: $e');
  //     throw e;
  //   }
  // }

  Future<void> renameFile(String recordId) async {
    try {
      final path = await _localPath;
      final File tmpFile = await _tmpFile;
      if (await tmpFile.exists()) {
        final String newPath = '$path/$recordId.json';
        await tmpFile.rename(newPath);
      }
      dev.log('파일 다른 이름으로 저장 됨');
    } catch (e) {
      print('Error renaming file: $e');
    }
  }

  Future<void> renameFile2(String newFileName) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final File tmpFile = File('${directory.path}/tmp.json');
      if (await tmpFile.exists()) {
        final String newPath = '${directory.path}/$newFileName.json';
        await tmpFile.rename(newPath);
        print('File renamed to: $newPath');
      } else {
        print('tmp.json does not exist');
      }
    } catch (e) {
      print('Error renaming file: $e');
      throw e; // 에러를 상위로 전파하여 RunningController에서 처리할 수 있게 함
    }
  }
}
