import 'dart:io';
import 'dart:typed_data';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider_test/core/models/task_exp_model.dart';
import 'package:provider_test/core/services/database_serrvice.dart';
import 'package:provider_test/core/services/storage_services.dart';
import 'package:qrscan/qrscan.dart' as scanner;

import '../models/task_model.dart';

class TaskProvider extends ChangeNotifier {
  TaskProvider() {
    loadData();
  }

  final addTaskKey = GlobalKey<FormState>();
  final addTaskExpKey = GlobalKey<FormState>();
  final addGroupKey = GlobalKey<FormState>();

  loadData() async {
    // await getPendingTasks();
    // await getOnProgressTask();
    // await getCompletedTask();
    await getMyTask();
    notifyListeners();
  }

  //////////////////////////////////////////////////
  TaskModel? _detailModel;

  TaskModel? get detailModel => _detailModel;

  setDetailModel(TaskModel model) {
    _detailModel = model;
    notifyListeners();
  }

  //////////////////////////////////////////////////
  /// Project page Controllers
  final TextEditingController _projectNameController = TextEditingController();

  TextEditingController get projectNameController => _projectNameController;

  final TextEditingController _projectLocationController =
      TextEditingController();

  TextEditingController get projectLocationController =>
      _projectLocationController;

  final TextEditingController _projectCostController = TextEditingController();

  TextEditingController get projectCostController => _projectCostController;

  final TextEditingController _startDateController = TextEditingController();

  TextEditingController get startDateController => _startDateController;

  final TextEditingController _endDateController = TextEditingController();

  TextEditingController get endDateController => _endDateController;

  uploadTask(BuildContext context) async {
    String projectName = _projectNameController.text.trim();
    String projectLocation = _projectLocationController.text.trim();
    int projectCost = int.parse(_projectCostController.text.trim());
    User? user = FirebaseAuth.instance.currentUser;

    try {
      EasyLoading.show();
      DatabaseService service = DatabaseService();
      await service.addTask(user!, projectName, projectLocation, projectCost);
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: 'Congratulation!!!',
            message: 'Your data had been uploaded',
            contentType: ContentType.success,
          ),
        ));
      EasyLoading.dismiss();
    } catch (e) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: 'Sorry!!!',
            message: 'Something went wrong',
            contentType: ContentType.failure,
          ),
        ));
      EasyLoading.dismiss();
    }

    clearAddProjectController();
    loadData();
    notifyListeners();
  }

//////////    ...... Validating Function.....
  String? validateProjectName(String? val) {
    if (val!.isEmpty) {
      return 'Project Name is Empty';
    }
    return null;
  }

  String? validProjectLocation(String? val) {
    if (val!.isEmpty) {
      return 'Project Location is Empty';
    }
    return null;
  }

  String? validProjectCost(String? val) {
    if (val!.isEmpty) {
      return 'Project Cost is Empty';
    }
    return null;
  }

  String? validStartDate(String? val) {
    if (val!.isEmpty) {
      return 'Start Date is Empty';
    }
    return null;
  }

  String? validEndDate(String? val) {
    if (val!.isEmpty) {
      return 'End Date is Empty';
    }
    return null;
  }

  void clearAddProjectController() {
    _projectNameController.clear();
    _projectLocationController.clear();
    _projectCostController.clear();
    _startDateController.clear();
    _endDateController.clear();
  }

  List<TaskModel> pendingTasks = [];
  List<TaskModel> onPogressTasks = [];
  List<TaskModel> completedTasks = [];
  List<TaskModel> getMyTasks = [];

  Future<void> getMyTask() async {
    getMyTasks.clear();
    DatabaseService db = DatabaseService();
    getMyTasks = await db.getMyTasks();
    print('getMyTasks.length${getMyTasks.length}');
    pendingTasks.clear();
    onPogressTasks.clear();
    completedTasks.clear();
    for (var element in getMyTasks) {
      if (element.status == 0) {
        pendingTasks.add(element);
      } else if (element.status == 1) {
        onPogressTasks.add(element);
      } else {
        completedTasks.add(element);
      }
      notifyListeners();
    }

    notifyListeners();
  }

  Future<void> getPendingTasks() async {
    pendingTasks.clear();
    DatabaseService db = DatabaseService();
    pendingTasks = await db.getPendingTask();
    print('pendingTasks.length${pendingTasks.length}');
    notifyListeners();
  }

  Future<void> getOnProgressTask() async {
    onPogressTasks.clear();
    DatabaseService db = DatabaseService();
    onPogressTasks = await db.getOnProgressTask();

    print('onPogressTasks:  ${onPogressTasks.length}');
    notifyListeners();
  }

  Future<void> getCompletedTask() async {
    completedTasks.clear();
    DatabaseService db = DatabaseService();
    completedTasks = await db.getCompletedTask();

    print('Completed Tasks:  ${completedTasks.length}');
    notifyListeners();
  }

  Future<void> changeStatusTask(TaskModel taskModel) async {
    EasyLoading.show();
    DatabaseService db = DatabaseService();
    await db.updateTask(taskModel);
    notifyListeners();
    loadData();
    EasyLoading.dismiss();
  }

  /// Expenses ////////////////////////////////////////////////////
  String? amountValidator(String? val) {
    final bool numValid = RegExp(r"^[0-9]").hasMatch(val!);
    if (val!.isEmpty) {
      return 'Amount is Empty';
    } else if (!numValid) {
      return 'Amount is not in numbers';
    }
    return null;
  }

  final TextEditingController _amountController = TextEditingController();

  TextEditingController get amountController => _amountController;

  List<TaskExpModel> taskExpensesModelList = [];

  Future<void> getTaskExpenses(TaskModel model) async {
    setDetailModel(model);
    DatabaseService db = DatabaseService();
    taskExpensesModelList = await db.getTaskAllExpensesByID(model.id!);
    notifyListeners();
  }
  /// Get profile from gallery and sent to API
  String? filePath;
  Uint8List? imageFile;
  File? file;
  getPictureFromGallery(BuildContext context, TaskModel task) async {
    final picker = ImagePicker();
    final XFile? pickedImage = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedImage != null) {
      filePath = pickedImage.path;
      file = File(pickedImage.path);
      imageFile = await pickedImage.readAsBytes();
      notifyListeners();
      uploadImage(task).whenComplete(() => Navigator.of(context).pop());
      notifyListeners();
    } else {}
  }

  ///
  /// get image from camera and send to API
  ///
  getPictureFromCamera(BuildContext context, TaskModel task) async {
    final picker = ImagePicker();

    final XFile? pickedImage = await picker.pickImage(
      source: ImageSource.camera,
    );
    if (pickedImage != null) {
      filePath = pickedImage.path;

      file = File(pickedImage.path);
      imageFile = await pickedImage.readAsBytes();
      notifyListeners();
      uploadImage(task).whenComplete(() => Navigator.of(context).pop());

      notifyListeners();
    } else {}
  }

  Future<void> uploadImage(TaskModel task) async {
    EasyLoading.show();
    print('______________ uploadImage ');
    String amount = _amountController.text.trim();
    print(amount);
    int expenses = task.expenses! + int.parse(amount);
    print(expenses.toString());
    TaskModel newTask = task.copyWith(expenses: expenses);

    StorageServices services = StorageServices();
    DatabaseService _db = DatabaseService();

    await services
        .uploadExpensePhoto(file!, amount, task.id!)
        .whenComplete(() async => await _db
            .updateTask(newTask)
            .whenComplete(() async => await getTaskExpenses(newTask)
                .whenComplete(() => EasyLoading.dismiss())
                .onError((error, stackTrace) => EasyLoading.dismiss()))
            .onError((error, stackTrace) => EasyLoading.dismiss()))
        .onError((error, stackTrace) {
      EasyLoading.dismiss();
      return '';
    });
  }

  Future<void> permissionHandler(BuildContext context) async {
    var status = await Permission.camera.status;
    print(status.toString());

    if (status.isDenied) {
      print('in denied block');
      await Permission.camera.request().then((value) {
        if (value.isPermanentlyDenied) {
          showDialog<String>(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) => AlertDialog(
              title: const Text('Allow Camer'),
              content:
                  const Text('This app uses the camera to scan the QR code'),
              actions: <Widget>[
                // if user deny again, we do nothing
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Don\'t allow'),
                ),

                TextButton(
                  onPressed: () {
                    openAppSettings();
                    Navigator.pop(context);
                  },
                  child: const Text('Allow'),
                ),
              ],
            ),
          );
        }
      });
    } else if (status.isGranted) {
      await scanner.scan().then((cameraScanResult) async {
        EasyLoading.show();
        DatabaseService db = DatabaseService();
        await db.joinTask(cameraScanResult!).whenComplete(() async {
          await getMyTask();
          EasyLoading.dismiss();
        }).onError((error, stackTrace) {
          print(error.toString());
          EasyLoading.dismiss();
          return false;
        });
      }).onError((error, stackTrace) {
        print(error.toString());
        EasyLoading.dismiss();
      });
      // setState(() {
      //   qrValue = cameraScanResult!;
      // });
    } else if (status.isPermanentlyDenied) {
      showDialog<String>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Allow Camer'),
          content: const Text('This app uses the camera to scan the QR code'),
          actions: <Widget>[
            // if user deny again, we do nothing
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Don\'t allow'),
            ),

            TextButton(
              onPressed: () {
                openAppSettings();
                Navigator.pop(context);
              },
              child: const Text('Allow'),
            ),
          ],
        ),
      );
    } else if (status.isRestricted) {
      print('Something Restricted');
    }
  }
} // end of the class
