import 'package:flutter/material.dart';

/// 徽章 ID 枚举（按类别分组，类别内相邻）
enum BadgeId {
  // ── 类别1: 入门 ──
  beginner,    // 开始学习
  explorer,     // 探索者

  // ── 类别2: 词语 ──
  wordLearner, // 词语新手
  wordKnight,  // 词语骑士
  wordMaster,  // 词语大师
  wordLegend,  // 词语传奇

  // ── 类别3: 成语 ──
  idiomFirst,   // 成语启蒙
  idiomAdept,  // 成语熟练
  idiomMaster, // 成语大师

  // ── 类别4: 谚语 ──
  proverbFirst, // 谚语启蒙
  proverbAdept,// 谚语熟练
  proverbSage, // 谚语智者

  // ── 类别5: 连续学习 ──
  streak3,     // 坚持不懈
  streak7,     // 一周勇士
  streak14,    // 双周达人
  streak30,    // 月度冠军
  streak100,   // 百日英雄

  // ── 类别6: 诗词 ──
  poemLover,   // 诗词爱好者
  poemScholar, // 诗词学者

  // ── 类别7: 收藏 ──
  collector,   // 收藏达人
  treasureHunter, // 宝藏猎人
}

/// 徽章定义（不含动态数据，纯静态配置）
class BadgeDef {
  final BadgeId id;
  final String titleKey;   // l10n key
  final String descKey;    // l10n key
  final IconData icon;
  final Color color;

  const BadgeDef({
    required this.id,
    required this.titleKey,
    required this.descKey,
    required this.icon,
    required this.color,
  });

  /// 全部徽章定义（顺序即为展示顺序）
  static const List<BadgeDef> all = [
    // ── 类别1: 入门 ──
    BadgeDef(
      id: BadgeId.beginner,
      titleKey: 'badgeBeginner',
      descKey: 'badgeBeginnerDesc',
      icon: Icons.star_rounded,
      color: Color(0xFFFFB300),
    ),
    BadgeDef(
      id: BadgeId.explorer,
      titleKey: 'badgeExplorer',
      descKey: 'badgeExplorerDesc',
      icon: Icons.explore_rounded,
      color: Color(0xFF00BCD4),
    ),

    // ── 类别2: 词语 ──
    BadgeDef(
      id: BadgeId.wordLearner,
      titleKey: 'badgeWordLearner',
      descKey: 'badgeWordLearnerDesc',
      icon: Icons.auto_stories_rounded,
      color: Color(0xFF4285F4),
    ),
    BadgeDef(
      id: BadgeId.wordKnight,
      titleKey: 'badgeWordKnight',
      descKey: 'badgeWordKnightDesc',
      icon: Icons.shield_rounded,
      color: Color(0xFF1E88E5),
    ),
    BadgeDef(
      id: BadgeId.wordMaster,
      titleKey: 'badgeWordMaster',
      descKey: 'badgeWordMasterDesc',
      icon: Icons.military_tech_rounded,
      color: Color(0xFF6A1B9A),
    ),
    BadgeDef(
      id: BadgeId.wordLegend,
      titleKey: 'badgeWordLegend',
      descKey: 'badgeWordLegendDesc',
      icon: Icons.diamond_rounded,
      color: Color(0xFFE91E63),
    ),

    // ── 类别3: 成语 ──
    BadgeDef(
      id: BadgeId.idiomFirst,
      titleKey: 'badgeIdiomFirst',
      descKey: 'badgeIdiomFirstDesc',
      icon: Icons.lightbulb_outline_rounded,
      color: Colors.orange,
    ),
    BadgeDef(
      id: BadgeId.idiomAdept,
      titleKey: 'badgeIdiomAdept',
      descKey: 'badgeIdiomAdeptDesc',
      icon: Icons.emoji_objects_rounded,
      color: Color(0xFFFF8F00),
    ),
    BadgeDef(
      id: BadgeId.idiomMaster,
      titleKey: 'badgeIdiomMaster',
      descKey: 'badgeIdiomMasterDesc',
      icon: Icons.auto_awesome_rounded,
      color: Color(0xFFD84315),
    ),

    // ── 类别4: 谚语 ──
    BadgeDef(
      id: BadgeId.proverbFirst,
      titleKey: 'badgeProverbFirst',
      descKey: 'badgeProverbFirstDesc',
      icon: Icons.format_quote_rounded,
      color: Color(0xFF00796B),
    ),
    BadgeDef(
      id: BadgeId.proverbAdept,
      titleKey: 'badgeProverbAdept',
      descKey: 'badgeProverbAdeptDesc',
      icon: Icons.menu_book_rounded,
      color: Color(0xFF388E3C),
    ),
    BadgeDef(
      id: BadgeId.proverbSage,
      titleKey: 'badgeProverbSage',
      descKey: 'badgeProverbSageDesc',
      icon: Icons.school_rounded,
      color: Color(0xFF1B5E20),
    ),

    // ── 类别5: 连续学习 ──
    BadgeDef(
      id: BadgeId.streak3,
      titleKey: 'badgeStreak3',
      descKey: 'badgeStreak3Desc',
      icon: Icons.local_fire_department_rounded,
      color: Color(0xFFFF5722),
    ),
    BadgeDef(
      id: BadgeId.streak7,
      titleKey: 'badgeStreak7',
      descKey: 'badgeStreak7Desc',
      icon: Icons.whatshot_rounded,
      color: Color(0xFFD32F2F),
    ),
    BadgeDef(
      id: BadgeId.streak14,
      titleKey: 'badgeStreak14',
      descKey: 'badgeStreak14Desc',
      icon: Icons.celebration_rounded,
      color: Color(0xFFC2185B),
    ),
    BadgeDef(
      id: BadgeId.streak30,
      titleKey: 'badgeStreak30',
      descKey: 'badgeStreak30Desc',
      icon: Icons.emoji_events_rounded,
      color: Color(0xFF7B1FA2),
    ),
    BadgeDef(
      id: BadgeId.streak100,
      titleKey: 'badgeStreak100',
      descKey: 'badgeStreak100Desc',
      icon: Icons.workspace_premium_rounded,
      color: Color(0xFFFFD700),
    ),

    // ── 类别6: 诗词 ──
    BadgeDef(
      id: BadgeId.poemLover,
      titleKey: 'badgePoemLover',
      descKey: 'badgePoemLoverDesc',
      icon: Icons.nightlight_round,
      color: Color(0xFF5C6BC0),
    ),
    BadgeDef(
      id: BadgeId.poemScholar,
      titleKey: 'badgePoemScholar',
      descKey: 'badgePoemScholarDesc',
      icon: Icons.auto_fix_high_rounded,
      color: Color(0xFF303F9F),
    ),

    // ── 类别7: 收藏 ──
    BadgeDef(
      id: BadgeId.collector,
      titleKey: 'badgeCollector',
      descKey: 'badgeCollectorDesc',
      icon: Icons.favorite_rounded,
      color: Color(0xFFE91E63),
    ),
    BadgeDef(
      id: BadgeId.treasureHunter,
      titleKey: 'badgeTreasureHunter',
      descKey: 'badgeTreasureHunterDesc',
      icon: Icons.stars_rounded,
      color: Color(0xFFFF4081),
    ),
  ];

  /// 根据 id 查找定义
  static BadgeDef? find(BadgeId id) {
    try {
      return all.firstWhere((b) => b.id == id);
    } catch (_) {
      return null;
    }
  }
}
