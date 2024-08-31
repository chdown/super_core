import 'package:demo/generated/assets.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

/// @author : ch
/// @date 2024-02-04 16:25:14
/// @description 加载中
///
class LoadingView extends StatelessWidget {
  const LoadingView({Key? key, required this.msg}) : super(key: key);

  ///loading msg
  final String msg;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        //loading animation
        Lottie.asset(Assets.lottieLoading, height: 60),
        //msg
        Container(
          margin: const EdgeInsets.only(top: 20),
          child: Text(
            msg,
            style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
          ),
        ),
      ]),
    );
  }
}
