import 'package:flutter/material.dart';
import 'package:super_core/super_core.dart';

import '../services/api_service.dart';

/// 搜索功能测试页
class TestSearchPage extends StatefulWidget {
  const TestSearchPage({super.key});

  @override
  State<TestSearchPage> createState() => _TestSearchPageState();
}

class _TestSearchPageState extends State<TestSearchPage> {
  final TextEditingController _searchController = TextEditingController();
  final List<Map<String, dynamic>> _searchResults = [];
  final List<Map<String, dynamic>> _hotKeys = [];
  bool _isLoading = false;
  bool _isSearching = false;
  String _currentKeyword = '';

  @override
  void initState() {
    super.initState();
    _loadHotKeys();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadHotKeys() async {
    try {
      LogUtil.i('加载热搜关键词');
      final result = await ApiService.getHotKeys();

      setState(() {
        _hotKeys.clear();
        _hotKeys.addAll(result.cast<Map<String, dynamic>>());
      });

      LogUtil.i('热搜关键词加载成功，共 ${result.length} 个');
    } catch (e, s) {
      LogUtil.e('加载热搜关键词失败', error: e, stackTrace: s);
    }
  }

  Future<void> _search(String keyword) async {
    if (keyword.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('请输入搜索关键词')));
      return;
    }

    setState(() {
      _isLoading = true;
      _isSearching = true;
      _currentKeyword = keyword;
      _searchResults.clear();
    });

    // 隐藏键盘
    FocusScope.of(context).unfocus();

    try {
      LogUtil.i('搜索文章，关键词: $keyword');

      final result = await ApiService.searchArticle(0, keyword);

      final data = result['data'];
      final datas = data['datas'] as List;

      setState(() {
        _searchResults.addAll(datas.cast<Map<String, dynamic>>());
        _isLoading = false;
      });

      LogUtil.i('搜索成功，找到 ${datas.length} 条结果');
    } catch (e, s) {
      LogUtil.e('搜索失败', error: e, stackTrace: s);
      setState(() => _isLoading = false);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('搜索失败: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('搜索功能测试')),
      body: Column(
        children: [
          // 搜索框
          Container(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: '输入关键词搜索...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          setState(() {
                            _isSearching = false;
                            _searchResults.clear();
                          });
                        },
                      )
                    : null,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onChanged: (value) => setState(() {}),
              onSubmitted: _search,
            ),
          ),

          // 内容区域
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _isSearching
                ? _buildSearchResults()
                : _buildHotKeys(),
          ),
        ],
      ),
    );
  }

  Widget _buildHotKeys() {
    if (_hotKeys.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text('🔥 热搜关键词', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _hotKeys.map((hotKey) {
            return ActionChip(
              label: Text(hotKey['name'] ?? ''),
              onPressed: () {
                _searchController.text = hotKey['name'];
                _search(hotKey['name']);
              },
            );
          }).toList(),
        ),
        const SizedBox(height: 24),
        const Text('💡 提示', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Card(
          color: Colors.blue.shade50,
          child: const Padding(
            padding: EdgeInsets.all(12),
            child: Text(
              '• 点击热搜关键词可快速搜索\n'
              '• 在搜索框输入关键词后按回车搜索\n'
              '• 本页面演示 HTTP POST 请求功能',
              style: TextStyle(fontSize: 13, height: 1.5),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSearchResults() {
    if (_searchResults.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search_off, size: 64, color: Colors.grey.shade400),
            const SizedBox(height: 16),
            Text('未找到 "$_currentKeyword" 相关的内容', style: TextStyle(fontSize: 16, color: Colors.grey.shade600)),
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: _searchResults.length,
      itemBuilder: (context, index) {
        final article = _searchResults[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: InkWell(
            onTap: () {
              LogUtil.d('点击搜索结果: ${article['title']}');
            },
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    article['title'] ?? '',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      if (article['author']?.toString().isNotEmpty == true)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(4)),
                          child: Text(article['author'], style: TextStyle(fontSize: 12, color: Colors.blue.shade700)),
                        ),
                      const Spacer(),
                      Text(article['niceDate'] ?? '', style: TextStyle(fontSize: 12, color: Colors.grey.shade500)),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
