import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:window_manager/window_manager.dart';
import 'app_state.dart';
import 'router.dart';
import 'config/app_languages.dart';
import 'l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ── Windows 桌面：设置窗口为手机比例 390 × 844 ──
  await windowManager.ensureInitialized();
  const windowOptions = WindowOptions(
    size: Size(390, 844),
    minimumSize: Size(360, 640),
    center: true,
    title: '汉语通',
    titleBarStyle: TitleBarStyle.normal,
  );
  await windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });
  // ─────────────────────────────────────────────────

  final appState = AppState();
  await appState.init();

  runApp(
    ChangeNotifierProvider(
      create: (_) => appState,
      child: const ChineseGoApp(),
    ),
  );
}

class ChineseGoApp extends StatefulWidget {
  const ChineseGoApp({super.key});

  @override
  State<ChineseGoApp> createState() => _ChineseGoAppState();
}

class _ChineseGoAppState extends State<ChineseGoApp> {
  bool _hasShownPopupToday = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final appState = Provider.of<AppState>(context, listen: false);

    // 监听目标达成弹窗
    appState.addListener(() {
      if (appState.showGoalPopup && !_hasShownPopupToday) {
        _hasShownPopupToday = true;
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) {
            _showGoalReachedDialog(context, appState);
          }
        });
      }
    });
  }

  void _showGoalReachedDialog(BuildContext context, AppState appState) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: const Color(0xFF4285F4).withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.celebration,
                size: 60,
                color: Color(0xFF4285F4),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              '🎉',
              style: TextStyle(fontSize: 48),
            ),
            const SizedBox(height: 16),
            const Text(
              '今日目标已达成!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF333333),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              '你已经学习了 ${appState.learningTime} 分钟',
              style: const TextStyle(
                fontSize: 16,
                color: Color(0xFF666666),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              '连续学习: ${appState.streak} 天',
              style: const TextStyle(
                fontSize: 16,
                color: Color(0xFF666666),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  appState.setShowGoalPopup(false);
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4285F4),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  '继续加油',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    ).then((_) {
      // 弹窗关闭后重置标志
      _hasShownPopupToday = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final router = buildRouter(context);
    return Consumer<AppState>(
      builder: (context, appState, _) {
        return MaterialApp.router(
          title: '汉语通',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF4285F4)),
            useMaterial3: true,
            fontFamily: 'Roboto',
          ),
          routerConfig: router,
          // 多语言支持配置
          locale: Locale(appState.language),
          supportedLocales: supportedLocales,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          localeResolutionCallback: (locale, supportedLocales) {
            // 如果用户选择的语言在支持列表中，使用用户选择的语言
            for (var supportedLocale in supportedLocales) {
              if (supportedLocale.languageCode == locale?.languageCode) {
                return supportedLocale;
              }
            }
            // 否则使用英语作为默认语言
            return const Locale('en');
          },
        );
      },
    );
  }
}
