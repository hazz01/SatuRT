import 'package:flutter/material.dart';
import '../../widgets/bottom_navbar_admin.dart';

class KelolaLaporanPage extends StatelessWidget {
  const KelolaLaporanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Kelola Laporan Warga')),
      body: const Center(child: Text('Halaman Kelola Laporan Warga')),
      bottomNavigationBar: BottomNavbarAdmin(
        currentIndex: 4,
        onTap: (index) {
          switch (index) {
            case 0: Navigator.pushNamed(context, '/admin/home'); break;
            case 1: Navigator.pushNamed(context, '/admin/keuangan'); break;
            case 2: Navigator.pushNamed(context, '/admin/cctv'); break;
            case 3: Navigator.pushNamed(context, '/admin/surat'); break;
            case 4: Navigator.pushNamed(context, '/admin/laporan'); break;
          }
        },
      ),
    );
  }
}
