// import 'package:avalon_app/core/config/responsive/responsive_class.dart';
// import 'package:avalon_app/core/config/router/app_routes_assets.dart';
// import 'package:flutter/material.dart';
// import 'package:pretty_qr_code/pretty_qr_code.dart';

// class UserQr extends StatefulWidget {
//   const UserQr({
//     super.key,
//     required this.code,
//   });

//   final String code;

//   @override
//   State<UserQr> createState() => _UserQrState();
// }

// class _UserQrState extends State<UserQr> {
//   @protected
//   late QrImage qrImage;

//   @override
//   void initState() {
//     super.initState();

//     final qrCode = QrCode(
//       6,
//       QrErrorCorrectLevel.H,
//     )..addData('lorem ipsum dolor sit amet');

//     qrImage = QrImage(qrCode);
//   }

//   @override
//   Widget build(BuildContext context) {
//     final responsive = ResponsiveCustom.of(context);

//     return Container(
//         height: responsive.hp(30),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(10),
//           border: Border.all(
//             color: Colors.grey.shade300,
//             width: 1,
//           ),
//           color: Colors.white,
//         ),
//         padding: const EdgeInsets.all(8),
//         child: PrettyQrView(
//           qrImage: qrImage,
//           decoration: const PrettyQrDecoration(
//             image: PrettyQrDecorationImage(
//               image: AssetImage(AppAssets.iconLogo),
//             ),
//           ),
//         ));
//   }
// }
