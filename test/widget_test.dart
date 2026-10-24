// 课堂作业六 · 冒烟测试：验证 App 能正常启动并显示任务目录
import 'package:flutter_test/flutter_test.dart';

import 'package:lecture6/main.dart';

void main() {
  testWidgets('app launches and shows home page', (WidgetTester tester) async {
    await tester.pumpWidget(const Lecture6App());

    // 首页应显示任务目录标题
    expect(find.text('课堂作业六 · 任务目录'), findsOneWidget);
  });
}
