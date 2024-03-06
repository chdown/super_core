import 'dart:html';

/// @author : ch
/// @date 2024-03-06 14:20:45
/// @description 核心配置
///
class SuperCoreConfig {
  /// 显示toast输出
  static Function(String msg) showToast = (msg) {};

  /// 展示loading
  static VoidCallback showLoading = (){};

  /// 隐藏loading
  static VoidCallback hideLoading = (){};

}