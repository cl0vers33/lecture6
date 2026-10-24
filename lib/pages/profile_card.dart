import 'package:flutter/material.dart';

/// 课堂案例复现：个人名片页 profile_card
/// 步骤二：容器美化 —— 卡片装饰（圆角/阴影/留白）+ 头像 Stack 徽标
class ProfileCardPage extends StatelessWidget {
  const ProfileCardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo[50],
      appBar: AppBar(title: const Text('个人名片')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // ① 名片主体：卡片套路（圆角 + 阴影 + 留白）
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // 头像 + 右下角在线状态徽标（Stack + Positioned）
                  Stack(
                    children: [
                      const CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.indigo,
                        child: Icon(Icons.person, size: 44, color: Colors.white),
                      ),
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: Container(
                          width: 18,
                          height: 18,
                          decoration: BoxDecoration(
                            color: Colors.green,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // 姓名与签名
                  const Text(
                    '林小风',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Flutter 学习者 · 移动应用开发实践 第 6 课',
                    style: TextStyle(fontSize: 13, color: Colors.black54),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // ② 统计条：浅底装饰容器 + 三个 Expanded 数字块
            Container(
              padding: const EdgeInsets.symmetric(vertical: 14),
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
              child: const Row(
                children: [
                  Expanded(child: _StatItem(value: '128', label: '关注')),
                  Expanded(child: _StatItem(value: '256', label: '粉丝')),
                  Expanded(child: _StatItem(value: '64', label: '收藏')),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // ③ 标签云：Wrap 流式排列
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
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.indigo,
          ),
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
