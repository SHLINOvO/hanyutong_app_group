import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../app_state.dart';

// 语言 flag 映射
const _langFlags = {
  'en': '🇺🇸', 'es': '🇪🇸', 'fr': '🇫🇷', 'de': '🇩🇪',
  'ja': '🇯🇵', 'ko': '🇰🇷', 'pt': '🇵🇹', 'ru': '🇷🇺',
};
const _langNames = {
  'en': 'English', 'es': 'Español', 'fr': 'Français', 'de': 'Deutsch',
  'ja': '日本語', 'ko': '한국어', 'pt': 'Português', 'ru': 'Русский',
};

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Bar
            Row(
              children: [
                _TopButton(
                  child: Row(children: [
                    Text(_langFlags[state.language] ?? '🇺🇸',
                        style: const TextStyle(fontSize: 22)),
                    const SizedBox(width: 8),
                    Text(
                      _langNames[state.language] ?? 'English',
                      style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF666666)),
                    ),
                  ]),
                  onTap: () => _showLanguageSelector(context, state),
                ),
                const SizedBox(width: 8),
                _TopButton(
                  child: Row(children: [
                    const Text('🎯', style: TextStyle(fontSize: 18)),
                    const SizedBox(width: 8),
                    Text(
                      '${state.dailyGoal}分钟',
                      style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF666666)),
                    ),
                  ]),
                  onTap: () => _showGoalSelector(context, state),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Stats Card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFFF0F0F0),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  _StatItem(icon: '🔥', value: '${state.streak}', label1: '连续学习', label2: '天'),
                  _StatItem(icon: '📅', value: '${state.totalDays}', label1: '累计天数', label2: '天'),
                  _StatItem(icon: '⏱', value: '${state.totalHours}', label1: '学习时长', label2: '小时'),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Mastered Card
            _Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('已掌握',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF333333))),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      _StatItem(icon: '📝', value: '${state.masteredWords}', label1: '字词', label2: '个'),
                      _StatItem(icon: '📄', value: '${state.masteredSentences}', label1: '句子', label2: '个'),
                      _StatItem(icon: '⭐', value: '${state.masteredAdvanced}', label1: '高阶', label2: '个'),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => context.push('/review'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4285F4),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                      child: const Text('复习',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // Favorites Card
            GestureDetector(
              onTap: () => context.push('/favorites'),
              child: _Card(
                child: Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 24),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Text('我的收藏',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF333333))),
                    ),
                    const Icon(Icons.chevron_right, color: Color(0xFF999999)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showLanguageSelector(BuildContext context, AppState state) {
    const langs = [
      {'code': 'en', 'name': 'English', 'flag': '🇺🇸'},
      {'code': 'es', 'name': 'Español', 'flag': '🇪🇸'},
      {'code': 'fr', 'name': 'Français', 'flag': '🇫🇷'},
      {'code': 'de', 'name': 'Deutsch', 'flag': '🇩🇪'},
      {'code': 'ja', 'name': '日本語', 'flag': '🇯🇵'},
      {'code': 'ko', 'name': '한국어', 'flag': '🇰🇷'},
      {'code': 'pt', 'name': 'Português', 'flag': '🇵🇹'},
      {'code': 'ru', 'name': 'Русский', 'flag': '🇷🇺'},
    ];
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (_) => ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.all(16),
        children: [
          const Text('选择母语',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center),
          const SizedBox(height: 12),
          ...langs.map((l) => ListTile(
                leading: Text(l['flag']!, style: const TextStyle(fontSize: 24)),
                title: Text(l['name']!),
                trailing: state.language == l['code']
                    ? const Icon(Icons.check, color: Color(0xFF4285F4))
                    : null,
                onTap: () {
                  state.setLanguage(l['code']!);
                  Navigator.pop(context);
                },
              )),
        ],
      ),
    );
  }

  void _showGoalSelector(BuildContext context, AppState state) {
    const goals = [5, 15, 30, 60];
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (_) => ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.all(16),
        children: [
          const Text('每日目标（分钟）',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center),
          const SizedBox(height: 12),
          ...goals.map((g) => ListTile(
                title: Text('$g 分钟'),
                trailing: state.dailyGoal == g
                    ? const Icon(Icons.check, color: Color(0xFF4285F4))
                    : null,
                onTap: () {
                  state.setDailyGoal(g);
                  Navigator.pop(context);
                },
              )),
        ],
      ),
    );
  }
}

class _TopButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onTap;
  const _TopButton({required this.child, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.06),
                blurRadius: 4,
                offset: const Offset(0, 2))
          ],
        ),
        child: child,
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String icon;
  final String value;
  final String label1;
  final String label2;
  const _StatItem(
      {required this.icon,
      required this.value,
      required this.label1,
      required this.label2});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(icon, style: const TextStyle(fontSize: 28)),
          const SizedBox(height: 4),
          Text(value,
              style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF4285F4))),
          Text(label1,
              style: const TextStyle(fontSize: 11, color: Color(0xFF999999))),
          Text(label2,
              style: const TextStyle(fontSize: 11, color: Color(0xFF999999))),
        ],
      ),
    );
  }
}

class _Card extends StatelessWidget {
  final Widget child;
  const _Card({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 6,
              offset: const Offset(0, 2))
        ],
      ),
      child: child,
    );
  }
}
