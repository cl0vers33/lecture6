import 'package:flutter/material.dart';

/// 独立研究任务 1：约束传递实验
/// 复现"撑不满"与"溢出"各一例，用 LayoutBuilder 实时读取约束并解释成因
class ConstraintExperimentPage extends StatelessWidget {
  const ConstraintExperimentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(title: const Text('研究1 · 约束传递实验')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _sectionTitle('实验一 · "撑不满"现象复现'),
          _demoCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 现象：Center 给松约束，子组件只按内容尺寸报告
                Container(
                  width: double.infinity,
                  color: Colors.indigo[50],
                  padding: const EdgeInsets.all(8),
                  child: Center(
                    child: Container(
                      color: Colors.red[200],
                      padding: const EdgeInsets.all(8),
                      child: const Text(
                        '我想撑满整行',
                        style: TextStyle(fontSize: 13),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                _constraintProbe(),
                const Text(
                  '现象：红块没有撑满整行。Center 给子组件的是"松约束"'
                  '（0 ≤ 宽 ≤ 行宽），Container 按自身内容报告尺寸，'
                  '于是只有文字那么宽。',
                  style: TextStyle(fontSize: 12, height: 1.6),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _demoCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 修复：width: double.infinity 主动顶到约束上限
                Container(
                  width: double.infinity,
                  color: Colors.green[200],
                  padding: const EdgeInsets.all(8),
                  child: const Text(
                    '修复：width: double.infinity 撑满整行',
                    style: TextStyle(fontSize: 13),
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  '修复方法：width: double.infinity 让宽度顶到父约束上限；'
                  '在 Row/Column 主轴上则用 Expanded。',
                  style: TextStyle(fontSize: 12, height: 1.6),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          _sectionTitle('实验二 · "溢出"现象复现（黄黑警告条）'),
          _demoCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 现象：固定高度容器里 Column 内容超出 → RenderFlex overflow
                Container(
                  height: 72,
                  width: double.infinity,
                  color: Colors.indigo[50],
                  // 故意溢出：Column 在 72px 高度内塞 5 行文字
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('第 1 行：固定高度 72px 的容器'),
                      Text('第 2 行：Column 内容还在增加'),
                      Text('第 3 行：空间即将耗尽'),
                      Text('第 4 行：这一行已经装不下'),
                      Text('第 5 行：RenderFlex overflow!'),
                    ],
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  '现象：父容器高度 72px（紧约束），Column 内容总高超过 72px，'
                  '底部出现 RenderFlex overflow 黄黑警告条。',
                  style: TextStyle(fontSize: 12, height: 1.6),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _demoCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 修复：同样高度改用 ListView，内容滚动展示
                Container(
                  height: 72,
                  width: double.infinity,
                  color: Colors.green[50],
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: const [
                      Text('第 1 行：改用 ListView'),
                      Text('第 2 行：内容超出时滚动显示'),
                      Text('第 3 行：不再溢出'),
                      Text('第 4 行：这一行也能看到了'),
                      Text('第 5 行：end.'),
                    ],
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  '修复方法：把 Column 换成 ListView（可滚动），'
                  '或用 Expanded/SingleChildScrollView 让内容在约束内消化。',
                  style: TextStyle(fontSize: 12, height: 1.6),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          _sectionTitle('成因解释 · 约束传递规则'),
          _demoCard(
            child: const Text(
              'Flutter 布局三句话：\n'
              '① 父组件把约束（最小/最大宽高）传给子组件；\n'
              '② 子组件在约束内报告自己的尺寸；\n'
              '③ 父组件决定子组件的位置。\n\n'
              '"撑不满"：父给松约束（如 Center），子按内容报告尺寸 → 想撑满要'
              ' double.infinity 或 Expanded 主动顶到上限。\n'
              '"溢出"：约束装不下内容（固定高 + 超长 Column）→ 子组件报告尺寸'
              '超出父约束上限，触发 RenderFlex overflow 警告。',
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

  Widget _demoCard({required Widget child}) => Container(
        width: double.infinity,
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
        child: child,
      );

  /// LayoutBuilder 实时读取父级约束（等效于 Inspector 里看到的约束值）
  Widget _constraintProbe() => LayoutBuilder(
        builder: (context, constraints) => Padding(
          padding: const EdgeInsets.only(bottom: 6),
          child: Text(
            'LayoutBuilder 读到父级约束：maxWidth=${constraints.maxWidth.toStringAsFixed(1)}, '
            'maxHeight=${constraints.maxHeight == double.infinity ? "∞" : constraints.maxHeight.toStringAsFixed(1)}',
            style: const TextStyle(
              fontSize: 11,
              fontFamily: 'monospace',
              color: Colors.black54,
            ),
          ),
        ),
      );
}
