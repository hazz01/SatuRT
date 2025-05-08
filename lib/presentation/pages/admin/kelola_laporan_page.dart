import 'package:flutter/material.dart';


// Models
class Report {
  final String id;
  final String title;
  final String category;
  final String location;
  final String reporterName;
  final String nik;
  final String description;
  final DateTime date;
  final ReportStatus status;

  Report({
    required this.id,
    required this.title,
    required this.category,
    required this.location,
    required this.reporterName,
    required this.nik,
    required this.description,
    required this.date,
    required this.status,
  });
}

enum ReportStatus { process, completed, needsEscalation, receivedOffline }

// Sample Data
final List<Report> sampleReports = [
  Report(
    id: '1',
    title: 'Anjing Liar Berkeliaran',
    category: 'Keamanan',
    location: 'Jl. Merdeka No.10 Kelayaran Baru',
    reporterName: 'Budi Hartono',
    nik: '099900907970',
    description: 'Tolong Pak Ada Anjing gede banget di sekitar rumah saya',
    date: DateTime(2025, 4, 20),
    status: ReportStatus.process,
  ),
  Report(
    id: '2',
    title: 'Anjing Liar Berkeliaran',
    category: 'Keamanan',
    location: 'Jl. Merdeka No.10 Kelayaran Baru',
    reporterName: 'Budi Hartono',
    nik: '099900907970',
    description: 'Tolong Pak Ada Anjing gede banget di sekitar rumah saya',
    date: DateTime(2025, 4, 20),
    status: ReportStatus.process,
  ),
  Report(
    id: '3',
    title: 'Anjing Liar Berkeliaran',
    category: 'Keamanan',
    location: 'Jl. Merdeka No.10 Kelayaran Baru',
    reporterName: 'Budi Hartono',
    nik: '099900907970',
    description: 'Tolong Pak Ada Anjing gede banget di sekitar rumah saya',
    date: DateTime(2025, 4, 20),
    status: ReportStatus.process,
  ),
];

// Main Screen - Report List
class ReportListScreen extends StatefulWidget {
  const ReportListScreen({super.key});

  @override
  State<ReportListScreen> createState() => _ReportListScreenState();
}

class _ReportListScreenState extends State<ReportListScreen> {
  bool isFilterVisible = false;
  String? selectedCategory;
  DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kelola Data Warga - Show Data'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SearchBar(
              leading: const Icon(Icons.search),
              hintText: 'Cari Laporan Warga',
            ),
          ),
          
          // Filter Tags
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                FilterChip(
                  label: const Row(
                    children: [
                      Icon(Icons.security, size: 16, color: Colors.blue),
                      SizedBox(width: 4),
                      Text('Keamanan', style: TextStyle(color: Colors.blue)),
                    ],
                  ),
                  onSelected: (_) {},
                  backgroundColor: Colors.blue[50],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: const BorderSide(color: Colors.blue),
                  ),
                  showCheckmark: false,
                  selected: false,
                ),
                const SizedBox(width: 8),
                FilterChip(
                  label: const Row(
                    children: [
                      Icon(Icons.location_on, size: 16, color: Colors.blue),
                      SizedBox(width: 4),
                      Text('RT 8', style: TextStyle(color: Colors.blue)),
                    ],
                  ),
                  onSelected: (_) {},
                  backgroundColor: Colors.blue[50],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: const BorderSide(color: Colors.blue),
                  ),
                  showCheckmark: false,
                  selected: false,
                ),
              ],
            ),
          ),
          
          // Reports List
          Expanded(
            child: Stack(
              children: [
                // List of Reports
                ListView.builder(
                  padding: const EdgeInsets.all(16.0),
                  itemCount: sampleReports.length,
                  itemBuilder: (context, index) {
                    final report = sampleReports[index];
                    return ReportCard(
                      report: report,
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          '/report_detail',
                          arguments: report,
                        );
                      },
                    );
                  },
                ),
                
                // Filter Dialog
                if (isFilterVisible)
                  FilterDialog(
                    onClose: () {
                      setState(() {
                        isFilterVisible = false;
                      });
                    },
                    onApply: (category, date) {
                      setState(() {
                        selectedCategory = category;
                        selectedDate = date;
                        isFilterVisible = false;
                      });
                    },
                  ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            isFilterVisible = true;
          });
        },
        child: const Icon(Icons.filter_list),
      ),
      bottomNavigationBar: const BottomNavbarAdmin(currentIndex: 4),
    );
  }
}

// Report Card Widget
class ReportCard extends StatelessWidget {
  final Report report;
  final VoidCallback onTap;

  const ReportCard({
    super.key,
    required this.report,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.circle,
                  color: Colors.orange,
                  size: 16,
                ),
                const SizedBox(width: 4),
                const Text(
                  'Proses',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.orange,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              report.title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              report.category,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            Text(
              '${report.date.day}/${report.date.month}/${report.date.year}',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: onTap,
                child: const Text('Lihat Detail'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Filter Dialog Widget
class FilterDialog extends StatefulWidget {
  final Function() onClose;
  final Function(String?, DateTime?) onApply;

  const FilterDialog({
    super.key,
    required this.onClose,
    required this.onApply,
  });

  @override
  State<FilterDialog> createState() => _FilterDialogState();
}

class _FilterDialogState extends State<FilterDialog> {
  String? selectedCategory;
  DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withOpacity(0.5),
      child: Center(
        child: Container(
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
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
                    icon: const Icon(Icons.close),
                    onPressed: widget.onClose,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              
              // RT Filter
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('RT'),
                  Row(
                    children: [
                      const Text('8'),
                      IconButton(
                        icon: const Icon(Icons.chevron_right),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ],
              ),
              
              // RW Filter
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('RW'),
                  Row(
                    children: [
                      const Text('2'),
                      IconButton(
                        icon: const Icon(Icons.chevron_right),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ],
              ),
              
              const Divider(),
              
              // Category Filter
              InkWell(
                onTap: () {
                  // Show category selection dialog
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Kategori Laporan'),
                        Text(
                          'Pilih kategori Laporan',
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                      ],
                    ),
                    IconButton(
                      icon: const Icon(Icons.chevron_right),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
              
              const Divider(),
              
              // Date Filter
              InkWell(
                onTap: () {
                  // Show date picker
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Pilih Tanggal'),
                        Text(
                          'Tanggal / Bulan / Tahun',
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                      ],
                    ),
                    IconButton(
                      icon: const Icon(Icons.chevron_right),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 16),
              
              // Action Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () => widget.onApply(selectedCategory, selectedDate),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Apply'),
                  ),
                  ElevatedButton(
                    onPressed: widget.onClose,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.blue,
                    ),
                    child: const Text('Cancel'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Report Detail Screen
class ReportDetailScreen extends StatelessWidget {
  const ReportDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final report = ModalRoute.of(context)!.settings.arguments as Report;
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Laporan'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Report Info Section
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 2,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Informasi Laporan',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    DetailRow(title: 'Judul Laporan', value: report.title),
                    DetailRow(title: 'Pelapor', value: report.reporterName),
                    DetailRow(title: 'NIK', value: report.nik),
                    DetailRow(title: 'Lokasi', value: report.location),
                    DetailRow(
                      title: 'Tanggal',
                      value: '${report.date.day}/${report.date.month}/${report.date.year}',
                    ),
                    DetailRow(title: 'Kategori Laporan', value: report.category),
                    DetailRow(title: 'Deskripsi', value: report.description),
                    
                    const SizedBox(height: 16),
                    DetailRow(
                      title: 'Status Laporan',
                      value: '',
                      customValueWidget: _buildStatusBadge(report.status),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 24),
              
              // Action Buttons
              if (report.status == ReportStatus.process)
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: const Text('Proses'),
                  ),
                ),
              
              if (report.status == ReportStatus.process)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          '/escalation_form',
                          arguments: report,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red[100],
                        foregroundColor: Colors.red,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: const Text('Perlu Eskalasi'),
                    ),
                  ),
                ),
              
              if (report.status == ReportStatus.process)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: const Text('Selesaikan'),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusBadge(ReportStatus status) {
    Color color;
    String text;
    IconData icon;

    switch (status) {
      case ReportStatus.process:
        color = Colors.orange;
        text = 'Proses';
        icon = Icons.refresh;
        break;
      case ReportStatus.completed:
        color = Colors.green;
        text = 'Selesai';
        icon = Icons.check_circle;
        break;
      case ReportStatus.needsEscalation:
        color = Colors.red;
        text = 'Perlu Eskalasi';
        icon = Icons.warning;
        break;
      case ReportStatus.receivedOffline:
        color = Colors.blue;
        text = 'Belum Ditindak';
        icon = Icons.info;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 4),
          Text(
            text,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

// Escalation Form Screen
class EscalationFormScreen extends StatefulWidget {
  const EscalationFormScreen({super.key});

  @override
  State<EscalationFormScreen> createState() => _EscalationFormScreenState();
}

class _EscalationFormScreenState extends State<EscalationFormScreen> {
  String? selectedDistrict;
  final TextEditingController _additionalNotesController = TextEditingController();
  
  @override
  void dispose() {
    _additionalNotesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final report = ModalRoute.of(context)!.settings.arguments as Report;
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Form Eskalasi'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Tujuan Eskalasi',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              
              const SizedBox(height: 8),
              
              // District Dropdown
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    isExpanded: true,
                    hint: const Text('Kecamatan'),
                    value: selectedDistrict,
                    onChanged: (value) {
                      setState(() {
                        selectedDistrict = value;
                      });
                    },
                    items: const [
                      DropdownMenuItem(
                        value: 'kecamatan_a',
                        child: Text('Kecamatan A'),
                      ),
                      DropdownMenuItem(
                        value: 'kecamatan_b',
                        child: Text('Kecamatan B'),
                      ),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 24),
              
              // Additional Notes
              const Text(
                'Catatan Tambahan',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              
              const SizedBox(height: 8),
              
              TextField(
                controller: _additionalNotesController,
                decoration: const InputDecoration(
                  hintText: 'Tuliskan alasan atau penjelasan tambahan di sini...',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.all(12),
                ),
                maxLines: 3,
              ),
              
              const SizedBox(height: 24),
              
              // Attachment (Optional)
              const Text(
                'Lampiran (Opsional)',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              
              const SizedBox(height: 8),
              
              ElevatedButton.icon(
                onPressed: () {
                  // Handle file picking
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: const BorderSide(color: Colors.grey),
                  ),
                ),
                icon: const Icon(Icons.attach_file),
                label: const Text('Pilih File'),
              ),
              
              const SizedBox(height: 40),
              
              // Action Buttons
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        // Handle escalation submission
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text('Eskalasi'),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text('Batal'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Detail Row Widget (Used in Report Detail Screen)
class DetailRow extends StatelessWidget {
  final String title;
  final String value;
  final Widget? customValueWidget;

  const DetailRow({
    super.key,
    required this.title,
    required this.value,
    this.customValueWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),
          ),
          Expanded(
            child: customValueWidget ??
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
          ),
        ],
      ),
    );
  }
}

// Bottom Navigation Bar for Admin
class BottomNavbarAdmin extends StatelessWidget {
  final int currentIndex;
  final Function(int)? onTap;

  const BottomNavbarAdmin({
    super.key,
    required this.currentIndex,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap ?? (_) {},
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey,
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.attach_money),
          label: 'Keuangan',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.videocam),
          label: 'CCTV',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.description),
          label: 'Surat',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.report),
          label: 'Laporan',
        ),
      ],
    );
  }
}