import 'package:flutter/material.dart';

import 'pages/profile_card.dart';

void main() {
  runApp(const Lecture6App());
}

/// 第 6 课 · 基础组件与布局系统 —— 课堂作业六
class Lecture6App extends StatelessWidget {
  const Lecture6App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '第6课 · 基础组件与布局系统',
      theme: ThemeData(colorSchemeSeed: Colors.indigo, useMaterial3: true),
      home: const HomePage(),
    );
  }
}

/// 任务目录页：列出本次作业各任务入口
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('课堂作业六 · 任务目录')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _TaskTile(
            icon: Icons.badge,
            title: '案例复现 · profile_card',
            subtitle: '个人名片页：骨架对齐 → 容器美化 → 设计稿验收',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ProfileCardPage()),
            ),
          ),
        ],
      ),
    );
  }
}

class _TaskTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  const _TaskTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}
