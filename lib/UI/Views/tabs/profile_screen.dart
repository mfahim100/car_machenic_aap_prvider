import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_test/UI/Views/home_screen.dart';
import 'package:provider_test/UI/widgets/edit_profile_widget.dart';
import 'package:provider_test/UI/widgets/pic_dialog_box.dart';
import 'package:provider_test/core/constant/const_gradient.dart';
import 'package:provider_test/core/constant/const_styles.dart';
import 'package:provider_test/core/providers/profile_provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../widgets/change_password_dialogbox.dart';
import '../../widgets/profile_buttons.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileProvider>(
      builder: (context, profileProvider, child) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.blueAccent,
          body: SizedBox(
            width: 100.w,
            height: 100.h,
            child: Container(
                decoration: ConstGradient.profileTileDecoration
                    .copyWith(borderRadius: BorderRadius.zero),
                padding: EdgeInsets.all(1.h),
                child: Column(
                  children: [
                    Column(
                      children: [
                        Stack(
                          children: [
                            profileProvider.user!.imgUrl.isEmpty
                                ? CircleAvatar(
                                    radius: 25.w,
                                    backgroundImage:const AssetImage(
                                        'assets/images/task_placeholder.png'),
                                  )
                                : CircleAvatar(
                                    radius: 25.w,
                                    backgroundImage: NetworkImage(
                                        profileProvider.user!.imgUrl),
                                  ),
                            Positioned(
                              bottom: 3.w,
                              right: 3.w,
                              child: CircleAvatar(
                                  radius: 5.w,
                                  child: IconButton(
                                    onPressed: () {
                                      showDialog(
                                          barrierDismissible: false,
                                          context: context,
                                          builder: (context) {
                                            return const ImageDialogBox();
                                          });
                                    },
                                    icon: const Icon(Icons.camera_alt_rounded),
                                  )),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        Text(
                          profileProvider.user!.name,
                          style:
                              TextStyle(fontSize: 18.sp, color: Colors.white),
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        Text(profileProvider.user!.email,
                            style: TextStyle(
                                fontSize: 18.sp, color: Colors.white)),
                        SizedBox(
                          height: 2.h,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Center(
                          child: Container(
                            padding: EdgeInsets.all(.5.w),
                            width: 95.w,
                            decoration: ConstGradient.profileTileDecoration,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: .5.h,
                                ),
                                Align(
                                    alignment: Alignment.topRight,
                                    child: GestureDetector(
                                        onTap: () {
                                          profileProvider.setProfileData(
                                            profileProvider.user!.name,
                                            profileProvider.user!.profession,
                                            profileProvider.user!.phoneNo,
                                            profileProvider.user!.address,
                                          );
                                          showDialog(
                                              barrierDismissible: false,
                                              context: context,
                                              builder: (context) {
                                                return const EditProfileDialogBox();
                                              });
                                        },
                                        child: Padding(
                                          padding: EdgeInsets.all(2.w),
                                          child: const Icon(
                                            Icons.edit,
                                            color: Colors.white,
                                          ),
                                        ))),
                                SizedBox(
                                  height: .3.h,
                                ),
                                buildDetailProfileList(
                                    'Name : ', profileProvider.user!.name),
                                buildDetailProfileList('Profession : ',
                                    profileProvider.user!.profession),
                                buildDetailProfileList('Phone Number : ',
                                    profileProvider.user!.phoneNo),
                                buildDetailProfileList('Address : ',
                                    profileProvider.user!.address),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 1.5.h,
                    ),
                    ProfileButtons(
                        txt: 'Change Password',
                        onPressed: () {
                          showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (context) {
                                return const ChangePasswordDialogBox();
                              });
                        },
                        icon: Icons.lock),
                    ProfileButtons(
                        txt: 'Logout',
                        onPressed: () {
                          FirebaseAuth.instance.signOut();
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: (builder) {
                            return const HomeScreen();
                          }));
                        },
                        icon: Icons.logout),
                    ProfileButtons(
                        txt: 'Delete Account',
                        onPressed: () {},
                        icon: Icons.delete),
                  ],
                )),
          ),
        );
      },
    );
  }

  Widget buildDetailProfileList(String name, String val) {
    return Padding(
      padding:  EdgeInsets.only(left: 3.w,right: 3.w),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                name,
                style: ConstStyles.kMessageStyle,
              ),
              Text(
                val,
                style: ConstStyles.kMessageStyle,
              ),
            ],
          ),
          SizedBox(
            height: 1.5.h,
          ),
        ],
      ),
    );
  }
}
