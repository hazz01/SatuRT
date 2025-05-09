import 'package:flutter/material.dart';
import '../../widgets/bottom_navbar_admin.dart';
import '../../widgets/cctv_grid_item.dart';
import '../../widgets/cctv_player.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/models/cctv.dart';

class KelolaCctvPage extends StatefulWidget {
  const KelolaCctvPage({super.key});

  @override
  State<KelolaCctvPage> createState() => _KelolaCctvPageState();
}

class _KelolaCctvPageState extends State<KelolaCctvPage> {
  bool _isViewingCctv = false;
  CCTV? _selectedCctv;

  // Sample CCTV data
  final List<CCTV> _cctvList = [
    CCTV(
      id: '1',
      name: 'CCTV 1',
      location: 'Jl. Mahmud',
      imageUrl: 'assets/images/cctv_placeholder.jpg',
    ),
    CCTV(
      id: '2',
      name: 'CCTV 2',
      location: 'Depan Pak No',
      imageUrl: 'assets/images/cctv_placeholder.jpg',
    ),
    CCTV(
      id: '3',
      name: 'CCTV 1',
      location: 'Jl. Mahmud',
      imageUrl: 'assets/images/cctv_placeholder.jpg',
    ),
    CCTV(
      id: '4',
      name: 'CCTV 2',
      location: 'Depan Pak No',
      imageUrl: 'assets/images/cctv_placeholder.jpg',
    ),
    CCTV(
      id: '5',
      name: 'CCTV 1',
      location: 'Jl. Mahmud',
      imageUrl: 'assets/images/cctv_placeholder.jpg',
    ),
    CCTV(
      id: '6',
      name: 'CCTV 2',
      location: 'Depan Pak No',
      imageUrl: 'assets/images/cctv_placeholder.jpg',
    ),
  ];

  void _viewCctv(CCTV cctv) {
    setState(() {
      _selectedCctv = cctv;
      _isViewingCctv = true;
    });
  }

  void _goBack() {
    setState(() {
      _isViewingCctv = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Kelola Keuangan - CCTV'),
      //   centerTitle: true,
      //   leading: _isViewingCctv
      //       ? IconButton(
      //           icon: const Icon(Icons.arrow_back),
      //           onPressed: _goBack,
      //         )
      //       : null,
      // ),
      body: _isViewingCctv
          ? _buildCctvViewPage()
          : _buildCctvListPage(),
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

  Widget _buildCctvListPage() {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(20.0),
          child: Text(
            'List CCTV',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1.0,
            ),
            itemCount: _cctvList.length,
            itemBuilder: (context, index) {
              return CctvGridItem(
                cctv: _cctvList[index],
                onTap: () => _viewCctv(_cctvList[index]),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCctvViewPage() {
    if (_selectedCctv == null) return const SizedBox.shrink();
    
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(20.0),
          child: Text(
            'Rekaman CCTV',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          child: CctvPlayer(
            cctv: _selectedCctv!,
          ),
        ),
      ],
    );
  }
}
