import 'dart:core';
import 'dart:io';
import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider_test/core/services/storage_services.dart';
import '../models/user_model.dart';
import '../services/database_serrvice.dart';



class ProfileProvider extends ChangeNotifier {
  final editFormKey = GlobalKey<FormState>();
  final changePasswordKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();

  TextEditingController get nameController => _nameController;

  final TextEditingController _professionController = TextEditingController();

  TextEditingController get professionController => _professionController;

  final TextEditingController _addressController = TextEditingController();

  TextEditingController get addressController => _addressController;

  final TextEditingController _phoneNoController = TextEditingController();

  TextEditingController get phoneNoController => _phoneNoController;

  UserModels? _user;

  UserModels? get user => _user;

  getProfileData() async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    DatabaseService service = DatabaseService();
    _user = await service.getUser(uid);
    notifyListeners();
  }




  Future<void> changeProfile() async {

    String name =       _nameController.text.trim();
    String profession = _professionController.text.trim();
    String phoneNo =    _phoneNoController.text.trim();
    String address =    _addressController.text.trim();
    UserModels? userModels=_user!.copyWith(name: name,profession: profession,phoneNo: phoneNo,address: address);
    print("________________");
    print(_user!.uid);
    print(userModels!.uid);
    DatabaseService db = DatabaseService();
    await db.updateProfile(userModels);
    getProfileData();

    notifyListeners();

  }





  String? nameValidator(String? val) {
    if (val == null) {
      return 'Please fill the Name';
    }
    return null;
  }

  String? professionValidator(String? val) {
    if (val == null) {
      return 'Please fill the Profession';
    }
    return null;
  }

  String? addressValidator(String? val) {
    if (val == null) {
      return 'Please fill the Address';
    }
    return null;
  }

  String? phoneNoValidator(String? val) {
    if (val == null) {
      return 'Please fill the phone Number';
    }
    return null;
  }

  void setProfileData(String name, String profession, String phoneNo, String address) {
    _nameController.text=name;
    _professionController.text=profession;
    _phoneNoController.text=phoneNo;
    _addressController.text=address;

    notifyListeners();

  }




  ////////// Change password Controllers, Validators and Function
  final TextEditingController _oldPasswordController = TextEditingController();
  TextEditingController get oldPasswordController => _oldPasswordController;

  final TextEditingController _newPasswordController = TextEditingController();
  TextEditingController get newPasswordController  => _newPasswordController;

  final TextEditingController _confirmPasswordController = TextEditingController();
  TextEditingController get confirmPasswordController  => _confirmPasswordController;




  String? oldPasswordValidator(String? val) {
    if (val == null) {
      return 'Please fill the Old Password';
    }
    return null;
  }

  String? newPasswordValidator(String? val) {
    if (val == null) {
      return 'Please fill the New Password';
    }
    if(val.length< 8 ){
      return 'Password Must be at least eight characters';
    }
    return null;
  }

  String? confirmPasswordValidator(String? val) {
    if (val != newPasswordController.text) {
      return 'Password does not matches';
    }

    return null;
  }



  void clearPasswordController(){
    _oldPasswordController.clear();
    _newPasswordController.clear();
    _confirmPasswordController.clear();
  }

  void changePassword(){

    String newPassword = newPasswordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();
    try{
      final user = FirebaseAuth.instance.currentUser;

      user?.updatePassword(newPassword);
      clearPasswordController();
      FirebaseAuth.instance.signOut();



    }
    catch(e){
      print('Some thing went wrong');
    }
  }




  /// Get profile from gallery and sent to API

  String? filePath;
  Uint8List? imageFile;
  File? file;

  getPictureFromGallery(BuildContext context) async {

    final picker = ImagePicker();

    final XFile? pickedImage = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedImage != null) {
      filePath = pickedImage.path;

      file = File(pickedImage.path);
      imageFile= await  pickedImage.readAsBytes();
      notifyListeners();

      uploadImage().whenComplete(() =>  Navigator.of(context).pop());

      notifyListeners();

    } else {}


  }









///
/// get image from camera and send to API
///
  getPictureFromCamera(BuildContext context) async {

    final picker = ImagePicker();

    final XFile? pickedImage = await picker.pickImage(
      source: ImageSource.camera,
    );
    if (pickedImage != null) {
      filePath = pickedImage.path;

      file = File(pickedImage.path);
      imageFile= await  pickedImage.readAsBytes();
      notifyListeners();
      uploadImage().whenComplete(() =>  Navigator.of(context).pop());
      notifyListeners();



    } else {}


  }

  Future<void> uploadImage() async {
    StorageServices services=StorageServices();
    await services.uploadProfilePhoto(file!, user!);
   await getProfileData();

  }




}

