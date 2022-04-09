import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
          radius: 20.0.r,
          backgroundImage: NetworkImage(image),
        ),
        SizedBox(
          width: 10.0.w,
        ),
        Text(
          title,
          style: Theme.of(context).textTheme.bodyLarge,
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
