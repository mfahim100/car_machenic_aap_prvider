
import 'package:cloud_firestore/cloud_firestore.dart';

class TaskExpModel {
  String? imgUrl;
  String? id;
  int? amount;
  Timestamp? date;

  TaskExpModel({
    required this.imgUrl,
    required this.id,
    required this.amount,
    required this.date
  });

  Map<String, dynamic> toMapTask() {
    Map<String, dynamic> map = {};

    map['imgUrl'] = imgUrl;
    map['id'] = id;
    map['amount'] = amount;
    map['date'] = date;
    return map;
  }

  TaskExpModel.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    imgUrl = map['imgUrl'];
    amount = map['amount'];
    date = map['date'];
  }

  TaskExpModel copyWith({String? imgUrl, String? id, int? amount}) =>
      TaskExpModel(
        id: id ?? this.id,
        imgUrl: imgUrl ?? this.imgUrl,
        amount: amount ?? this.amount,
        date: date ?? date,
      );
}
