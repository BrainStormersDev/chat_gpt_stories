// import '../../utils/app_color.dart';
// import 'package:flutter/material.dart';
//
//
//
// class BaseScaffold extends StatefulWidget {
//   final Widget body;
//   final Color backgroundColor;
//   final Color appBarBgColor;
//   final String appBarHeading;
//   final bool internetFunction;
//   final bool notificationIcon;
//   final bool isProfileImage;
//   final bool isAppBarShow;
//   final bool isBackArrow;
//   final bool isAvoidBottomInset;
//   final double toolbarHeight;
//   final int bottomBarIndex;
//
//   const BaseScaffold({
//     required this.body,
//     required this.backgroundColor,
//     this.internetFunction = true,
//     this.isAvoidBottomInset = true,
//     required this.appBarHeading,
//     this.bottomBarIndex = 2,
//     this.isBackArrow = false,
//     this.isAppBarShow = true,
//     this.appBarBgColor = AppColors.kPageBG,
//     this.toolbarHeight = 55,
//     this.notificationIcon = true,
//     this.isProfileImage = true,
//   });
//
//   @override
//   _BaseScaffoldState createState() => _BaseScaffoldState();
// }
//
// class _BaseScaffoldState extends State<BaseScaffold> {
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   // @override
//   // void dispose() {
//   //   subscription.cancel();
//   //   super.dispose();
//   // }
//
//   final GlobalKey<ScaffoldState> _drawerscaffoldkey =
//   GlobalKey<ScaffoldState>();
//
//   @override
//   Widget build(BuildContext context) {
//     AppSizes().init(context);
//     return Scaffold(
//         resizeToAvoidBottomInset: widget.isAvoidBottomInset,
//         key: _drawerscaffoldkey,
//         backgroundColor: widget.backgroundColor,
//         appBar: AppBar(
//           toolbarHeight: widget.toolbarHeight,
//           elevation: 0,
//           backgroundColor: widget.appBarBgColor,
//           leading: Container(),
//           flexibleSpace: Container(
//             height: 100,
//             padding: EdgeInsets.symmetric(horizontal: 10),
//             decoration: BoxDecoration(
//               image: DecorationImage(
//                 image: AssetImage(
//                   "assets/images/app_bar_bg.png",
//                 ),
//                 fit: BoxFit.fill,
//               ),
//             ),
//             child: Stack(
//               clipBehavior: Clip.none,
//               children: [
//                 widget.isBackArrow
//                     ? Align(
//                   alignment: Alignment.centerLeft,
//                   child: IconButton(
//                     onPressed: () {
//                       Navigator.pop(context);
//                     },
//                     icon: Icon(
//                       Icons.arrow_back,
//                       color: AppColors.kWhite,
//                     ),
//                   ),
//                 )
//                     : Align(
//                   alignment: Alignment.centerLeft,
//                   child: IconButton(
//                     onPressed: () {
//                       _drawerscaffoldkey.currentState!.openDrawer();
//                     },
//                     icon: Icon(
//                       Icons.menu,
//                       color: AppColors.kWhite,
//                     ),
//                   ),
//                 ),
//                 Align(
//                     alignment: Alignment.center,
//                     child: Text(
//                       widget.appBarHeading,
//                       style: TextStyle(
//                           color: AppColors.kWhite,
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold),
//                     )),
//                 Align(
//                   alignment: Alignment.centerRight,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       if (widget.notificationIcon)
//                         InkWell(
//                           onTap: () {
//                             Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) => NotificationShow()));
//                           },
//                           child: Stack(
//                             children: <Widget>[
//                               new Icon(Icons.notifications,
//                                   size: 35, color: Colors.white),
//                               new Positioned(
//                                 right: 0,
//                                 child: new Container(
//                                   padding: EdgeInsets.all(2),
//                                   decoration: new BoxDecoration(
//                                     // color: Colors.grey,
//                                     color: Colors.red,
//                                     borderRadius: BorderRadius.circular(6),
//                                   ),
//                                   constraints: BoxConstraints(
//                                     minWidth: 12,
//                                     minHeight: 12,
//                                   ),
//                                   child: Obx(() {
//                                     return Text(
//                                       MyRepo.notificationUnReadCont.value
//                                           .toString(),
//                                       style: TextStyle(
//                                         color: Colors.white,
//                                         fontWeight: FontWeight.bold,
//                                         fontSize: 10,
//                                       ),
//                                       textAlign: TextAlign.center,
//                                     );
//                                   }),
//                                 ),
//                               )
//                             ],
//                           ),
//                         ),
//                       SizedBox(
//                         width: 5,
//                       ),
//                       if (widget.isProfileImage)
//                         InkWell(
//                           onTap: () {
//                             Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) => EditProfile()));
//                           },
//                           child: GetStorage().read(kImageID).length <= 30
//                               ? Container(
//                             width: 40,
//                             height: 40,
//                             decoration: BoxDecoration(
//                                 image: DecorationImage(
//                                     image: AssetImage(kAvatarImage),
//                                     fit: BoxFit.fill),
//                                 shape: BoxShape.circle,
//                                 // borderRadius: BorderRadius.circular(20),
//                                 border: Border.all(color: Colors.blue)),
//                           )
//                               : Container(
//                             width: 40,
//                             height: 40,
//                             decoration: BoxDecoration(
//                               // image: DecorationImage(
//                               //     image: NetworkImage(
//                               //       GetStorage().read(kImageID),
//                               //     ),
//                               //     fit: BoxFit.fill),
//                                 shape: BoxShape.circle,
//                                 // borderRadius: BorderRadius.circular(20),
//                                 border: Border.all(color: Colors.blue)),
//                             child: CachedNetworkImage(
//                                 imageUrl:  GetStorage().read(kImageID),
//                                 imageBuilder: (context, imageProvider) => Container(
//                                   decoration: BoxDecoration(
//                                     shape: BoxShape.circle,
//                                     image: DecorationImage(
//                                       image: imageProvider,
//                                       fit: BoxFit.cover,
//                                     ),
//                                   ),
//                                 ),
//                                 placeholder: (context, url) => CircularProgressIndicator(),
//                                 errorWidget: (context, url, error) => Container(
//                                   width: 40,
//                                   height: 40,
//                                   decoration: BoxDecoration(
//                                       image: DecorationImage(
//                                           image: AssetImage(kAvatarImage),
//                                           fit: BoxFit.fill),
//                                       shape: BoxShape.circle,
//                                       // borderRadius: BorderRadius.circular(20),
//                                       border: Border.all(color: Colors.blue)),
//                                 )
//                             ),
//
//                           ),
//                         ),
//                     ],
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ),
//         // appBar: appbar(context, '${widget.appBarHeading}', _drawerscaffoldkey,widget.isBackArrow),
//         drawer: CustomDrawer(),
//         body: SafeArea(
//           child: widget.body,
//         ));
//   }
// }