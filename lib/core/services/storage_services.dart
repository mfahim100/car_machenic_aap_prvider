import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:provider_test/core/services/database_serrvice.dart';
import '../models/user_model.dart';

class StorageServices{

  Future<String> uploadProfilePhoto(File image,UserModels model) async {
    String url = '';
    String imgId = DateTime.now().microsecondsSinceEpoch.toString();
    Reference reference =
    FirebaseStorage.instance.ref().child("profiles").child(model.uid!);
    await reference.putFile(image);
    print('@@@@@@@@@@ $image');
    url = await reference.getDownloadURL();

    UserModels? mdl=model.copyWith(imgUrl: url);
    DatabaseService _db=DatabaseService();
    await _db.updateProfile(mdl!);
    print('@@@@@@@@@@ $url');
    return url;

  }



  Future<String> uploadExpensePhoto(File image,String amount,String taskId) async {
    String url = '';
    String imgId = DateTime.now().microsecondsSinceEpoch.toString();
    Reference reference =
    FirebaseStorage.instance.ref().child("taskExpenses").child(imgId);
    await reference.putFile(image);
    print('@@@@@@@@@@ $image');
    url = await reference.getDownloadURL();


    DatabaseService _db=DatabaseService();
    await _db.addTaskExpenses(taskId, amount, url);
    print('@@@@@@@@@@ $url');
    return url;


  }




}