import 'package:flutter/material.dart';
import 'package:super_core/super_core.dart';
import 'package:super_ui/super_ui.dart';

/// 空页面
class LoadCustomSvg extends StatelessWidget with SuperLoadPage {
  final String svgPath;
  final String text;
  final Color bgColor;

  LoadCustomSvg(this.svgPath, this.text, {super.key, this.bgColor = Colors.white});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: bgColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          Stack(
            children: [
              Container(
                padding: EdgeInsets.only(bottom: onTap != null ? 25 : 0),
                child: SuperIcon.svg(
                  svgPath,
                  width: 200,
                  height: 200,
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Column(
                  children: [
                    Text(
                      text,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    const SizedBox(height: 15),
                    Visibility(
                      visible: onTap != null,
                      child: SuperButton(
                        borderRadius: 40,
                        borderWidth: 0.5,
                        paddingHorizontal: 20,
                        type: ButtonType.outlinedPrimary,
                        onTap: () => onTap?.call(params),
                        text: params.isNotEmptyOrNull && params!.containsKey(svgPath) ? params![svgPath]! : "刷新",
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
