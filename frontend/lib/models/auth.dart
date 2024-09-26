class Auth {
  final String email;
  final String nickname;
  final DateTime? birth; // 생일은 DateTime으로 처리 가능
  final int? gender; // 0 또는 1로 구분
  final int? height;
  final int? weight;
  final MemberImage? memberImage; // memberImage는 nullable 가능
  final String joinType; // "kakao" 같은 회원가입 타입

  Auth({
    required this.email,
    required this.nickname,
    this.birth,
    this.gender,
    this.height,
    this.weight,
    this.memberImage, // nullable 처리
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
          : null, // memberImage가 nullable
    );
  }

  // Auth 객체를 JSON으로 변환하는 메서드
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'nickname': nickname,
      'birth': birth?.toIso8601String(),
      'gender': gender,
      'height': height,
      'weight': weight,
      'joinType': joinType,
      // 'memberImage': memberImage?.toJson(),
      'memberImage': memberImage != null
          ? memberImage!.toJson()
          : null, // nullable memberImage 처리
    };
  }
}

// MemberImage 모델
class MemberImage {
  final int? memberId; // nullable 처리
  final String? url; // nullable 처리
  final String? path; // nullable 처리

  MemberImage({
    this.memberId, // nullable
    this.url, // nullable
    this.path, // nullable
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
