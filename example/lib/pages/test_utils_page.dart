import 'package:flutter/material.dart';
import 'package:super_core/super_core.dart';

/// 工具类测试页
class TestUtilsPage extends StatefulWidget {
  const TestUtilsPage({super.key});

  @override
  State<TestUtilsPage> createState() => _TestUtilsPageState();
}

class _TestUtilsPageState extends State<TestUtilsPage> {
  final List<String> _results = [];
  final ScrollController _scrollController = ScrollController();

  void _addResult(String result) {
    // 输出到控制台
    print(result);

    setState(() {
      _results.add(result);
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(_scrollController.position.maxScrollExtent, duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
      }
    });
  }

  void _testDateUtil() {
    _addResult('=== DateUtil 全面测试 ===');
    _addResult('');

    // 1. 基础功能测试
    _addResult('【1. 基础功能】');
    _addResult('当前日期: ${DateUtil.getNowDateStr()}');
    _addResult('当前时间: ${DateUtil.getNowDateStr(format: DateEnum.normYmdHms)}');
    _addResult('当前UTC: ${DateUtil.getNowDateStrUtc()}');
    final today = DateUtil.getNowTime(format: DateEnum.normYmd);
    _addResult('今天00:00:00: $today');
    _addResult('');

    // 2. DateTime转字符串
    _addResult('【2. DateTime转字符串】');
    final now = DateTime.now();
    _addResult('标准格式: ${DateUtil.dateToStr(now, format: DateEnum.normYmdHms)}');
    _addResult('中文格式: ${DateUtil.dateToStr(now, format: DateEnum.chineseYmdHms)}');
    _addResult('ISO格式: ${DateUtil.dateToStr(now, format: DateEnum.iso8601)}');
    _addResult('紧凑格式: ${DateUtil.dateToStr(now, format: DateEnum.compactYmdHms)}');
    _addResult('');

    // 3. 字符串转DateTime（标准格式）
    _addResult('【3. 字符串转DateTime - 标准格式】');
    final testCases1 = [
      '2025-10-31 18:30:00',
      '2025/10/31 18:30:00',
      '2025.10.31 18:30:00',
      '2025-10-31',
      '2025/10/31',
      '2025.10.31',
      '2025-10',
      '2025/10',
      '2025.10',
    ];
    for (var testCase in testCases1) {
      final result = DateUtil.getTime(testCase);
      _addResult('$testCase => ${result != null ? DateUtil.dateToStr(result, format: DateEnum.normYmdHms) : "null"}');
    }
    _addResult('');

    // 4. 字符串转DateTime（中文格式）
    _addResult('【4. 字符串转DateTime - 中文格式】');
    final testCases2 = ['2025年10月31日 18时30分00秒', '2025年10月31日', '2025年10月', '10月31日'];
    for (var testCase in testCases2) {
      final result = DateUtil.getTime(testCase);
      _addResult('$testCase => ${result != null ? "✓" : "✗"}');
    }
    _addResult('');

    // 5. ISO 8601 格式测试
    _addResult('【5. ISO 8601 格式】');
    final testCases3 = [
      '2025-10-31T18:30:00Z',
      '2025-10-31T18:30:00',
      '2025-10-31T18:30:00.123Z',
      '2025-10-31T18:30:00.123',
      '2025-10-31T18:30:00+08:00',
      '2025-10-31T18:30:00.123+08:00',
    ];
    for (var testCase in testCases3) {
      final result = DateUtil.getTime(testCase);
      _addResult('$testCase => ${result != null ? "✓" : "✗"}');
    }
    _addResult('');

    // 6. 时间戳测试
    _addResult('【6. 时间戳测试】');
    final timestamp10 = (DateTime.now().millisecondsSinceEpoch / 1000).floor();
    final timestamp13 = DateTime.now().millisecondsSinceEpoch;
    _addResult('10位时间戳: $timestamp10');
    final time10 = DateUtil.getTime(timestamp10.toString());
    _addResult('解析结果: ${time10 != null ? DateUtil.dateToStr(time10, format: DateEnum.normYmdHms) : "null"}');
    _addResult('13位时间戳: $timestamp13');
    final time13 = DateUtil.getTime(timestamp13.toString());
    _addResult('解析结果: ${time13 != null ? DateUtil.dateToStr(time13, format: DateEnum.normYmdHms) : "null"}');
    _addResult('');

    // 7. 格式转换测试
    _addResult('【7. 格式转换】');
    final testStr = '2025-10-31 18:30:00';
    _addResult('原始: $testStr');
    _addResult('转中文: ${DateUtil.dateStrToStr(testStr, destFormat: DateEnum.chineseYmdHms)}');
    _addResult('转紧凑: ${DateUtil.dateStrToStr(testStr, destFormat: DateEnum.compactYmdHms)}');
    _addResult('只保留日期: ${DateUtil.dateStrToStr(testStr, destFormat: DateEnum.normYmd)}');
    _addResult('');

    // 8. UTC时间处理
    _addResult('【8. UTC时间处理】');
    final localTime = DateTime.now();
    final utcTime = DateUtil.toUtc(localTime);
    _addResult('本地时间: ${DateUtil.dateToStr(localTime, format: DateEnum.normYmdHms)}');
    _addResult('UTC时间: ${DateUtil.utcToStr(utcTime)}');
    _addResult('转回本地: ${DateUtil.dateToStr(DateUtil.toLocal(utcTime), format: DateEnum.normYmdHms)}');
    _addResult('');

    // 9. 边界情况测试
    _addResult('【9. 边界情况】');
    _addResult('null: ${DateUtil.getTime(null) ?? "null"}');
    _addResult('空字符串: ${DateUtil.getTime("") ?? "null"}');
    _addResult('无效格式: ${DateUtil.getTime("abc123") ?? "null"}');
    _addResult('');

    // 10. 12小时制测试
    _addResult('【10. 12小时制】');
    final testCases4 = ['6:30:00 PM', '6:30 AM'];
    for (var testCase in testCases4) {
      final result = DateUtil.getTime(testCase);
      _addResult('$testCase => ${result != null ? "✓" : "✗"}');
    }
    _addResult('');

    // 11. 纯时间格式测试
    _addResult('【11. 纯时间格式】');
    final testCases5 = ['18:30:00', '18:30', '18时30分', '18时30分00秒'];
    for (var testCase in testCases5) {
      final result = DateUtil.getTime(testCase);
      _addResult('$testCase => ${result != null ? "✓" : "✗"}');
    }
    _addResult('');

    // 12. 带毫秒的时间格式
    _addResult('【12. 带毫秒时间】');
    final testCases6 = ['18:30:00.123', '18时30分00秒123毫秒'];
    for (var testCase in testCases6) {
      final result = DateUtil.getTime(testCase);
      _addResult('$testCase => ${result != null ? "✓" : "✗"}');
    }
    _addResult('');

    // 13. 月日格式测试
    _addResult('【13. 月日格式】');
    final testCases7 = ['10-31', '10/31', '10.31', '10月31日'];
    for (var testCase in testCases7) {
      final result = DateUtil.getTime(testCase);
      _addResult('$testCase => ${result != null ? "✓" : "✗"}');
    }
    _addResult('');

    // 14. 单位数日期时间
    _addResult('【14. 单位数日期时间】');
    final testCases8 = ['2025-1-1', '2025-1-1 8:5:3', '2025/1/1', '2025.1.1'];
    for (var testCase in testCases8) {
      final result = DateUtil.getTime(testCase);
      _addResult('$testCase => ${result != null ? DateUtil.dateToStr(result, format: DateEnum.normYmdHms) : "null"}');
    }
    _addResult('');

    // 15. dateToDate 方法（精度截断）
    _addResult('【15. dateToDate 精度截断】');
    final testDate = DateTime(2025, 10, 31, 18, 30, 45, 999);
    _addResult('原始时间: ${DateUtil.dateToStr(testDate, format: DateEnum.normYmdHms)}');
    final truncatedDay = DateUtil.dateToDate(testDate, destFormat: DateEnum.normYmd);
    _addResult('截断到天: ${truncatedDay != null ? DateUtil.dateToStr(truncatedDay, format: DateEnum.normYmdHms) : "null"}');
    final truncatedMinute = DateUtil.dateToDate(testDate, destFormat: DateEnum.normYmdHm);
    _addResult('截断到分钟: ${truncatedMinute != null ? DateUtil.dateToStr(truncatedMinute, format: DateEnum.normYmdHms) : "null"}');
    _addResult('');

    // 16. null 值处理测试
    _addResult('【16. null 值处理】');
    _addResult('dateToStr(null): "${DateUtil.dateToStr(null)}"');
    _addResult('utcToStr(null): "${DateUtil.utcToStr(null)}"');
    _addResult('');

    // 17. 历史日期（负数时间戳）
    _addResult('【17. 历史日期】');
    final historicalTimestamp = -2208988800; // 1900-01-01
    final historicalDate = DateUtil.getTime(historicalTimestamp.toString());
    _addResult('1900年时间戳: $historicalTimestamp');
    _addResult('解析结果: ${historicalDate != null ? DateUtil.dateToStr(historicalDate, format: DateEnum.normYmdHms) : "null"}');
    _addResult('');

    // 18. 格式转换（多源格式）
    _addResult('【18. 格式转换（多源格式）】');
    final srcFormats = [
      {'src': '2025/10/31 18:30:00', 'srcFormat': DateEnum.slashYmdHms},
      {'src': '20251031183000', 'srcFormat': DateEnum.compactYmdHms},
      {'src': '2025年10月31日 18时30分00秒', 'srcFormat': DateEnum.chineseYmdHms},
    ];
    for (var item in srcFormats) {
      final converted = DateUtil.dateStrToStr(item['src'] as String, srcFormat: item['srcFormat'] as String, destFormat: DateEnum.normYmdHms);
      _addResult('${item['src']} => $converted');
    }

    _addResult('');
    _addResult('=== 测试完成 ===');
    LogUtil.i('DateUtil 测试完成');
  }

  void _testNumUtil() {
    _addResult('=== NumUtil 测试 ===');

    // 数字计算示例
    _addResult('加法: ${NumUtil.add(1.2, 2.3)} (精确计算)');
    _addResult('减法: ${NumUtil.subtract(5.5, 2.2)}');
    _addResult('乘法: ${NumUtil.multiply(3.3, 2)}');
    _addResult('除法: ${NumUtil.divide(10, 3)}');

    // 格式化
    final num = NumUtil.getNumByValueDouble(1234567.89, 2);
    _addResult('保留2位小数: $num');

    // 比较
    _addResult('3.14 > 2.0: ${NumUtil.greaterThan(3.14, 2.0)}');
    _addResult('1.5 < 2.0: ${NumUtil.lessThan(1.5, 2.0)}');

    _addResult('');

    LogUtil.i('NumUtil 测试完成');
  }

  void _testObjUtil() {
    _addResult('=== ObjUtil 测试 ===');

    // 测试 isEmpty
    _addResult('null.isEmpty: ${ObjUtil.isEmpty(null)}');
    _addResult('"".isEmpty: ${ObjUtil.isEmpty("")}');
    _addResult('[].isEmpty: ${ObjUtil.isEmpty([])}');
    _addResult('{}.isEmpty: ${ObjUtil.isEmpty({})}');
    _addResult('"hello".isEmpty: ${ObjUtil.isEmpty("hello")}');

    _addResult('');

    // 测试 isNotEmpty
    _addResult('null.isNotEmpty: ${ObjUtil.isNotEmpty(null)}');
    _addResult('"hello".isNotEmpty: ${ObjUtil.isNotEmpty("hello")}');
    _addResult('[1,2,3].isNotEmpty: ${ObjUtil.isNotEmpty([1, 2, 3])}');

    _addResult('');

    LogUtil.i('ObjUtil 测试完成');
  }

  void _testPlatUtil() {
    _addResult('=== PlatUtil 测试 ===');

    _addResult('是否为 Web: ${PlatUtil.isWeb}');
    _addResult('是否为 Android: ${PlatUtil.isAndroid}');
    _addResult('是否为 iOS: ${PlatUtil.isIOS}');
    _addResult('是否为 Windows: ${PlatUtil.isWindows}');
    _addResult('是否为 MacOS: ${PlatUtil.isMacOS}');
    _addResult('是否为 Linux: ${PlatUtil.isLinux}');
    _addResult('是否为移动端: ${PlatUtil.isMobile}');
    _addResult('是否为桌面端: ${PlatUtil.isDesktop}');

    _addResult('');

    LogUtil.i('PlatUtil 测试完成');
  }

  void _clearResults() {
    setState(() => _results.clear());
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('工具类测试'),
        actions: [IconButton(icon: const Icon(Icons.clear_all), tooltip: '清空结果', onPressed: _clearResults)],
      ),
      body: Column(
        children: [
          // 测试按钮
          Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text('工具类测试', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    ElevatedButton.icon(onPressed: _testDateUtil, icon: const Icon(Icons.calendar_today, size: 18), label: const Text('DateUtil')),
                    ElevatedButton.icon(onPressed: _testNumUtil, icon: const Icon(Icons.numbers, size: 18), label: const Text('NumUtil')),
                    ElevatedButton.icon(onPressed: _testObjUtil, icon: const Icon(Icons.data_object, size: 18), label: const Text('ObjUtil')),
                    ElevatedButton.icon(onPressed: _testPlatUtil, icon: const Icon(Icons.devices, size: 18), label: const Text('PlatUtil')),
                  ],
                ),
              ],
            ),
          ),
          const Divider(),

          // 测试结果
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('测试结果', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: _results.isEmpty
                          ? Center(
                              child: Text('点击上方按钮进行测试', style: TextStyle(color: Colors.grey.shade600, fontSize: 14)),
                            )
                          : ListView.builder(
                              controller: _scrollController,
                              padding: const EdgeInsets.all(12),
                              itemCount: _results.length,
                              itemBuilder: (context, index) {
                                final result = _results[index];
                                final isTitle = result.startsWith('===');

                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 4),
                                  child: Text(
                                    result,
                                    style: TextStyle(
                                      fontFamily: 'monospace',
                                      fontSize: isTitle ? 14 : 12,
                                      fontWeight: isTitle ? FontWeight.bold : FontWeight.normal,
                                      color: isTitle ? Colors.blue.shade700 : Colors.black87,
                                    ),
                                  ),
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
