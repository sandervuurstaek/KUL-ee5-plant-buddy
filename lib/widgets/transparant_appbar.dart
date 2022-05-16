import 'package:adaptive_navigation/adaptive_navigation.dart';
import 'package:flutter/material.dart';
import 'package:plantbuddy/widgets/text.dart';

/// Custom appbar with a transparent background
class TransparantAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  const TransparantAppbar({Key? key, required this.title, this.actions,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AdaptiveAppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Header3Text(title,textStyle: const TextStyle(fontWeight: FontWeight.bold,)),
      centerTitle: true,
      actions: actions,
      titleTextStyle: const TextStyle(color: Colors.black),
      iconThemeData: const IconThemeData(color: Colors.black),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
