import 'package:flutter/material.dart';
import 'package:super_core/super_core.dart';

import '../services/api_service.dart';

/// 文章列表测试页
class TestArticlePage extends StatefulWidget {
  const TestArticlePage({super.key});

  @override
  State<TestArticlePage> createState() => _TestArticlePageState();
}

class _TestArticlePageState extends State<TestArticlePage> {
  final List<Map<String, dynamic>> _articles = [];
  int _currentPage = 0;
  bool _isLoading = false;
  bool _hasMore = true;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _loadArticles();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
      if (!_isLoading && _hasMore) {
        _loadMore();
      }
    }
  }

  Future<void> _loadArticles() async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
      _currentPage = 0;
      _articles.clear();
    });

    try {
      LogUtil.i('开始加载文章列表，页码: $_currentPage');

      final result = await ApiService.getArticleList(_currentPage);

      final data = result['data'];
      final datas = data['datas'] as List;

      setState(() {
        _articles.addAll(datas.cast<Map<String, dynamic>>());
        _hasMore = !data['over'];
        _isLoading = false;
      });

      LogUtil.i('文章列表加载成功，共 ${datas.length} 条');
    } catch (e, s) {
      LogUtil.e('加载文章列表失败', error: e, stackTrace: s);
      setState(() => _isLoading = false);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('加载失败: $e')));
      }
    }
  }

  Future<void> _loadMore() async {
    if (_isLoading || !_hasMore) return;

    setState(() => _isLoading = true);

    try {
      _currentPage++;
      LogUtil.i('加载更多文章，页码: $_currentPage');

      final result = await ApiService.getArticleList(_currentPage);

      final data = result['data'];
      final datas = data['datas'] as List;

      setState(() {
        _articles.addAll(datas.cast<Map<String, dynamic>>());
        _hasMore = !data['over'];
        _isLoading = false;
      });

      LogUtil.i('加载更多成功，新增 ${datas.length} 条');
    } catch (e, s) {
      LogUtil.e('加载更多失败', error: e, stackTrace: s);
      _currentPage--;
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('文章列表测试'),
        actions: [IconButton(icon: const Icon(Icons.refresh), onPressed: _loadArticles)],
      ),
      body: _articles.isEmpty && _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _articles.isEmpty
          ? _buildEmptyView()
          : RefreshIndicator(
              onRefresh: _loadArticles,
              child: ListView.builder(
                controller: _scrollController,
                itemCount: _articles.length + (_hasMore ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index == _articles.length) {
                    return _buildLoadingMore();
                  }
                  return _buildArticleItem(_articles[index]);
                },
              ),
            ),
    );
  }

  Widget _buildEmptyView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.inbox, size: 64, color: Colors.grey.shade400),
          const SizedBox(height: 16),
          Text('暂无数据', style: TextStyle(fontSize: 16, color: Colors.grey.shade600)),
          const SizedBox(height: 24),
          ElevatedButton.icon(onPressed: _loadArticles, icon: const Icon(Icons.refresh), label: const Text('重新加载')),
        ],
      ),
    );
  }

  Widget _buildLoadingMore() {
    return Container(padding: const EdgeInsets.all(16), alignment: Alignment.center, child: const CircularProgressIndicator());
  }

  Widget _buildArticleItem(Map<String, dynamic> article) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: InkWell(
        onTap: () {
          LogUtil.d('点击文章: ${article['title']}');
        },
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 标题
              Text(
                article['title'] ?? '',
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
              // 作者和分类
              Row(
                children: [
                  if (article['author']?.toString().isNotEmpty == true)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(4)),
                      child: Text(article['author'], style: TextStyle(fontSize: 12, color: Colors.blue.shade700)),
                    ),
                  const SizedBox(width: 8),
                  if (article['superChapterName']?.toString().isNotEmpty == true)
                    Text(article['superChapterName'], style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
                  const Spacer(),
                  Text(article['niceDate'] ?? '', style: TextStyle(fontSize: 12, color: Colors.grey.shade500)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
