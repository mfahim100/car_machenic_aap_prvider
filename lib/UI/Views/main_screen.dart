import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:provider_test/UI/Views/tabs/completed.dart';
import 'package:provider_test/UI/Views/tabs/on_progress_projects.dart';
import 'package:provider_test/UI/Views/tabs/pending_projects.dart';
import 'package:provider_test/UI/Views/tabs/profile_screen.dart';
import 'package:provider_test/UI/widgets/add_button_dialog.dart';
import 'package:provider_test/core/providers/main_provider.dart';
import 'package:provider_test/core/providers/task_provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../core/constant/bottom_bar_colors.dart';
import '../../core/constant/const_gradient.dart';
import '../../core/providers/profile_provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  final autoSizeGroup = AutoSizeGroup();

  late AnimationController _fabAnimationController;
  late AnimationController _borderRadiusAnimationController;
  late Animation<double> fabAnimation;
  late Animation<double> borderRadiusAnimation;
  late CurvedAnimation fabCurve;
  late CurvedAnimation borderRadiusCurve;
  late AnimationController _hideBottomBarAnimationController;

  final iconList = <IconData>[
    Icons.pending,
    Icons.incomplete_circle,
    Icons.description,
    Icons.person,
  ];

  @override
  void initState() {
    super.initState();
    Provider.of<TaskProvider>(context,listen: false).loadData();
    Provider.of<ProfileProvider>(context,listen: false).getProfileData();


    _fabAnimationController = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );
    _borderRadiusAnimationController = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );
    fabCurve = CurvedAnimation(
      parent: _fabAnimationController,
      curve: Interval(0.5, 1.0, curve: Curves.fastOutSlowIn),
    );
    borderRadiusCurve = CurvedAnimation(
      parent: _borderRadiusAnimationController,
      curve: Interval(0.5, 1.0, curve: Curves.fastOutSlowIn),
    );

    fabAnimation = Tween<double>(begin: 0, end: 1).animate(fabCurve);
    borderRadiusAnimation = Tween<double>(begin: 0, end: 1).animate(
      borderRadiusCurve,
    );

    _hideBottomBarAnimationController = AnimationController(
      duration: Duration(milliseconds: 200),
      vsync: this,
    );

    Future.delayed(
      Duration(seconds: 1),
          () => _fabAnimationController.forward(),
    );
    Future.delayed(
      Duration(seconds: 1),
          () => _borderRadiusAnimationController.forward(),
    );
  }

  bool onScrollNotification(ScrollNotification notification) {
    if (notification is UserScrollNotification &&
        notification.metrics.axis == Axis.vertical) {
      switch (notification.direction) {
        case ScrollDirection.forward:
          _hideBottomBarAnimationController.reverse();
          _fabAnimationController.forward(from: 0);
          break;
        case ScrollDirection.reverse:
          _hideBottomBarAnimationController.forward();
          _fabAnimationController.reverse(from: 1);
          break;
        case ScrollDirection.idle:
          break;
      }
    }
    return false;
  }


  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<CustomColorsTheme>()!;

    return Consumer<MainProvider>(
      builder: (BuildContext context, mainProvider, child) {
        return Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                showDialog(
                    barrierDismissible: false,
                    context: context, builder: (context){
                  return  const AddButtonDialog();
                });
              },

              //params
              child: const Icon(Icons.add,color: Colors.white,),
            ),
            floatingActionButtonLocation:
            FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: AnimatedBottomNavigationBar.builder(
            itemCount: iconList.length,
            tabBuilder: (int index, bool isActive) {
              final color = isActive ? colors.activeNavigationBarColor : colors.notActiveNavigationBarColor;
              return Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    iconList[index],
                    size: 24,
                    color: color,
                  ),
                  const SizedBox(height: 4),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2),
                    child: AutoSizeText(
                      index==0?'Pending':
                      index==1?'OnProgress':
                      index==2?'Completed':
                      index==3?'Profile':
                      'Pending Tasks'
                      ,
                      maxLines: 1,
                      style: TextStyle(color: color),
                      group: autoSizeGroup,
                    ),
                  )
                ],
              );
            },
            backgroundColor: colors.bottomNavigationBarBackgroundColor,
            activeIndex: mainProvider.tabIndex,
            splashColor: colors.activeNavigationBarColor,
            notchAndCornersAnimation: borderRadiusAnimation,
            splashSpeedInMilliseconds: 300,
            notchSmoothness: NotchSmoothness.defaultEdge,
            gapLocation: GapLocation.center,
            leftCornerRadius: 32,
            rightCornerRadius: 32,
            onTap: (index) => mainProvider.setTabIndex(index),
            hideAnimationController: _hideBottomBarAnimationController,
            shadow: BoxShadow(
              offset: Offset(0, 1),
              blurRadius: 12,
              spreadRadius: 0.5,
              color: colors.activeNavigationBarColor,
            ),
          ),



            body: Container(
                width: 100.h,
                height: 100.h,
                decoration:  ConstGradient.mainDecoration,
                child: mainProvider.tabIndex == 0
                   ? const PendingProjectsTab()
                 : mainProvider.tabIndex == 1
                    ? const OnProgressProjectsTab()
                  : mainProvider.tabIndex == 2
                    ? const Completed() : const ProfileScreen()
            ),
        );
      },
    );
  }
}
