
class UserModels {

  late String? uid;
  late String name;
  late String profession;
  late String address;
  late String phoneNo;
  late String email;
  late String imgUrl;

  UserModels({
    this.uid,
    required this.name,
    required this.profession,
    required this.address,
    required this.phoneNo,
    required this.email,
    required this.imgUrl,
  });


  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};
    map['uid'] = uid;
    map['name'] = name;
    map['profession'] = profession;
    map['address'] = address;
    map['phoneNo'] = phoneNo;
    map['email'] = email;
    map['imgUrl'] =imgUrl ;

    return map;
  }

  UserModels.fromMap(Map<String, dynamic> map){
    uid = map['uid'];
    name = map['name'];
    profession = map['profession'];
    address = map['address'];
    phoneNo = map['phoneNo'];
    email = map['email'];
    imgUrl = map['imgUrl'];
  }

  UserModels? copyWith({
    String? uid,
    String? name,
    String? profession,
    String? address,
    String? phoneNo,
    String? email,
    String? imgUrl,
  }) =>
      UserModels(
        uid: uid??this.uid,
          name: name ?? this.name,
        profession: profession ?? this.profession,
        address: address ?? this.address,
        phoneNo: phoneNo ?? this.phoneNo,
        email: email?? this.email,
          imgUrl: imgUrl?? this.imgUrl
      );

}











