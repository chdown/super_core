import 'package:flutter/material.dart';

import 'test_article_page.dart';
import 'test_extensions_page.dart';
import 'test_log_page.dart';
import 'test_search_page.dart';
import 'test_utils_page.dart';

/// 主页 - 测试用例列表
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Super Core 测试示例'), backgroundColor: Theme.of(context).colorScheme.inversePrimary),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildHeader(),
          const SizedBox(height: 24),
          _buildTestCard(
            context,
            title: '文章列表测试',
            description: '测试 HTTP 请求、列表加载、分页等功能',
            icon: Icons.article,
            color: Colors.blue,
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const TestArticlePage())),
          ),
          const SizedBox(height: 12),
          _buildTestCard(
            context,
            title: '搜索功能测试',
            description: '测试 HTTP POST 请求、搜索、空状态等',
            icon: Icons.search,
            color: Colors.green,
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const TestSearchPage())),
          ),
          const SizedBox(height: 12),
          _buildTestCard(
            context,
            title: '日志功能测试',
            description: '测试 SuperPrettyPrinter 日志格式化',
            icon: Icons.bug_report,
            color: Colors.orange,
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const TestLogPage())),
          ),
          const SizedBox(height: 12),
          _buildTestCard(
            context,
            title: '扩展方法测试',
            description: '测试各种扩展方法（String、List、Widget等）',
            icon: Icons.extension,
            color: Colors.purple,
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const TestExtensionsPage())),
          ),
          const SizedBox(height: 12),
          _buildTestCard(
            context,
            title: '工具类测试',
            description: '测试日期、数字、对象等工具类',
            icon: Icons.build,
            color: Colors.teal,
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const TestUtilsPage())),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Card(
      elevation: 0,
      color: Colors.blue.shade50,
      child: const Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('🚀 Super Core', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text('Flutter 核心工具库测试示例\n使用 WanAndroid API 进行功能演示', style: TextStyle(fontSize: 14, color: Colors.black54)),
          ],
        ),
      ),
    );
  }

  Widget _buildTestCard(
    BuildContext context, {
    required String title,
    required String description,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 2,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
                child: Icon(icon, color: color, size: 32),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    Text(description, style: TextStyle(fontSize: 13, color: Colors.grey.shade600)),
                  ],
                ),
              ),
              Icon(Icons.chevron_right, color: Colors.grey.shade400),
            ],
          ),
        ),
      ),
    );
  }
}
