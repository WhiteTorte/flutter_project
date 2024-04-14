import 'package:flutter/material.dart';

class SnackBars {
  static void show({
    required BuildContext context,
    required SnackBarStatus status,
    required String message,
  }) {
    Color backgroundColor;
    IconData icon;
    
    // 상태에 따라 스낵바의 배경색과 아이콘을 설정합니다.
    switch (status) {
      case SnackBarStatus.success:
        backgroundColor = Colors.green;
        icon = Icons.check;
        break;
      case SnackBarStatus.error:
        backgroundColor = Colors.red;
        icon = Icons.error;
        break;
      case SnackBarStatus.warning:
        backgroundColor = Colors.orange;
        icon = Icons.warning;
        break;
    }

    // 스낵바를 표시하기 전에 mounted를 확인합니다.
    // ignore: unnecessary_null_comparison
    if (context != null && ScaffoldMessenger.of(context).mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(icon),
              const SizedBox(width: 8),
              Text(message),
            ],
          ),
          backgroundColor: backgroundColor,
        ),
      );
    }
  }
}

// 스낵바의 상태를 정의합니다.
enum SnackBarStatus {
  success,
  error,
  warning,
}