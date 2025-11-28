import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

// Importações de TODAS as telas
import 'services/chamada_service.dart';
import 'screens/dashboard_screen.dart';
import 'screens/history_screen.dart';
import 'screens/export_screen.dart';
import 'screens/status_geral_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ChamadaService()),
      ],
      child: MaterialApp(
        title: 'Chamada N10',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          // Paleta baseada na cor principal
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          scaffoldBackgroundColor: Colors.grey.shade50,
          // Tipografia mais limpa
          textTheme: const TextTheme(
            titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            bodyMedium: TextStyle(fontSize: 14),
            bodySmall: TextStyle(fontSize: 12, color: Colors.black54),
          ),
          // Estilo padrão para os Cards
          cardTheme: CardThemeData(
            color: Colors.white,
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            margin: const EdgeInsets.symmetric(vertical: 6),
          ),
          // Estilo padrão para a AppBar
          appBarTheme: AppBarTheme(
            backgroundColor: ColorScheme.fromSeed(seedColor: Colors.deepPurple).primary,
            foregroundColor: ColorScheme.fromSeed(seedColor: Colors.deepPurple).onPrimary,
            centerTitle: true,
            elevation: 2,
            toolbarHeight: 60,
            titleTextStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.white),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              textStyle: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          outlinedButtonTheme: OutlinedButtonThemeData(
            style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
          ),
          listTileTheme: const ListTileThemeData(
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          ),
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: ColorScheme.fromSeed(seedColor: Colors.deepPurple).secondary,
            foregroundColor: ColorScheme.fromSeed(seedColor: Colors.deepPurple).onSecondary,
          ),
        ),
        // Dark theme (usa a mesma seed, mas em brilho escuro)
        darkTheme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple, brightness: Brightness.dark),
          useMaterial3: true,
          scaffoldBackgroundColor: Colors.grey.shade900,
          textTheme: const TextTheme(
            titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            bodyMedium: TextStyle(fontSize: 14),
            bodySmall: TextStyle(fontSize: 12, color: Colors.white70),
          ),
          cardTheme: CardThemeData(
            color: Colors.grey.shade800,
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            margin: const EdgeInsets.symmetric(vertical: 6),
          ),
          appBarTheme: AppBarTheme(
            backgroundColor: ColorScheme.fromSeed(seedColor: Colors.deepPurple, brightness: Brightness.dark).primary,
            foregroundColor: ColorScheme.fromSeed(seedColor: Colors.deepPurple, brightness: Brightness.dark).onPrimary,
            centerTitle: true,
            elevation: 2,
            toolbarHeight: 60,
            titleTextStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.white),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              textStyle: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          outlinedButtonTheme: OutlinedButtonThemeData(
            style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
          ),
          listTileTheme: const ListTileThemeData(
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          ),
        ),
        // Use o tema do sistema (dark/light). Pode ser alterado para ThemeMode.dark se quiser forçar.
        themeMode: ThemeMode.system,

        // --- SISTEMA DE ROTAS ---
        // Define a tela inicial
        initialRoute: '/',

        // Mapa de navegação
        routes: {
          '/': (context) => const DashboardScreen(), // Home
          '/historico': (context) => const HistoryScreen(),
          '/exportar': (context) => const ExportScreen(),
          '/status_geral': (context) => const StatusGeralScreen(),
        },
      ),
    );
  }
}