import 'package:flutter/material.dart';

/// 独立研究任务 2：FittedBox 缩放策略
/// 同一内容 × contain / fill / scaleDown 效果对比与选型结论
class FittedBoxExperimentPage extends StatelessWidget {
  const FittedBoxExperimentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(title: const Text('研究2 · FittedBox 缩放策略')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            '实验内容：把一个 240×48 的宽扁横幅塞进三个 120×120 的小容器，'
            '分别用三种 BoxFit 策略观察表现。',
            style: TextStyle(fontSize: 13, height: 1.6),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _fitDemo(
                  label: 'contain',
                  fit: BoxFit.contain,
                  note: '等比缩放\n完整显示·四周留白',
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _fitDemo(
                  label: 'fill',
                  fit: BoxFit.fill,
                  note: '非等比拉伸\n填满·内容变形',
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _fitDemo(
                  label: 'scaleDown',
                  fit: BoxFit.scaleDown,
                  note: '超出才等比缩小\n保完整·不变形',
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _sectionTitle('对照 · 不用 FittedBox 直接塞'),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: _cardDecoration(),
            child: Row(
              children: [
                Container(
                  width: 120,
                  height: 120,
                  color: Colors.indigo[50],
                  // 直接放超尺寸内容：240 宽的横幅超出 120 容器
                  child: _banner(),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Text(
                    '没有 FittedBox：横幅保持 240×48 原尺寸，'
                        '超出 120 容器约束的部分被裁剪/挤出，内容不完整。',
                    style: TextStyle(fontSize: 12, height: 1.6),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          _sectionTitle('选型结论'),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: _cardDecoration(),
            child: const Text(
              '· contain：要"完整不变形"选它 —— 头像缩略图、图片预览。\n'
              '· fill：要"填满每一寸"且能容忍变形选它 —— 背景纹理平铺前的兜底。\n'
              '· scaleDown：内容多数时候放得下、偶尔超一点选它 —— 标题栏长文本、'
              '按钮内图标文字的防溢出兜底。\n'
              '共同前提：FittedBox 自己先拿到有界约束，才能谈缩放策略。',
              style: TextStyle(fontSize: 13, height: 1.8),
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

  /// 被缩放的实验内容：240×48 宽扁横幅
  Widget _banner() => Container(
        width: 240,
        height: 48,
        color: Colors.indigo,
        child: const Center(
          child: Text(
            '240×48 横幅',
            style: TextStyle(fontSize: 14, color: Colors.white),
          ),
        ),
      );

  Widget _fitDemo({
    required String label,
    required BoxFit fit,
    required String note,
  }) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: _cardDecoration(),
      child: Column(
        children: [
          Text(
            'BoxFit.$label',
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              fontFamily: 'monospace',
            ),
          ),
          const SizedBox(height: 6),
          Container(
            width: 120,
            height: 120,
            color: Colors.indigo[50],
            child: FittedBox(fit: fit, child: _banner()),
          ),
          const SizedBox(height: 6),
          Text(
            note,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 11, height: 1.5),
          ),
        ],
      ),
    );
  }
}
