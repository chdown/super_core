import 'package:demo/generated/assets.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:super_ui/super_ui.dart';

/// 空页面
class LoadLoading extends StatelessWidget with SuperLoadPage {
  LoadLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 50),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // CircularProgressIndicator(),
          Lottie.asset(Assets.lottieLoading, height: 120),
          const SizedBox(height: 20),
          const Text(
            "正在加载中...",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
