import 'package:flutter/material.dart';

/// 独立研究任务 3：自定义剪裁形状
/// 用 ClipPath + CustomClipper 做异形卡片头图（波浪底边 / 斜切底边）
class ClipPathCardPage extends StatelessWidget {
  const ClipPathCardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(title: const Text('研究3 · 自定义剪裁形状')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _sectionTitle('卡片一 · 波浪底边头图'),
          _shapedCard(
            clipper: _WaveClipper(),
            colors: const [Colors.indigo, Colors.purple],
            title: '波浪底边 · WaveClipper',
            subtitle: '两段 quadraticBezierTo 拼出波浪曲线',
          ),
          const SizedBox(height: 16),
          _sectionTitle('卡片二 · 斜切底边头图'),
          _shapedCard(
            clipper: _SlantClipper(),
            colors: const [Colors.teal, Colors.green],
            title: '斜切底边 · SlantClipper',
            subtitle: '一条斜线把矩形右下角削掉',
          ),
          const SizedBox(height: 16),
          _sectionTitle('实现要点'),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Text(
              '① 自定义 CustomClipper<Path>，在 getClip(size) 里用 Path 画形状；\n'
              '② ClipPath(clipper: ...) 包住头图，超出路径的部分被裁掉；\n'
              '③ shouldReclip 返回 false：形状不随状态变化，避免每次重建都重算路径。\n\n'
              '剪裁只影响绘制与命中区域，不改变子组件的布局尺寸 —— '
              '头图仍占满原来的矩形空间，只是超出路径的部分不画出来。',
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

  /// 异形头图卡片：ClipPath 剪裁的渐变头图 + 卡片正文
  Widget _shapedCard({
    required CustomClipper<Path> clipper,
    required List<Color> colors,
    required String title,
    required String subtitle,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 异形头图：渐变底 + ClipPath 自定义路径
          ClipPath(
            clipper: clipper,
            child: Container(
              height: 140,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: colors,
                ),
              ),
              child: const Center(
                child: Icon(Icons.terrain, size: 48, color: Colors.white54),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(fontSize: 12, color: Colors.black54),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// 波浪底边剪裁：两段二次贝塞尔曲线
class _WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path()
      ..lineTo(0, size.height - 32)
      ..quadraticBezierTo(
        size.width * 0.25, size.height,
        size.width * 0.5, size.height - 24,
      )
      ..quadraticBezierTo(
        size.width * 0.75, size.height - 48,
        size.width, size.height - 8,
      )
      ..lineTo(size.width, 0)
      ..close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

/// 斜切底边剪裁：左高右低一条斜线
class _SlantClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path()
      ..lineTo(0, size.height)
      ..lineTo(size.width, size.height - 40)
      ..lineTo(size.width, 0)
      ..close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
