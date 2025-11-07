import 'package:flutter/material.dart';
import 'package:super_core/super_core.dart';

/// 扩展方法测试页
class TestExtensionsPage extends StatelessWidget {
  const TestExtensionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('扩展方法测试')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSection(
            title: '字符串扩展',
            icon: Icons.text_fields,
            color: Colors.blue,
            children: [
              _buildExtensionDemo('isEmpty / isNotEmpty', '''final str = "Hello";
str.isNotEmpty // true
"".isEmpty     // true'''),
            ],
          ),
          _buildSection(
            title: '列表扩展',
            icon: Icons.list,
            color: Colors.green,
            children: [
              _buildExtensionDemo('isEmpty / isNotEmpty', '''final list = [1, 2, 3];
list.isNotEmpty // true
[].isEmpty      // true'''),
            ],
          ),
          _buildSection(
            title: 'Widget 扩展 - Padding',
            icon: Icons.space_bar,
            color: Colors.purple,
            children: [
              const Text('padding 扩展示例：'),
              const SizedBox(height: 12),

              // padding 扩展示例
              Container(color: Colors.blue.shade50, child: const Text('使用 .paddingAll(12) 扩展').paddingAll(12)),
              const SizedBox(height: 8),

              Container(color: Colors.green.shade50, child: const Text('使用 .paddingHorizontal(16)').paddingHorizontal(16)),
              const SizedBox(height: 8),

              _buildExtensionDemo('代码示例', '''// 全部内边距
widget.paddingAll(16)

// 横向内边距
widget.paddingHorizontal(12)

// 纵向内边距
widget.paddingVertical(8)

// 指定边距
widget.padding(top: 10, left: 20)'''),
            ],
          ),
          _buildSection(
            title: 'Widget 扩展 - Align',
            icon: Icons.align_horizontal_center,
            color: Colors.teal,
            children: [
              const Text('align 扩展示例：'),
              const SizedBox(height: 12),

              // center 扩展示例
              Container(height: 60, color: Colors.green.shade50, child: const Text('使用 .center() 扩展').center()),
              const SizedBox(height: 8),

              Container(height: 60, color: Colors.orange.shade50, child: const Text('使用 .alignRight() 扩展').alignRight()),
              const SizedBox(height: 8),

              _buildExtensionDemo('代码示例', '''// 居中
widget.center()

// 对齐方式
widget.alignLeft()
widget.alignRight()
widget.alignTop()
widget.alignBottom()
widget.alignCenter()'''),
            ],
          ),
          _buildSection(
            title: 'Widget 扩展 - Gesture',
            icon: Icons.touch_app,
            color: Colors.orange,
            children: [
              const Text('手势扩展示例：'),
              const SizedBox(height: 12),

              // 手势扩展示例
              Container(
                padding: const EdgeInsets.all(12),
                color: Colors.orange.shade50,
                child: const Text('点击我（使用 .onTap() 扩展）').onTap(() {
                  LogUtil.i('Widget 扩展：点击事件触发');
                }),
              ),
              const SizedBox(height: 8),

              Container(
                padding: const EdgeInsets.all(12),
                color: Colors.blue.shade50,
                child: const Text('点击我（使用 .inkWell() 扩展）').inkWell(
                  onTap: () {
                    LogUtil.i('Widget 扩展：InkWell 点击事件触发');
                  },
                  borderRadius: 8,
                ),
              ),
              const SizedBox(height: 8),

              _buildExtensionDemo('代码示例', '''// 基础点击
widget.onTap(() => print('Tapped'))

// 墨水纹效果
widget.inkWell(
  onTap: () => print('Tapped'),
  borderRadius: 8,
)

// 涟漪效果
widget.ripple()

// 长按
widget.onLongPress(() => print('Long pressed'))'''),
            ],
          ),
          _buildSection(
            title: 'SizedBox 扩展',
            icon: Icons.height,
            color: Colors.red,
            children: [
              const Text('快速创建间距：'),
              const SizedBox(height: 8),
              Row(
                children: [
                  Container(width: 50, height: 50, color: Colors.blue),
                  16.hSizeBox, // 宽度间距
                  Container(width: 50, height: 50, color: Colors.green),
                  16.hSizeBox,
                  Container(width: 50, height: 50, color: Colors.orange),
                ],
              ),
              12.vSizeBox, // 高度间距
              _buildExtensionDemo('代码示例', '''// 水平间距
16.hSizeBox  // SizedBox(width: 16)

// 垂直间距
12.vSizeBox  // SizedBox(height: 12)'''),
            ],
          ),
          _buildSection(
            title: 'Function 扩展',
            icon: Icons.functions,
            color: Colors.indigo,
            children: [
              ElevatedButton(
                onPressed: () {
                  // 使用 let 扩展
                  "Hello World"
                      .let((value) {
                        LogUtil.i('let 扩展: $value');
                        return value.length;
                      })
                      .let((length) {
                        LogUtil.i('字符串长度: $length');
                      });

                  // 使用 apply 扩展
                  final buffer = StringBuffer().apply((sb) {
                    sb.writeln('Line 1');
                    sb.writeln('Line 2');
                    sb.writeln('Line 3');
                  }).toString();
                  LogUtil.i('apply 扩展结果:\n$buffer');
                },
                child: const Text('测试 let / apply 扩展'),
              ),
              const SizedBox(height: 8),
              _buildExtensionDemo('代码示例', '''// let - 转换并返回结果
"Hello".let((s) => s.length) // 5

// apply - 执行操作并返回自身
StringBuffer().apply((sb) {
  sb.writeln('Line 1');
  sb.writeln('Line 2');
})

// run - 执行操作不返回值
value.run((v) => print(v))'''),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSection({required String title, required IconData icon, required Color color, required List<Widget> children}) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: color, size: 24),
                const SizedBox(width: 8),
                Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 12),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildExtensionDemo(String name, String code) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(name, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
        const SizedBox(height: 4),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Text(code, style: const TextStyle(fontFamily: 'monospace', fontSize: 12)),
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}
