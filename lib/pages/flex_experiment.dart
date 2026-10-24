import 'package:flutter/material.dart';

/// 自主实践任务 2：弹性分配实验
/// 三栏 2:1:1 比例布局 + 一栏内容超长时的表现记录
class FlexExperimentPage extends StatefulWidget {
  const FlexExperimentPage({super.key});

  @override
  State<FlexExperimentPage> createState() => _FlexExperimentPageState();
}

class _FlexExperimentPageState extends State<FlexExperimentPage> {
  bool _longContent = false;

  static const String _shortText = '内容';
  static const String _longText =
      '这是一段故意做得超长的内容，用来观察弹性分配后栏内文本的表现：'
      'Expanded 会把主轴剩余空间按比例分给孩子，并给出紧凑约束，'
      '所以超长文本会在分配到的宽度内自动换行，而不会把相邻栏挤飞。';

  @override
  Widget build(BuildContext context) {
    final text = _longContent ? _longText : _shortText;
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(title: const Text('任务2 · 弹性分配实验')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          SwitchListTile(
            title: const Text('中间栏放入超长内容'),
            subtitle: const Text('切换观察 2:1:1 布局下超长文本的表现'),
            value: _longContent,
            onChanged: (v) => setState(() => _longContent = v),
          ),
          const SizedBox(height: 8),
          _sectionTitle('① 三栏 2:1:1（Expanded flex: 2/1/1）'),
          Container(
            height: _longContent ? null : 60,
            constraints: const BoxConstraints(minHeight: 60),
            color: Colors.white,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 2, child: _bar(Colors.indigo, 'flex:2\n$text')),
                Expanded(flex: 1, child: _bar(Colors.amber, 'flex:1')),
                Expanded(flex: 1, child: _bar(Colors.teal, 'flex:1')),
              ],
            ),
          ),
          const SizedBox(height: 16),
          _sectionTitle('② 对照：不用 Expanded 的 Row + 超长文本（演示溢出）'),
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 8),
            // 故意不放 Expanded：超长文本按内容宽度报告尺寸 → RenderFlex 溢出
            child: Row(
              children: [
                _bar(Colors.indigo, '固定栏'),
                Text(_longContent ? _longText : _shortText),
              ],
            ),
          ),
          const SizedBox(height: 16),
          _sectionTitle('③ 表现记录'),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Text(
              '· 2:1:1 正常态：三栏宽度比 2:1:1，Expanded 按比例吃掉主轴剩余空间。\n'
              '· 超长内容在 Expanded 内：栏宽仍严格保持 2:1:1，文本在栏内换行，高度随内容增长，不溢出。\n'
              '· 超长内容脱离 Expanded（对照组②）：文本按自身内容宽度报告尺寸，'
              '超出 Row 剩余空间，触发 RenderFlex overflow 黄黑警告条。',
              style: TextStyle(fontSize: 13, height: 1.7),
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

  Widget _bar(Color color, String text) => Container(
        padding: const EdgeInsets.all(4),
        color: color.withValues(alpha: 0.35),
        child: Text(text, style: const TextStyle(fontSize: 12)),
      );
}
