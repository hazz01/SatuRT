import 'package:flutter/material.dart';
import '../pages/admin/kelola_cctv_page.dart';
import '../pages/admin/kelola_keuangan_page.dart';
import '../pages/admin/kelola_laporan_page.dart';
import '../pages/admin/kelola_surat_page.dart';
import '../pages/admin/kelola_warga_page.dart';
import '../pages/login_page.dart';
import '../pages/splash_page.dart';

class AppRoutes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/admin/home':
        return MaterialPageRoute(builder: (_) => const KelolaWargaPage());
      case '/admin/keuangan':
        return MaterialPageRoute(builder: (_) => const KelolaKeuanganPage());
      case '/admin/cctv':
        return MaterialPageRoute(builder: (_) => const KelolaCctvPage());
      case '/admin/surat':
        return MaterialPageRoute(builder: (_) => const KelolaSuratPage());    
      case '/admin/laporan':
        return MaterialPageRoute(builder: (_) => const KelolaLaporanPage());
      case '/':
        return MaterialPageRoute(builder: (_) => const SplashPage());
      case '/login':
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case '/warga/home':
        return MaterialPageRoute(
            builder: (_) => const Scaffold(
                  body: Center(child: Text('Home Warga (under development)')),
                ));

      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('Page not found')),
          ),
        );
    }
  }
}
