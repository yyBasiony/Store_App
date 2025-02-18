import 'package:flutter/material.dart';

class DrawerItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final Widget screen;

  const DrawerItem(
      {super.key, required this.icon, required this.title, required this.screen});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xff005B50), size: 30),
      title: Text(title),
      onTap: () {
        Navigator.pop(context);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => screen));
      },
    );
  }
}
