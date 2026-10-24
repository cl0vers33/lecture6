import 'package:flutter/material.dart';

/// 课堂案例复现：个人名片页 profile_card
/// 步骤一：骨架与对齐 —— 只管结构与对齐，不管装饰
class ProfileCardPage extends StatelessWidget {
  const ProfileCardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('个人名片')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 8),
            // ① 头像区
            const CircleAvatar(
              radius: 40,
              backgroundColor: Colors.indigo,
              child: Icon(Icons.person, size: 44, color: Colors.white),
            ),
            const SizedBox(height: 12),
            // ② 姓名与签名（两行 Text）
            const Text(
              '林小风',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            const Text(
              'Flutter 学习者 · 移动应用开发实践 第 6 课',
              style: TextStyle(fontSize: 13, color: Colors.black54),
            ),
            const SizedBox(height: 20),
            // ③ 统计条：三个 Expanded 数字块，等分整行宽度
            const Row(
              children: [
                Expanded(child: _StatItem(value: '128', label: '关注')),
                Expanded(child: _StatItem(value: '256', label: '粉丝')),
                Expanded(child: _StatItem(value: '64', label: '收藏')),
              ],
            ),
            const SizedBox(height: 20),
            // ④ 标签云：Wrap 流式排列，自动折行
            Wrap(
              spacing: 8,
              runSpacing: 8,
              alignment: WrapAlignment.center,
              children: const [
                Chip(label: Text('Flutter')),
                Chip(label: Text('Dart')),
                Chip(label: Text('布局系统')),
                Chip(label: Text('移动开发')),
                Chip(label: Text('开源')),
                Chip(label: Text('摄影')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// 统计条单个数字块：上方数值、下方说明文字
class _StatItem extends StatelessWidget {
  final String value;
  final String label;
  const _StatItem({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: Colors.black54),
        ),
      ],
    );
  }
}
