import 'package:cloud_firestore/cloud_firestore.dart';

class TaskModel {
  String? imgUrl;
  String? createdBy;
  String? email;
  String? uid;
  String? id;
  String? projectName;
  String? projectLocation;
  int? projectCost;
  Timestamp? startDate;
  Timestamp? endDate;
  int? status;
  int? expenses;

  TaskModel({
    this.imgUrl,
    this.id,
    this.uid,
    this.email,
    this.createdBy,
    required this.projectName,
    required this.projectLocation,
    required this.projectCost,
    required this.startDate,
    required this.endDate,
    required this.status,
    required this.expenses,
  });

  Map<String, dynamic> toMapTask() {
    Map<String, dynamic> map = {};

    map['imgUrl'] = imgUrl;
    map['id'] = id;
    map['uid'] = uid;
    map['email'] = email;
    map['createdBy']= createdBy;
    map['projectName'] = projectName;
    map['projectLocation'] = projectLocation;
    map['projectCost'] = projectCost;
    map['startDate'] = startDate;
    map['endDate'] = endDate;
    map['status'] = status;
    map['expenses'] = expenses;

    return map;
  }

  TaskModel.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    imgUrl = map['imgUrl'];
    uid = map['uid'];
    email = map['email'];
    createdBy = map['createdBy'];
    projectName = map['projectName'];
    projectLocation = map['projectLocation'];
    projectCost = map['projectCost'];
    startDate = map['startDate'];
    endDate = map['endDate'];
    status = map['status'];
    expenses = map['expenses'];
  }

  TaskModel copyWith(
          {String? createdBy,
            String? email,
            String? imgUrl,
          String? uid,
          String? id,
          String? projectName,
          String? projectLocation,
          int? projectCost,
          Timestamp? startDate,
          Timestamp? endDate,
          int? status,
          int? expenses}) =>
      TaskModel(
        id: id ?? this.id,
           createdBy:createdBy ?? this.createdBy,
        imgUrl:imgUrl ?? this.imgUrl,
           email: email?? this.email,
           uid: uid?? this.uid,
           projectName: projectName?? this.projectName,
           projectLocation: projectLocation?? this.projectLocation,
           projectCost: projectCost?? this.projectCost,
          startDate:startDate ?? this.startDate,
          endDate: endDate?? this.endDate,
          status:status ?? this.status,
          expenses:expenses ?? this.expenses,
      );
}
