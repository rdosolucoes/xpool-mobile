import 'dart:async';

import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';

import '../../../../../../shared/components/icon_notification/icon_notification_widget.dart';
import '../../../../../../shared/helpers/consts.dart';
import '../../../../../../shared/helpers/custom_colors.dart';
import '../../domain/entity/tab_menu_entity.dart';
import 'startSup_controller.dart';

class StartSupPage extends StatefulWidget {
  final String title;
  const StartSupPage({Key? key, this.title = 'StartSupPage'}) : super(key: key);
  @override
  StartSupPageState createState() => StartSupPageState();
}

class StartSupPageState extends State<StartSupPage>
    with SingleTickerProviderStateMixin {
  /*final iconList = <IconData>[Feather.search, Feather.home, Feather.menu];*/
  var controller = Modular.get<StartSupController>();

  final iconList = <IconData>[
    Icons.home,
    Icons.search,
    Icons.construction_outlined,
    Icons.notifications_none_outlined,
    Icons.menu
  ];
  //var modules = [HomeSupModule(), SearchModule(), FavoriteModule(), MenuModule()];

  late AnimationController _animationController;
  Animation<double>? animation;
  late CurvedAnimation curve;
  late Timer _timer;

  @override
  void initState() {
    setCountNotification();

    var time = timeNotification;

    _timer = Timer.periodic(Duration(seconds: time), (t) {
      setCountNotification();
    });

    _animationController = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );
    curve = CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.5,
        1.0,
        curve: Curves.fastOutSlowIn,
      ),
    );
    animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(curve);

    Future.delayed(
      Duration(seconds: 1),
      () => _animationController.forward(),
    );
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    _animationController.dispose();
    super.dispose();
  }

  void setCountNotification() {
    controller
        .getCountNotifications()
        .then((value) => controller.setNotifyCount(value));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        floatingActionButton: ScaleTransition(
            scale: animation!,
            child: ScopedBuilder(
                store: controller.store,
                onState: (_, state) {
                  var tabMenu = state as TabMenuEntity;
                  var tabIndex = tabMenu.index;

                  return FloatingActionButton(
                    elevation: 8,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.home,
                        size: 30,
                        color: tabIndex == 0
                            ? CustomColors.primary
                            : CustomColors.graniteGray),
                    onPressed: () {
                      _animationController.reset();
                      _animationController.forward();
                      //controller.tabController.changeModule(0);
                      controller.setCurrentTabIndex(0);
                      Modular.to.navigate('/startSup/homeSup');
                    },
                  );
                })),
        floatingActionButtonLocation: FloatingActionButtonLocation.startDocked,
        bottomNavigationBar: ScopedBuilder(
            store: controller.store,
            onState: (_, state) {
              var tabMenu = state as TabMenuEntity;
              var tabIndex = tabMenu.index;

              return AnimatedBottomNavigationBar.builder(
                  height: 45,
                  itemCount: iconList.length,
                  tabBuilder: (index, isActive) {
                    var color = isActive
                        ? CustomColors.primary
                        : CustomColors.graniteGray;
                    if (index == 0) {
                      return SizedBox(width: 50);
                    } else if (index == 3 && controller.getNotifyCount() > 0) {
                      return IconNotificationWidget(
                          counter: controller.getNotifyCount(),
                          active: isActive);
                    } else {
                      return Icon(
                        iconList[index],
                        size: 27,
                        color: color,
                      );
                    }
                  },
                  gapWidth: 12,
                  elevation: 1,
                  backgroundColor: Colors.white,
                  activeIndex: tabIndex,
                  splashColor: Colors.white,
                  notchAndCornersAnimation: animation,
                  splashSpeedInMilliseconds: 300,
                  notchSmoothness: NotchSmoothness.defaultEdge,
                  notchMargin: 6,
                  gapLocation: GapLocation.end,
                  //leftCornerRadius: 28,
                  //rightCornerRadius: 28,
                  onTap: (index) {
                    controller.setCurrentTabIndex(index);
                    if (index == 0) {
                      Modular.to.navigate('/startSup/homeSup');
                    } else if (index == 1) {
                      Modular.to.navigate('/startSup/partnershipSup');
                    } else if (index == 2) {
                      Modular.to.navigate('/startSup/myReferenceSup');
                    } else if (index == 3) {
                      Modular.to.navigate('/startSup/notificationSup');
                    } else if (index == 4) {
                      Modular.to.navigate('/startSup/menuSup');
                    }
                  });
            }),
        body: RouterOutlet());
  }
}

/*
@override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RouterOutlet(),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (id) {
          if (id == 0) {
            Modular.to.navigate('/start/home');
          } else if (id == 1) {
            Modular.to.navigate('/start/product');
          } else if (id == 2) {
            Modular.to.navigate('/start/config');
          }
        },
        currentIndex: currentIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.control_camera),
            label: 'product',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Config',
          ),
        ],
      ),
    );
  }*/