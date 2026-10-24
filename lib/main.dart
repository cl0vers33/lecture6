import 'package:flutter/material.dart';

import 'pages/alignment_tasks.dart';
import 'pages/clip_path_card.dart';
import 'pages/constraint_experiment.dart';
import 'pages/container_decoration.dart';
import 'pages/fittedbox_experiment.dart';
import 'pages/flex_experiment.dart';
import 'pages/profile_card.dart';
import 'pages/stack_badge.dart';

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

/// 任务目录页：按作业三部分分组列出入口
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('课堂作业六 · 任务目录')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _groupTitle('案例复现'),
          _TaskTile(
            icon: Icons.badge,
            title: 'profile_card 个人名片页',
            subtitle: '骨架对齐 → 容器美化 → 设计稿验收（三步提交）',
            page: const ProfileCardPage(),
          ),
          _groupTitle('自主实践'),
          _TaskTile(
            icon: Icons.align_horizontal_left,
            title: '任务1 · 六种对齐场景',
            subtitle: 'MainAxisAlignment 六值逐一实现并标注参数',
            page: const AlignmentTasksPage(),
          ),
          _TaskTile(
            icon: Icons.view_column,
            title: '任务2 · 弹性分配实验',
            subtitle: '三栏 2:1:1 布局 + 超长内容表现记录',
            page: const FlexExperimentPage(),
          ),
          _TaskTile(
            icon: Icons.layers,
            title: '任务3 · 层叠角标',
            subtitle: '头像徽标 + 图片浮层文字（Stack + Positioned）',
            page: const StackBadgePage(),
          ),
          _TaskTile(
            icon: Icons.style,
            title: '任务4 · 容器美化',
            subtitle: '圆角 / 阴影 / 留白 / 剪裁，三处卡片',
            page: const ContainerDecorationPage(),
          ),
          _groupTitle('独立研究（选做）'),
          _TaskTile(
            icon: Icons.straighten,
            title: '研究1 · 约束传递实验',
            subtitle: '"撑不满"与"溢出"复现 + LayoutBuilder 读约束',
            page: const ConstraintExperimentPage(),
          ),
          _TaskTile(
            icon: Icons.fit_screen,
            title: '研究2 · FittedBox 缩放策略',
            subtitle: 'contain / fill / scaleDown 同一内容对比',
            page: const FittedBoxExperimentPage(),
          ),
          _TaskTile(
            icon: Icons.content_cut,
            title: '研究3 · 自定义剪裁形状',
            subtitle: 'ClipPath 异形卡片头图（波浪 / 斜切）',
            page: const ClipPathCardPage(),
          ),
        ],
      ),
    );
  }

  Widget _groupTitle(String text) => Padding(
        padding: const EdgeInsets.only(top: 8, bottom: 8),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: Colors.indigo,
          ),
        ),
      );
}

class _TaskTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Widget page;
  const _TaskTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.page,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => page),
        ),
      ),
    );
  }
}
