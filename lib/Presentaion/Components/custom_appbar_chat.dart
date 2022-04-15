import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

PreferredSizeWidget customeAppBarChat({
  required BuildContext context,
  required String title,
  List<Widget>? action,
  required String image,
}) {
  return AppBar(
    title: Row(
      children: [
        CircleAvatar(
          radius: 24.0,
          backgroundImage: NetworkImage(image),
        ),
        SizedBox(
          width: 2.0.w,
        ),
        Text(
          title,
          style: Theme.of(context).textTheme.headline4,
        ),
      ],
    ),
    leading: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: const Icon(Icons.arrow_back)),
    actions: action,
  );
}
