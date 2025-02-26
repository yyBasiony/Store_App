import 'package:flutter/material.dart';

import '../../resources/app_assets.dart';

class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return const CircleAvatar(
      radius: 75,
      backgroundColor: Color(0xff005B50),
      child: CircleAvatar(radius: 70, backgroundImage: AssetImage(AppAssets.profile)),
    );
  }
}
