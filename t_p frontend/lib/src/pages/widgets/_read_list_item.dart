import 'package:flutter/material.dart';

class ReadListItem extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData icon;

  const ReadListItem({
    super.key,
    required this.title,
    this.subtitle,
    this.icon = Icons.description_outlined,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      subtitle: (subtitle == null || subtitle!.isEmpty)
          ? null
          : Text(subtitle!, maxLines: 2, overflow: TextOverflow.ellipsis),
    );
  }
}
