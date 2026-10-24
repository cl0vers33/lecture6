import 'package:flutter/material.dart';

/// 自主实践任务 4：容器美化
/// 圆角 / 阴影 / 留白 / 剪裁，至少两处卡片
class ContainerDecorationPage extends StatelessWidget {
  const ContainerDecorationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(title: const Text('任务4 · 容器美化')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _sectionTitle('卡片一 · 标准卡片套路（圆角+阴影+留白）'),
          // 指南中的卡片套路：padding 12 + borderRadius 12 + boxShadow
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 8,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 24,
                  backgroundColor: Colors.indigo,
                  child: Icon(Icons.person, color: Colors.white),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        '林小风',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                        SizedBox(height: 2),
                      Text(
                        'borderRadius: 12 · blurRadius: 8 · padding: 12',
                        style: TextStyle(fontSize: 11, color: Colors.black45),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.chevron_right, color: Colors.black26),
              ],
            ),
          ),
          const SizedBox(height: 16),
          _sectionTitle('卡片二 · 渐变装饰卡片'),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.indigo, Colors.deepPurple],
              ),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 12,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Icon(Icons.auto_awesome, color: Colors.white, size: 28),
                SizedBox(height: 8),
                Text(
                  'gradient + borderRadius: 16',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'LinearGradient 由左上 indigo 到右下 deepPurple，'
                  '配 blurRadius 12 的更深阴影营造浮起感。',
                  style: TextStyle(fontSize: 12, color: Colors.white70),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          _sectionTitle('卡片三 · 剪裁美化（ClipRRect / ClipOval）'),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 8,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // ClipRRect 圆角剪裁
                Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        width: 72,
                        height: 72,
                        color: Colors.amber,
                        child: const Icon(Icons.image, color: Colors.white),
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text('ClipRRect', style: TextStyle(fontSize: 12)),
                  ],
                ),
                // ClipOval 圆形剪裁
                Column(
                  children: [
                    ClipOval(
                      child: Container(
                        width: 72,
                        height: 72,
                        color: Colors.teal,
                        child: const Icon(Icons.image, color: Colors.white),
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text('ClipOval', style: TextStyle(fontSize: 12)),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Text(
              '翻车提醒：Container 的 color 与 decoration 不能同时设置'
              '（会编译报错），颜色要写进 BoxDecoration 里。',
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
}
