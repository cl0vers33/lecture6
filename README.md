# lecture6 · 课堂作业六：基础组件与布局系统

移动应用开发实践 第 6 课（第 8 周）作业仓库，Flutter 单工程多页面导航结构。

## 运行方式

```bash
flutter pub get
flutter run -d chrome   # 或 flutter run -d windows
```

启动后进入「任务目录」页，点击条目进入各任务页面。

## 任务清单对照

### 案例复现（必做）
- `lib/pages/profile_card.dart` —— 个人名片页 profile_card，按课堂三步骤完成：
  1. `feat: profile skeleton with alignment` —— 骨架与对齐
  2. `feat: card decoration & status badge` —— 容器美化 + 头像徽标
  3. `feat: match design spec, zero overflow warnings` —— 设计稿对照验收（含"去掉 Expanded"故意实验记录）

### 自主实践（必做）
| 任务 | 文件 |
|------|------|
| 1 对齐任务卡（MainAxisAlignment 六场景） | `lib/pages/alignment_tasks.dart` |
| 2 弹性分配实验（2:1:1 + 超长内容表现） | `lib/pages/flex_experiment.dart` |
| 3 层叠角标（头像徽标 + 图片浮层文字） | `lib/pages/stack_badge.dart` |
| 4 容器美化（圆角/阴影/留白/剪裁 三处） | `lib/pages/container_decoration.dart` |
| 5 AI 使用标注 | 见本文末节 |

### 独立研究（选做）
| 任务 | 文件 |
|------|------|
| 1 约束传递实验（撑不满 + 溢出复现与解释） | `lib/pages/constraint_experiment.dart` |
| 2 FittedBox 缩放策略对比（contain/fill/scaleDown） | `lib/pages/fittedbox_experiment.dart` |
| 3 自定义剪裁形状（ClipPath 波浪/斜切头图） | `lib/pages/clip_path_card.dart` |

## 验证

- `dart analyze`：No issues found
- `flutter test`：冒烟测试通过
- 除"约束传递实验"页面内**故意复现**的溢出对照组外，全 App 无 RenderFlex 溢出告警

## AI 使用标注（任务5）

本作业使用 **TraeCode（Kimi 模型）** 辅助，使用方式如下：

| 环节 | AI 参与方式 | 人工验证方式 |
|------|------------|-------------|
| 工程脚手架 | 人工执行 `flutter create`，AI 未参与 | —— |
| profile_card 复现 | AI 按实践指南三步骤描述生成代码 | `dart analyze` + `flutter test` 通过；逐行对照指南"卡片套路"核对 |
| 自主实践 4 任务 | AI 按任务书要求生成，布局参数人工指定 | 逐页运行截图核对视觉效果与参数标注 |
| 独立研究 3 任务 | AI 生成实验代码；结论文字基于指南"约束传递规则"与个人运行观察整理 | 溢出/撑不满现象实机复现确认；LayoutBuilder 读数与 Inspector 交叉验证 |
| 演示站源码 | 仅克隆阅读 `flutter-book-demos` 作参考，未复制其页面代码 | —— |

AI 生成代码均经过 `dart analyze`、`flutter test` 与实际运行三重验证后提交，未直接提交未经验证的生成代码。
