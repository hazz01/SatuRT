import 'package:flutter/material.dart';
import '../../widgets/bottom_navbar_admin.dart';

class KelolaKeuanganPage extends StatelessWidget {
  const KelolaKeuanganPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Kelola Keuangan')),
      body: const Center(child: Text('Halaman Kelola Warga')),
      bottomNavigationBar: BottomNavbarAdmin(
        currentIndex: 1,
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
