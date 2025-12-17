//
//  APPTheme.swift
//  PQMD
//
//  Created by izven on 2025/12/16.
//

import UIKit

enum APPTheme {
    enum Color {
        // MARK: - Brand

        /// 主品牌色
        static var primary: UIColor {
            return UIColor(hex: 0x007AFF) ?? .blue
        }

        /// 次要品牌色
        static var secondary: UIColor {
            return UIColor(hex: 0x5856D6) ?? .purple
        }

        // MARK: - Background

        /// 主背景色 (页面背景)
        static var background: UIColor {
            return .systemBackground
        }

        /// 次要背景色 (卡片、列表项背景)
        static var secondaryBackground: UIColor {
            return .secondarySystemBackground
        }

        /// 三级背景色 (分组背景)
        static var tertiaryBackground: UIColor {
            return .tertiarySystemBackground
        }

        /// 分组背景
        static var groupedBackground: UIColor {
            return .systemGroupedBackground
        }

        // MARK: - Text

        /// 主要文本色
        static var text: UIColor {
            return UIColor(hexString: "#616161") ?? .gray
        }

        /// 次要文本色
        static var secondaryText: UIColor {
            return .secondaryLabel
        }

        /// 占位符颜色
        static var placeholderText: UIColor {
            return .placeholderText
        }

        // MARK: - Status

        static var success: UIColor {
            return .systemGreen
        }

        static var warning: UIColor {
            return .systemOrange
        }

        static var error: UIColor {
            return .systemRed
        }

        // MARK: - Separator

        /// 分割线颜色
        static var separator: UIColor {
            return .separator
        }

        static var orange: UIColor {
            return .orange
        }
    }

    enum Font {
        private static func font(ofSize size: CGFloat, weight: UIFont.Weight) -> UIFont {
            return UIFont.systemFont(ofSize: size, weight: weight)
        }

        /// 大标题，用于页面标题
        static var largeTitle: UIFont { return font(ofSize: 34, weight: .bold) }

        /// 中等标题
        static var title1: UIFont { return font(ofSize: 28, weight: .bold) }

        /// 小标题
        static var title2: UIFont { return font(ofSize: 22, weight: .semibold) }

        /// 导航栏标题/重要按钮文字
        static var headline: UIFont { return font(ofSize: 17, weight: .semibold) }

        /// 正文文本
        static var body: UIFont { return font(ofSize: 17, weight: .regular) }

        /// 次要正文/按钮文字
        static var callout: UIFont { return font(ofSize: 16, weight: .regular) }

        /// 副标题
        static var subheadline: UIFont { return font(ofSize: 15, weight: .regular) }

        /// 辅助性文字，如脚注
        static var footnote: UIFont { return font(ofSize: 13, weight: .regular) }

        /// 最小号文字，如标签、说明
        static var caption: UIFont { return font(ofSize: 12, weight: .regular) }
    }

    // 定义布局相关的间距和尺寸 (通常保持不变)
    enum Spacing {
        /// 超小间距 (4pt)
        static let xSmall: CGFloat = 4.0
        /// 小间距 (8pt)
        static let small: CGFloat = 8.0
        /// 中等间距 (16pt)
        static let medium: CGFloat = 16.0
        /// 大间距 (20pt)
        static let large: CGFloat = 20.0
        /// 超大间距 (32pt)
        static let xLarge: CGFloat = 32.0

        /// 默认水平边距（常用于页面左右留白，18pt）
        static let horizontal: CGFloat = 18.0

        /// 默认垂直边距（常用于顶部/底部留白，16pt）
        static let vertical: CGFloat = medium

        /// 左边距（默认与 horizontal 一致）
        static let leading: CGFloat = horizontal

        /// 右边距（默认与 horizontal 一致）
        static let trailing: CGFloat = horizontal

        /// 上边距
        static let top: CGFloat = vertical

        /// 下边距
        static let bottom: CGFloat = vertical

        /// 内容内边距（例如容器的 padding，上下左右均为 medium）
        static let padding: CGFloat = medium

        /// 宽松型边距（适用于宽松布局，如 24pt 或 32pt）
        static let spacious: CGFloat = large

        /// 表单项左右边距（常用于 Form 或 List，20pt）
        static let formHorizontal: CGFloat = 20.0

        /// 弹窗或卡片内边距
        static let cardPadding: CGFloat = medium
    }

    // 定义圆角规范 (通常保持不变)
    enum CornerRadius {
        /// 小圆角，用于按钮、输入框等 8
        static let small: CGFloat = 8.0
        /// 中圆角，用于卡片视图 12
        static let medium: CGFloat = 12.0
        /// 大圆角，用于弹窗或全屏视图 20
        static let large: CGFloat = 20.0
    }

    // 定义动画时间
    enum Animation {
        enum Duration {
            /// 快速动画 (0.25s) - 用于微小交互反馈
            static let fast: TimeInterval = 0.25

            /// 标准动画 (0.35s) - 用于界面切换、弹窗
            static let normal: TimeInterval = 0.35

            /// 慢速动画 (0.5s) - 用于较大幅度的界面变化
            static let slow: TimeInterval = 0.50

            /// 图表动画 (1.0s) - 用于数据可视化展示
            static let chart: TimeInterval = 1.0
            
            /// 延迟时间 (2.0s) - 用于执行延迟时间
            static let after: TimeInterval = 2.0

        }
    }
}

extension UIColor {
    /// 通过 .theme. 来访问 APPTheme 中定义的颜色
    /// 例如: view.backgroundColor = .theme.background
    static let theme = APPTheme.Color.self
}

extension UIFont {
    /// 通过 .theme. 来访问 APPTheme 中定义的字体
    /// 例如: label.font = UIFont.theme.body
    static let theme = APPTheme.Font.self
}

extension CGFloat {
    static let theme = APPTheme.CornerRadius.self
}

extension TimeInterval {
    static let theme = APPTheme.Animation.Duration.self
}
