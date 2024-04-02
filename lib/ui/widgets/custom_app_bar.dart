import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Icon? iconActionBtn;
  final VoidCallback? onPressed;
  const CustomAppBar({
    super.key,
    required this.title,
    this.iconActionBtn,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: const TextStyle(fontSize: 18),
      ),
      surfaceTintColor: Colors.transparent,
      centerTitle: true,
      actions: iconActionBtn != null
          ? [
              IconButton(
                onPressed: onPressed,
                icon: iconActionBtn!,
              ),
            ]
          : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
