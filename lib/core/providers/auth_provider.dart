import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ndialog/ndialog.dart';
import 'package:provider_test/UI/Views/main_screen.dart';
import 'package:provider_test/core/services/database_serrvice.dart';

class AuthProvider extends ChangeNotifier {
  final signupKey = GlobalKey<FormState>();
  final signInKey = GlobalKey<FormState>();



  final TextEditingController _nameController = TextEditingController();
  TextEditingController get nameController => _nameController;

  final TextEditingController _professionController = TextEditingController();
  TextEditingController get professionController => _professionController;

  final TextEditingController _addressController = TextEditingController();
  TextEditingController get addressController => _addressController;

  final TextEditingController _phoneNoController = TextEditingController();
  TextEditingController get phoneNoController => _phoneNoController;

  final TextEditingController _emailController = TextEditingController();
  TextEditingController get emailController => _emailController;

  final TextEditingController _passController = TextEditingController();
  TextEditingController get passController => _passController;

  final TextEditingController _confirmPasswordController =
      TextEditingController();
  TextEditingController get confirmPasswordController =>
      _confirmPasswordController;



///////////////////////////////////////////////////////////////////////
  signUpFunc(BuildContext context) async {
    /// easyloading show
    String name = _nameController.text.trim();
    String professsion = _professionController.text.trim();
    String address = _addressController.text.trim();
    String phoneNo = _phoneNoController.text.trim();
    String email = _emailController.text.trim();
    String password = _passController.text.trim();

    ProgressDialog progressDialog = ProgressDialog(
      context,
      title: const Text('Signing UP'),
      message: const Text('Please Wait'),
    );

    try {
      progressDialog.show();
      FirebaseAuth auth = FirebaseAuth.instance;

      UserCredential user = await auth.createUserWithEmailAndPassword(
          email: email, password: password);

      if (user.user != null) {

        DatabaseService service =DatabaseService();
        await service.addUser(user, name,professsion,address,phoneNo);

        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(SnackBar(
            elevation: 0,
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            content: AwesomeSnackbarContent(
              title: 'Congratulation!!!',
              message: 'Your account have been created',
              contentType: ContentType.success,
            ),
          ));
        progressDialog.dismiss();
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (builder){
          return const MainScreen();
        }));
        clearSignUpControllers();


      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(SnackBar(
              content: AwesomeSnackbarContent(
            title: 'SORRY',
            contentType: ContentType.failure,
            message: 'Email Already in Use',
          )));
        progressDialog.dismiss();
      } else if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(SnackBar(
              content: AwesomeSnackbarContent(
            title: 'SORRY',
            contentType: ContentType.failure,
            message: 'Weak Password',
          )));
        progressDialog.dismiss();
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(
            content: AwesomeSnackbarContent(
          title: 'SORRY',
          contentType: ContentType.failure,
          message: 'Some thing went wrong',
        )));
      progressDialog.dismiss();
    }

    notifyListeners();
  }

  signInFunc(BuildContext context) async {
    String email = _emailController.text.trim();
    String password = _passController.text.trim();

    ProgressDialog progressDialog = ProgressDialog(
      context,
      title: const Text('Signing UP'),
      message: const Text('Please Wait'),
    );

    try{
      progressDialog.show();
      FirebaseAuth auth = FirebaseAuth.instance;
      UserCredential user = await auth.signInWithEmailAndPassword(email: email, password: password);

      if(user.user!=null){
        progressDialog.dismiss();
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(SnackBar(
            elevation: 0,
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            content: AwesomeSnackbarContent(
              title: 'Congratulation!!!',
              message: 'Your have logged to yor account',
              contentType: ContentType.success,
            ),
          ));
        clearSignInController();
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (builder){
          return const MainScreen();
        }));

      }

    }
    on FirebaseAuthException catch(e){
      progressDialog.dismiss();
      if(e.code == 'user-not-found'){
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(SnackBar(
            elevation: 0,
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            content: AwesomeSnackbarContent(
              title: 'Sorry!!!',
              message: 'User not found',
              contentType: ContentType.failure,
            ),
          ));

      }
      else if(e.code=='wrong-password'){
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(SnackBar(
            elevation: 0,
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            content: AwesomeSnackbarContent(
              title: 'Sorry!!!',
              message: 'Wrong Password',
              contentType: ContentType.failure,
            ),
          ));
      }
    }
    catch(e){
      progressDialog.dismiss();
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: 'Sorry!!!',
            message: 'Some thing went wrong',
            contentType: ContentType.failure,
          ),
        ));
    }


  }




  /// Validating Fucntionss

  String? validateName(String? value) {
    if (value!.isEmpty) {
      return "Name is empty";
    }
    return null;
  }

  String? validateProfession(String? value) {
    if (value!.isEmpty) {
      return "Profession is empty";
    }
    return null;
  }

  String? validateAddress(String? value) {
    if (value!.isEmpty) {
      return "Address is empty";
    }
    return null;
  }

  String? validatePhoneNumber(String? value){
    if(value!.isEmpty){
      return 'Phone Number is Empty';
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value!.isEmpty) {
      return "Email is empty";
    }
    return null;
  }

  String? passwordLength(String? value) {
    if (value!.isEmpty) {
      return "Password is empty";
    }
    if (value.length < 8) {
      return "Password must be least eight character,";
    }

    return null;
  }

  String? confirmPassword(String? value) {
    if (value! != _passController.text) {
      return "Password does not match";
    }
    return null;
  }






  ///// clear Controller functions
  void clearSignUpControllers() {
    _nameController.clear();
    _professionController.clear();
    _addressController.clear();
    _phoneNoController.clear();
    _emailController.clear();
    _passController.clear();
    _confirmPasswordController.clear();
    notifyListeners();
  }

  void clearSignInController(){
    _emailController.clear();
    _passController.clear();
    notifyListeners();
  }






}
