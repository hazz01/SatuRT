import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kelola Pengajuan Surat',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const KelolaSuratPage(),
    );
  }
}

class KelolaSuratPage extends StatefulWidget {
  const KelolaSuratPage({super.key});

  @override
  State<KelolaSuratPage> createState() => _KelolaSuratPageState();
}

class _KelolaSuratPageState extends State<KelolaSuratPage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kelola Data Warga - Show All'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: const [
          DaftarSuratScreen(),
          FilterSuratScreen(),
          DetailPengajuanScreen(),
          AlasanPenolakanScreen(),
          PreviewSuratScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavbarAdmin(
        currentIndex: 3,
        onTap: (index) {
          // Navigation logic would go here
        },
      ),
    );
  }
}

// Screen 1: Daftar Surat
class DaftarSuratScreen extends StatelessWidget {
  const DaftarSuratScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          // Search bar
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
            ),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Cari Surat Permohonan',
                prefixIcon: const Icon(Icons.search),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Filter buttons
          Row(
            children: [
              Expanded(
                child: FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {},
                  child: const Text('Surat Izin'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.blue,
                    side: const BorderSide(color: Colors.blue),
                  ),
                  onPressed: () {},
                  child: const Text('Surat Permohonan'),
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 16),
          
          // List of letters
          Expanded(
            child: ListView(
              children: const [
                SuratListItem(
                  title: 'Surat Izin Kegiatan KKN',
                  subtitle: 'Budi Hartono',
                  date: '01/01/2023',
                ),
                SuratListItem(
                  title: 'Surat Izin Kegiatan KKN',
                  subtitle: 'Budi Hartono',
                  date: '01/01/2023',
                ),
                SuratListItem(
                  title: 'Surat Izin Kegiatan KKN',
                  subtitle: 'Budi Hartono',
                  date: '01/01/2023',
                ),
                SuratListItem(
                  title: 'Surat Izin Kegiatan KKN',
                  subtitle: 'Budi Hartono',
                  date: '01/01/2023',
                  isLoading: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Screen 2: Filter Surat
class FilterSuratScreen extends StatelessWidget {
  const FilterSuratScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search bar
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
            ),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Cari Surat Permohonan',
                prefixIcon: const Icon(Icons.search),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Filter buttons
          Row(
            children: [
              Expanded(
                child: FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.blue,
                    side: const BorderSide(color: Colors.blue),
                  ),
                  onPressed: () {},
                  child: const Text('Surat Izin'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.blue,
                    side: const BorderSide(color: Colors.blue),
                  ),
                  onPressed: () {},
                  child: const Text('Surat Permohonan'),
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 16),
          
          // Filter dialog
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Filter',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.close),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ],
                ),
                
                const SizedBox(height: 16),
                
                // Filter options
                const FilterOption(title: 'Filter Jenis Surat', hasArrow: true),
                const SizedBox(height: 16),
                
                const Text('Filter Tanggal Mulai'),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Row(
                    children: [
                      Text('Tanggal / Bulan / Tahun', style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                ),
                
                const SizedBox(height: 16),
                
                const Text('Filter Tanggal Akhir'),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Row(
                    children: [
                      Text('Tanggal / Bulan / Tahun', style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                ),
                
                const SizedBox(height: 24),
                
                // Action buttons
                Row(
                  children: [
                    Expanded(
                      child: FilledButton(
                        style: FilledButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: () {},
                        child: const Text('Apply'),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.blue,
                        ),
                        onPressed: () {},
                        child: const Text('Cancel'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 16),
          
          // List of letters (hidden behind the filter dialog)
          const SuratListItem(
            title: 'Surat Izin Kegiatan KKN',
            subtitle: 'Budi Hartono',
            date: '01/01/2023',
          ),
        ],
      ),
    );
  }
}

// Screen 3: Detail Pengajuan
class DetailPengajuanScreen extends StatelessWidget {
  const DetailPengajuanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Back button
          const Row(
            children: [
              Icon(Icons.arrow_back),
              SizedBox(width: 16),
              Text(
                'Detail Pengajuan',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 24),
          
          // Information section
          const Text('Informasi Pemohon', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          
          // Pemohon details
          const InfoField(label: 'Nama', value: 'Budi Hartono'),
          const InfoField(label: 'NIK', value: '0989900009970'),
          const InfoField(label: 'Alamat', value: 'Jl. Merdeka No.10\nKelayapan Biru'),
          const InfoField(label: 'Jenis Surat', value: 'Surat Izin Kegiatan KKN'),
          
          const SizedBox(height: 16),
          
          // Deskripsi
          const Text('Deskripsi', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          const Text(
            'Saya izin buat ikm pak, mohon tanya',
          ),
          
          const Spacer(),
          
          // Action buttons
          Row(
            children: [
              Expanded(
                child: FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {},
                  child: const Text('Terima'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: Colors.red[100],
                    foregroundColor: Colors.red,
                  ),
                  onPressed: () {},
                  child: const Text('Tolak'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Screen 4: Alasan Penolakan
class AlasanPenolakanScreen extends StatelessWidget {
  const AlasanPenolakanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Back button
          const Row(
            children: [
              Icon(Icons.arrow_back),
              SizedBox(width: 16),
              Text(
                'Alasan Penolakan',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 16),
          
          // Masukkan alasan penolakan
          const Text('Masukkan Alasan Penolakan'),
          const SizedBox(height: 8),
          
          // Text area for reason
          Container(
            height: 150,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const TextField(
              maxLines: null,
              decoration: InputDecoration.collapsed(
                hintText: 'Tulis alasan penolakan di sini...',
              ),
            ),
          ),
          
          const Spacer(),
          
          // Submit button
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              minimumSize: const Size.fromHeight(50),
            ),
            onPressed: () {},
            child: const Text('Tolak'),
          ),
        ],
      ),
    );
  }
}

// Screen 5: Preview Surat
class PreviewSuratScreen extends StatelessWidget {
  const PreviewSuratScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Back button
          const Row(
            children: [
              Icon(Icons.arrow_back),
              SizedBox(width: 16),
              Text(
                'Preview Surat',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 24),
          
          // Preview document
          Expanded(
            child: Center(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Isi Surat Ditampilkan di sini',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Action buttons
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              minimumSize: const Size.fromHeight(50),
            ),
            onPressed: () {},
            child: const Text('Tolak'),
          ),
          
          const SizedBox(height: 12),
          
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              minimumSize: const Size.fromHeight(50),
            ),
            onPressed: () {},
            child: const Text('Teruskan'),
          ),
        ],
      ),
    );
  }
}

// --- Reusable Widgets ---

// Bottom Navigation Bar
class BottomNavbarAdmin extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavbarAdmin({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_balance_wallet),
          label: 'Keuangan',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.videocam),
          label: 'CCTV',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.mail),
          label: 'Surat',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.description),
          label: 'Laporan',
        ),
      ],
    );
  }
}

// Letter List Item
class SuratListItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final String date;
  final bool isLoading;

  const SuratListItem({
    super.key,
    required this.title,
    required this.subtitle,
    required this.date,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 4),
          Text(subtitle),
          Text(date, style: TextStyle(color: Colors.grey.shade600)),
          const SizedBox(height: 8),
          if (isLoading)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                5,
                (index) => Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            )
          else
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  foregroundColor: Colors.blue,
                  padding: EdgeInsets.zero,
                  minimumSize: const Size(0, 0),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: const Text('Lihat Detail'),
              ),
            ),
        ],
      ),
    );
  }
}

// Filter Option
class FilterOption extends StatelessWidget {
  final String title;
  final bool hasArrow;

  const FilterOption({
    super.key,
    required this.title,
    this.hasArrow = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title),
        if (hasArrow) const Icon(Icons.arrow_forward_ios, size: 16),
      ],
    );
  }
}

// Info Field
class InfoField extends StatelessWidget {
  final String label;
  final String value;

  const InfoField({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}