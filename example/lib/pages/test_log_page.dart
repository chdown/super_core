import 'package:flutter/material.dart';
import 'package:super_core/super_core.dart';

/// 日志功能测试页
class TestLogPage extends StatefulWidget {
  const TestLogPage({super.key});

  @override
  State<TestLogPage> createState() => _TestLogPageState();
}

class _TestLogPageState extends State<TestLogPage> {
  final List<String> _logRecords = [];
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _addRecord(String message) {
    setState(() {
      _logRecords.add('${DateTime.now().toString().substring(11, 23)} - $message');
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(_scrollController.position.maxScrollExtent, duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
      }
    });
  }

  void _testSingleLine() {
    _addRecord('测试单行日志');
    LogUtil.d('这是一条调试信息');
    LogUtil.i('这是一条普通信息');
    LogUtil.w('这是一条警告信息');
    LogUtil.e('这是一条错误信息');
  }

  void _testMultiLine() {
    _addRecord('测试多行日志');
    LogUtil.i('''用户登录成功：
用户名：zhangsan
登录时间：${DateTime.now()}
IP 地址：192.168.1.100
设备信息：Flutter App''');
  }

  void _testJson() {
    _addRecord('测试 JSON 日志');

    final userData = {
      'id': 12345,
      'name': '张三',
      'email': 'zhangsan@example.com',
      'age': 28,
      'profile': {
        'city': '北京',
        'hobbies': ['编程', '阅读', '旅行'],
        'settings': {'theme': 'dark', 'notifications': true},
      },
    };

    LogUtil.d(userData);
  }

  void _testError() {
    _addRecord('测试错误日志（带堆栈）');

    try {
      throw Exception('这是一个测试异常');
    } catch (e, s) {
      LogUtil.e('捕获到异常', error: e, stackTrace: s);
    }
  }

  void _testLongText() {
    _addRecord('测试长文本日志');

    const longText = '''
这是一段很长的日志文本，用于测试日志输出的格式化效果。
SuperPrettyPrinter 会自动判断：
- 如果文本长度小于阈值（默认 160 字符），且没有换行符，则使用单行格式
- 如果文本包含换行符或长度超过阈值，则使用多行格式，并在顶部边框嵌入时间

单行格式：[HH:MM:SS] 🐛 日志内容
多行格式：
┌─────────[HH:MM:SS]─────────
│ 🐛 日志内容
│   第二行
│   第三行
└────────────────────────────

这样可以保持日志输出简洁清晰，同时保留完整的时间信息。
''';

    LogUtil.i(longText);
  }

  void _testEmpty() {
    _addRecord('测试空数据过滤');

    final emptyData = {'name': '测试', 'value': null, 'list': [], 'map': {}, 'text': ''};

    LogUtil.d('包含空数据的对象：');
    LogUtil.d(emptyData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('日志功能测试'),
        actions: [
          IconButton(
            icon: const Icon(Icons.clear_all),
            tooltip: '清空记录',
            onPressed: () {
              setState(() => _logRecords.clear());
              _addRecord('记录已清空');
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // 测试按钮
          Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text('日志测试', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    ElevatedButton(onPressed: _testSingleLine, child: const Text('单行日志')),
                    ElevatedButton(onPressed: _testMultiLine, child: const Text('多行日志')),
                    ElevatedButton(onPressed: _testJson, child: const Text('JSON 日志')),
                    ElevatedButton(onPressed: _testError, child: const Text('错误日志')),
                    ElevatedButton(onPressed: _testLongText, child: const Text('长文本')),
                    ElevatedButton(onPressed: _testEmpty, child: const Text('空数据')),
                  ],
                ),
              ],
            ),
          ),
          const Divider(),

          // 提示信息
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Card(
              color: Colors.orange.shade50,
              child: const Padding(
                padding: EdgeInsets.all(12),
                child: Row(
                  children: [
                    Icon(Icons.info_outline, color: Colors.orange, size: 20),
                    SizedBox(width: 8),
                    Expanded(child: Text('请查看控制台（Debug Console）查看格式化后的日志输出', style: TextStyle(fontSize: 12))),
                  ],
                ),
              ),
            ),
          ),

          // 操作记录
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('操作记录', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: _logRecords.isEmpty
                          ? Center(
                              child: Text('点击上方按钮进行测试', style: TextStyle(color: Colors.grey.shade600, fontSize: 14)),
                            )
                          : ListView.builder(
                              controller: _scrollController,
                              itemCount: _logRecords.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                  child: Text(_logRecords[index], style: const TextStyle(fontFamily: 'monospace', fontSize: 12)),
                                );
                              },
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
