# OpenClaw 入门书 · 插图风格指南

## 风格定义：笔记本上的中性笔手绘

本书所有插图统一采用**笔记本上的黑白中性笔手绘**风格——就像开发者真的在笔记本上随手画的，拍照后放进书里。带有笔记本横线和纸张真实质感，亲切自然、没有距离感。

> **参考基准图**：`five_components_test_1773739173158.png`（第一次生成的五大组件图）

## 核心风格要素

| 要素 | 规范 |
|------|------|
| **画材** | 黑色中性笔（gel pen），线条有自然的粗细变化和墨水压力差异 |
| **纸张** | 白色笔记本纸张，**带有淡淡的横线**（ruled lines），有真实的纸张质感 |
| **纸张边缘** | 可以露出轻微的纸张边角、页边阴影，增加真实感 |
| **颜色** | 黑白为主，图标可以带有自然的灰色阴影调子（不要纯平面线条） |
| **线条** | 松散自然的手绘线条，带有轻微的不完美和抖动感 |
| **阴影** | 使用交叉影线（crosshatch）和轻微灰度来表示深浅层次 |
| **标签** | 中文手写字体风格，清晰可读，自然不刻板 |
| **批注** | 可以添加圈注、下划线、箭头等随手批注，增加真实感 |
| **整体感觉** | 像用手机拍了一张笔记本照片，真实、随意、有质感 |

## Prompt 模板

生成插图时，在具体内容描述前后加上以下风格约束：

```
【前缀 — 每张图必须一字不改地使用】
A casual black and white ballpoint pen sketch on plain white notebook paper
with clearly visible faint horizontal ruled lines across the entire page.
The notebook paper has evenly spaced horizontal lines like a standard ruled
notebook. Drawn as if someone quickly sketched it with a black gel pen
during a meeting. Loose, natural hand-drawn lines with slight imperfections.
No color at all, pure black ink on white ruled notebook paper.

【中间：具体内容描述】
（此处插入 illustration-requirements.md 中对应插图的「内容」字段）
All Chinese text labels must be clearly legible and written on single lines.

【后缀 — 每张图必须一字不改地使用】
Some areas have casual crosshatch shading.
The style should look spontaneous and authentic, like real ballpoint pen notes
from a developer's notebook. Some slight ink pressure variations.
Chinese handwriting labels. A few circled annotations where appropriate.
```

> ⚠️ **一致性要求**：前缀和后缀是固定的，**每张图都必须使用完全相同的前缀和后缀**，只有中间的内容描述不同。这样才能保证所有插图看起来像是从同一个横格笔记本上画出来的。

## ⚠️ 关键约束（基于测试调整）

以下为生成测试后确认的规则：

1. **保留笔记本纸张质感**：横线、纸边阴影、页角都是加分项，**不要去掉**
2. **不要用纯白背景**：纯白背景会让图看起来像工程图，失去真实感和温度
3. **不要过度倾斜**：拍摄角度保持正面或轻微俯角，不要大角度透视
4. **纸面可以略脏**：轻微的墨水痕迹、笔触印记是好的，增加真实感
5. **图标可以有灰度**：不需要严格的纯黑线条，自然的灰色阴影调子让图标更立体

## 适用场景

- **架构图**：用方框和箭头表示模块关系，配合手写标签
- **流程图**：用编号圆圈和箭头串联步骤
- **概念图**：用简笔涂鸦表达抽象概念（如大脑=推理、盾牌=安全）
- **对比图**：左右分列，用 vs 或分隔线区分
- **目录结构**：模拟树状缩进，像在纸上画文件夹
- **场景速览**：多个小涂鸦排成网格，每个代表一个场景

## 注意事项

1. **保持一致性**：全书插图必须统一使用此风格，不混入彩色或数字化风格
2. **信息优先**：手绘风格是为了亲切感，但信息传达的清晰度不能牺牲
3. **中文标签必须清晰可读**：手写风格但文字不能潦草到无法辨认，每个标签写在单行上不折行
4. **适度批注**：随手批注（如"重要！""→这里"）能增加真实感，但不要喧宾夺主
5. **简洁为上**：手绘风格天然适合简洁表达，避免在单张图中塞入过多元素
6. **图标间距充足**：确保标签文字之间不会因为拥挤而重叠或被迫换行
