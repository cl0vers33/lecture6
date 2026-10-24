import 'package:flutter/material.dart';

/// 自主实践任务 3：层叠角标
/// 场景一：头像徽标（在线状态点 + 未读数字角标）
/// 场景二：图片浮层文字（渐变底图 + 底部半透明标题条）
class StackBadgePage extends StatelessWidget {
  const StackBadgePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(title: const Text('任务3 · 层叠角标')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _sectionTitle('场景一 · 头像徽标'),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: _cardDecoration(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _avatarWithStatus(),
                _avatarWithBadge(),
              ],
            ),
          ),
          const SizedBox(height: 16),
          _sectionTitle('场景二 · 图片浮层文字'),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: _cardDecoration(),
            child: _imageWithOverlay(),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: _cardDecoration(),
            child: const Text(
              '要点：Stack 的 children 自底向上绘制；Positioned 用 '
              'left/top/right/bottom 定位，其尺寸不参与 Stack 尺寸计算；'
              '非定位子项按 Stack.alignment 对齐。',
              style: TextStyle(fontSize: 12, height: 1.7, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String text) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Text(
          text,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
      );

  BoxDecoration _cardDecoration() => BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 2)),
        ],
      );

  /// 头像 + 右下角在线状态点
  Widget _avatarWithStatus() {
    return Column(
      children: [
        Stack(
          children: [
            const CircleAvatar(
              radius: 32,
              backgroundColor: Colors.indigo,
              child: Icon(Icons.person, size: 34, color: Colors.white),
            ),
            Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        const Text('在线状态点', style: TextStyle(fontSize: 12)),
      ],
    );
  }

  /// 头像 + 右上角未读数字角标
  Widget _avatarWithBadge() {
    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            const CircleAvatar(
              radius: 32,
              backgroundColor: Colors.teal,
              child: Icon(Icons.person, size: 34, color: Colors.white),
            ),
            Positioned(
              right: -4,
              top: -4,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(9),
                  border: Border.all(color: Colors.white, width: 1.5),
                ),
                child: const Text(
                  '99+',
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        const Text('未读角标', style: TextStyle(fontSize: 12)),
      ],
    );
  }

  /// 渐变底图 + 底部浮层文字 + 右上角 NEW 角标
  Widget _imageWithOverlay() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Stack(
        children: [
          // 底图：用渐变容器模拟图片（课程图片合规要求，不用网络盗链）
          Container(
            height: 160,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.indigo, Colors.purple],
              ),
            ),
            child: const Center(
              child: Icon(Icons.landscape, size: 56, color: Colors.white54),
            ),
          ),
          // 右上角 NEW 角标
          Positioned(
            right: 8,
            top: 8,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              color: Colors.red,
              child: const Text(
                'NEW',
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          // 底部浮层文字条
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              color: Colors.black54,
              child: const Text(
                '校园晚霞 · 摄于图书馆前',
                style: TextStyle(fontSize: 13, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
