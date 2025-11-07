import 'package:flutter/material.dart';
import 'package:super_core/super_core.dart';

import 'pages/home_page.dart';
import 'services/api_service.dart';

void main() {
  // 配置日志
  LogUtil.configure(printer: SuperPrettyPrinter.defaultConfig);

  // 初始化 API 服务
  ApiService.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Super Core 测试示例',
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue), useMaterial3: true),
      home: const HomePage(),
    );
  }
}
