import 'package:flutter/material.dart';

class HeaderBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback onProfileTap;

  const HeaderBar({required this.title, required this.onProfileTap});

  @override
  Widget build(BuildContext context) => AppBar(
    title: Text(title),
    actions: [IconButton(icon: Icon(Icons.account_circle), onPressed: onProfileTap)],
  );

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}