import 'package:flutter/material.dart';
import '../../widgets/bottom_navbar_admin.dart';

class KelolaCctvPage extends StatelessWidget {
  const KelolaCctvPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Kelola CCTV')),
      body: const Center(child: Text('Halaman Kelola Warga')),
      bottomNavigationBar: BottomNavbarAdmin(
        currentIndex: 2,
        onTap: (index) {
          switch (index) {
            case 0: Navigator.pushReplacementNamed(context, '/admin/home'); break;
            case 1: Navigator.pushReplacementNamed(context, '/admin/keuangan'); break;
            case 2: Navigator.pushReplacementNamed(context, '/admin/cctv'); break;
            case 3: Navigator.pushReplacementNamed(context, '/admin/surat'); break;
            case 4: Navigator.pushReplacementNamed(context, '/admin/laporan'); break;
          }
        },
      ),
    );
  }
}
