import 'package:flutter/material.dart';

/// 自主实践任务 1：对齐任务卡
/// 六种主轴对齐场景逐一实现并标注参数
class AlignmentTasksPage extends StatelessWidget {
  const AlignmentTasksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(title: const Text('任务1 · 六种对齐场景')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          _AlignCard(
            index: 1,
            title: 'MainAxisAlignment.start',
            description: '子组件从主轴起点开始排列，剩余空间全部留在末尾。',
            alignment: MainAxisAlignment.start,
          ),
          _AlignCard(
            index: 2,
            title: 'MainAxisAlignment.center',
            description: '子组件整体居中，剩余空间均分到主轴两端。',
            alignment: MainAxisAlignment.center,
          ),
          _AlignCard(
            index: 3,
            title: 'MainAxisAlignment.end',
            description: '子组件排列到主轴末尾，剩余空间留在起点。',
            alignment: MainAxisAlignment.end,
          ),
          _AlignCard(
            index: 4,
            title: 'MainAxisAlignment.spaceBetween',
            description: '首尾子组件贴边，中间剩余空间均分到子组件之间。',
            alignment: MainAxisAlignment.spaceBetween,
          ),
          _AlignCard(
            index: 5,
            title: 'MainAxisAlignment.spaceAround',
            description: '每个子组件前后均分间隙；两端间隙是中间间隙的一半。',
            alignment: MainAxisAlignment.spaceAround,
          ),
          _AlignCard(
            index: 6,
            title: 'MainAxisAlignment.spaceEvenly',
            description: '所有间隙完全相等，包括两端与子组件之间。',
            alignment: MainAxisAlignment.spaceEvenly,
          ),
        ],
      ),
    );
  }
}

/// 单张对齐任务卡：参数标注 + Row 实演 + 说明
class _AlignCard extends StatelessWidget {
  final int index;
  final String title;
  final String description;
  final MainAxisAlignment alignment;

  const _AlignCard({
    required this.index,
    required this.title,
    required this.description,
    required this.alignment,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 参数标注
          Text(
            '场景$index · $title',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              fontFamily: 'monospace',
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'crossAxisAlignment: CrossAxisAlignment.center（统一）',
            style: TextStyle(
              fontSize: 11,
              color: Colors.black45,
              fontFamily: 'monospace',
            ),
          ),
          const SizedBox(height: 10),
          // 演示区：浅色底容器内放 Row，三个色块观察主轴分布
          Container(
            height: 56,
            color: Colors.indigo[50],
            child: Row(
              mainAxisAlignment: alignment,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                _ColorBox(Colors.indigo),
                _ColorBox(Colors.amber),
                _ColorBox(Colors.teal),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Text(
            description,
            style: const TextStyle(fontSize: 12, color: Colors.black87),
          ),
        ],
      ),
    );
  }
}

class _ColorBox extends StatelessWidget {
  final Color color;
  const _ColorBox(this.color);

  @override
  Widget build(BuildContext context) {
    return Container(width: 36, height: 36, color: color);
  }
}
