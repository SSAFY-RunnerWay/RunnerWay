class Auth {
  final String email;
  final String nickname;
  final DateTime? birth; // 생일은 DateTime으로 처리 가능
  final int? gender; // 0 또는 1로 구분
  final int? height;
  final int? weight;
  final MemberImage? memberImage; // memberImage는 별도의 클래스에서 관리
  final String joinType; // "kakao" 같은 회원가입 타입

  //required 여부 확인
  Auth({
    required this.email,
    required this.nickname,
    this.birth,
    this.gender,
    this.height,
    this.weight,
    this.memberImage,
    required this.joinType,
  });

  // JSON 데이터를 Auth 객체로 변환하는 factory method
  factory Auth.fromJson(Map<String, dynamic> json) {
    return Auth(
      email: json['email'],
      nickname: json['nickname'],
      birth: json['birth'] != null
          ? DateTime.parse(json['birth'])
          : null, // string을 DateTime으로 변환
      gender: json['gender'],
      height: json['height'],
      weight: json['weight'],
      joinType: json['joinType'],
      memberImage: json['memberImage'] != null
          ? MemberImage.fromJson(json['memberImage'])
          : null, // memberImage 처리
    );
  }

  // Auth 객체를 JSON으로 변환하는 메서드
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'nickname': nickname,
      'birth': birth != null
          ? birth!.toIso8601String()
          : null, // DateTime을 string으로 변환
      'gender': gender,
      'height': height,
      'weight': weight,
      'joinType': joinType,
      'memberImage': memberImage != null ? memberImage!.toJson() : null,
    };
  }
}

// MemberImage 모델
class MemberImage {
  final int memberId;
  final String url;
  final String path;

  MemberImage({
    required this.memberId,
    required this.url,
    required this.path,
  });

  factory MemberImage.fromJson(Map<String, dynamic> json) {
    return MemberImage(
      memberId: json['memberId'],
      url: json['url'],
      path: json['path'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'memberId': memberId,
      'url': url,
      'path': path,
    };
  }
}
