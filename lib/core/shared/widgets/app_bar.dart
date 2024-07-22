import 'package:bt_recipe_management_task/core/constants/app_color.dart';
import 'package:flutter/material.dart';

AppBar appBar(String? title) {
  return AppBar(
    backgroundColor: AppColor.screenBackground,
    title: Text(title ?? ""),
    elevation: 1,
    shadowColor: Colors.grey.shade300, // Adjust shadow color
  );
}