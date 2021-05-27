import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

ThemeData appTheme() => ThemeData(
      checkboxTheme: CheckboxThemeData(
        fillColor: MaterialStateProperty.resolveWith(
          (states) => states.contains(MaterialState.selected)
              ? const Color(0xFF10B981)
              : null,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        side: const BorderSide(
          width: 3,
          color: Color(0xFFA7F3D0),
        ),
        splashRadius: 0,
      ),
      textTheme: TextTheme(
        headline1: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black,
          fontSize: 60.sp,
        ),
        headline2: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 35.sp,
        ),
        headline4: TextStyle(color: Colors.black, fontSize: 25.sp),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
          style: ButtonStyle(
        side: MaterialStateProperty.all(const BorderSide()),
        backgroundColor: MaterialStateProperty.resolveWith<Color?>(
          (states) {
            if (states.contains(MaterialState.hovered)) return Colors.black;
            return Colors.white;
          },
        ),
        padding: MaterialStateProperty.all(
          EdgeInsets.symmetric(horizontal: 70.sp, vertical: 25.sp),
        ),
        foregroundColor: MaterialStateProperty.resolveWith<Color?>(
          (states) {
            if (states.contains(MaterialState.hovered)) return Colors.white;
            return Colors.black;
          },
        ),
        splashFactory: NoSplash.splashFactory,
        textStyle: MaterialStateProperty.all<TextStyle?>(TextStyle(
          fontSize: 20.sp,
          fontWeight: FontWeight.bold,
        )),
      )),
    );
