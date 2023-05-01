import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider_test/core/models/task_exp_model.dart';
import 'package:uuid/uuid.dart';

import '../models/task_model.dart';
import '../models/user_model.dart';

class DatabaseService {
  final _db = FirebaseFirestore.instance;
  static final DatabaseService _singleton = DatabaseService._internal();

  factory DatabaseService() {
    return _singleton;
  }

  DatabaseService._internal();




  Future<void> addUser(UserCredential user,String name,profession,address,phoneNo)async{

    try {
      await _db.collection('users').doc(user.user!.uid).set({
        "uid": user.user!.uid,
        "email": user.user!.email,
        "name": name,
        "profession":profession,
        "address":address,
        "phoneNo":phoneNo,
        "imgUrl":'',

      });
    } catch (e, s) {
      print('Exception @DatabaseService/registerPatient $e');
//      print(s);
    }
  }



  Future<UserModels?> getUser(String uid) async {
    try {
      final snapshot = await _db.collection('users').doc(uid).get();

      UserModels mdl = UserModels.fromMap(snapshot.data()!);

      return mdl;

    } catch (e, s) {
      print('Exception @DatabaseService/getUser $e');
    }
    return null;
  }


  Future<void> addTask(User user,String projectName,projectLocation,projectCost)async{

    String id= const Uuid().v1();

    try {
      await _db.collection('tasks').doc(id).set({
        "id": id,
        "email": user.email,
        "createdBy": user.uid,
        "projectName": projectName,
        "projectLocation":projectLocation,
        "projectCost":projectCost,
        "status":0,
        "expenses":0,
        "startDate":DateTime.now(),
        "endDate": DateTime.now(),
      }).whenComplete(() async {
        await _db.collection('tasks').doc(id).collection('uids').doc(user.uid).set(
            {
              "uid":user.uid,
              "type":'admin',

            });
      });
    } catch (e, s) {
      print('Exception @DatabaseService/registerPatient $e');
//      print(s);
    }
  }

  Future<void> updateTask(TaskModel taskModel)async{
    User? user;
    try {

      await _db.collection('tasks').doc(taskModel.id).set(taskModel.toMapTask());
    } catch (e, s) {
      print('Exception @DatabaseService/registerPatient $e');
//      print(s);
    }
  }


  Future<TaskModel?> getTask(String uid) async {
    try {
      final snapshot = await _db.collection('tasks').doc(uid).get();

      TaskModel mdl = TaskModel.fromMap(snapshot.data()!);
      mdl.id=snapshot.id;
      return mdl;

    } catch (e, s) {
      print('Exception @DatabaseService/getUser $e');
    }
    return null;
  }

  Future<List<TaskModel>> getPendingTask() async {
    List<TaskModel> mdl=[];
    try {
      final snapshot = await _db.collection('tasks').where('status',isEqualTo: 0).get();
      for (var element in snapshot.docs) {
        TaskModel mddl=TaskModel.fromMap(element.data());
        print(element.id);
        print(mddl.id);
        mdl.add(mddl);

      }
      print('pendingTasks length ${snapshot.size}');



    } catch (e, s) {
      print('Exception @DatabaseService/getPendingTask $e');
    }
    return mdl;

  }


  Future<List<TaskModel>> getOnProgressTask() async {
    List<TaskModel> mdl=[];
    try {
      final snapshot = await _db.collection('tasks').where('status',isEqualTo: 1).get();

      for (var element in snapshot.docs) {
        TaskModel mddl=TaskModel.fromMap(element.data());
        mddl.id=element.id;
        mdl.add(mddl);
      }
      print('On Progress Task length ${snapshot.size}');



    } catch (e, s) {
      print('Exception @DatabaseService/getPendingTask $e');
    }
    return mdl;

  }


  Future<List<TaskModel>> getCompletedTask() async {

    List<TaskModel> mdl=[];
    try {
      final snapshot = await _db.collection('tasks').where('status',isEqualTo: 2).get();

      for (var element in snapshot.docs) {
        TaskModel mddl=TaskModel.fromMap(element.data());
        mddl.id=element.id;
        mdl.add(mddl);
      }
      print('Completed Tasks length ${snapshot.size}');



    } catch (e, s) {
      print('Exception @DatabaseService/getPendingTask $e');
    }
    return mdl;

  }



  Future<void> updateProfile(UserModels userModel)async{


    print(userModel.uid);
    try {
      await _db.collection('users').doc(userModel!.uid).set(userModel.toMap());
    } catch (e, s) {
      print('Exception @DatabaseService/registerPatient $e');
//      print(s);
    }
  }

  Future<List<TaskExpModel>> getTaskAllExpensesByID(String? id) async {

   print(id);
    List<TaskExpModel> mdl=[];
    try {
      final snapshot = await _db.collection('tasks').doc(id!).collection('expenses').get();
      print(snapshot.size);
      for (var element in snapshot.docs) {
        TaskExpModel mddl=TaskExpModel.fromMap(element.data());
        mddl.id=element.id;
        mdl.add(mddl);
      }
      print('Completed Tasks length_____ ${snapshot.size}');

    } catch (e, s) {
      print('Exception @DatabaseService/getPendingTask $e');
    }
    return mdl;

  }
  Future<void> addTaskExpenses(String taskId,amount,imgUrl)async{

    String id= const Uuid().v1();

    try {
      await _db.collection('tasks').doc(taskId).collection('expenses').doc(id).set({
        "id": id,
        "amount": int.parse(amount),
        "imgUrl": imgUrl,
        "date":DateTime.now(),

      });
    } catch (e, s) {
      print('Exception @DatabaseService/registerPatient $e');
//      print(s);
    }
  }

//////////////
  Future<List<TaskModel>> getMyTasks() async {
    String uid=FirebaseAuth.instance.currentUser!.uid;
    print(uid);
    List<TaskModel> mdl=[];
    try {
      final snapshot = await _db.collection('tasks').get();
      for (var element in snapshot.docs) {
        final snapshotUids = await _db.collection('tasks').doc(element.id).collection('uids').get();
        for (var elementUids in snapshotUids.docs) {
          if(elementUids.id==uid){
            TaskModel mddl=TaskModel.fromMap(element.data());
            mdl.add(mddl);
          }
        }
      }
      print('Group Size ${snapshot.size}');

    } catch (e, s) {
      print('Exception @DatabaseService/getPendingTask $e');
    }
    return mdl;

  }


  Future<bool> joinTask(String secretKey)async{

    bool isAdded=false;
    User? user=FirebaseAuth.instance.currentUser;
    String uid = user!.uid;
      await _db.collection('tasks').doc(secretKey).collection('uids')
          .doc(uid)
          .set({
        "uid": uid,
        "type": 'member',
      });


    isAdded=true;


    return isAdded;
  }

}
