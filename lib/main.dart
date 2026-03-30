import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:window_manager/window_manager.dart';
import 'app_state.dart';
import 'router.dart';

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

class ChineseGoApp extends StatelessWidget {
  const ChineseGoApp({super.key});

  @override
  Widget build(BuildContext context) {
    final router = buildRouter(context);
    return MaterialApp.router(
      title: '汉语通',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF4285F4)),
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
      routerConfig: router,
    );
  }
}
