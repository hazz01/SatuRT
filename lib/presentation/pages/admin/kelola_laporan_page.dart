import 'package:flutter/material.dart';
import '../../widgets/bottom_navbar_admin.dart';
import '../../widgets/report_list_item.dart';
import '../../widgets/filter_modal.dart';
import '../../widgets/report_detail.dart';
import '../../widgets/escalation_form.dart';
import '../../../core/constants/app_colors.dart';

class KelolaLaporanPage extends StatefulWidget {
  const KelolaLaporanPage({super.key});

  @override
  State<KelolaLaporanPage> createState() => _KelolaCctvPageState();
}

class _KelolaCctvPageState extends State<KelolaLaporanPage> {
  int _currentPageIndex = 0;
  Map<String, dynamic>? _selectedReport;
  
  final List<Map<String, dynamic>> _reports = [
    {
      'title': 'Suki Liar Berkeliaran',
      'location': 'Kecamatan',
      'date': '01/05/2023',
      'reporter': 'Budi Hartono',
      'nik': '099900090797',
      'fullLocation': 'Jl. Merdeka No.10 Kebayoran Baru',
      'category': 'Keamanan',
      'description': 'Tolong Pak Ada Anjing gede banget di sekitar rumah saya',
      'status': 'Proses',
    },
    {
      'title': 'Anjing Liar Berkeliaran',
      'location': 'Kecamatan',
      'date': '01/05/2023',
      'reporter': 'Budi Hartono',
      'nik': '099900090797',
      'fullLocation': 'Jl. Merdeka No.10 Kebayoran Baru',
      'category': 'Keamanan',
      'description': 'Tolong Pak Ada Anjing gede banget di sekitar rumah saya',
      'status': 'Proses',
    },
    {
      'title': 'Anjing Liar Berkeliaran',
      'location': 'Kecamatan',
      'date': '01/05/2023',
      'reporter': 'Budi Hartono',
      'nik': '099900090797',
      'fullLocation': 'Jl. Merdeka No.10 Kebayoran Baru',
      'category': 'Keamanan',
      'description': 'Tolong Pak Ada Anjing gede banget di sekitar rumah saya',
      'status': 'Proses',
    },
  ];

  void _showFilterModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => FilterModal(
        onApply: (filters) {
          // Apply filters logic
          Navigator.pop(context);
        }, onCancel: () {  },
      ),
    );
  }

  void _viewReportDetail(Map<String, dynamic> report) {
    setState(() {
      _selectedReport = report;
      _currentPageIndex = 2;
    });
  }

  void _showEscalationForm() {
    setState(() {
      _currentPageIndex = 4;
    });
  }

  void _goBack() {
    setState(() {
      if (_currentPageIndex == 3 || _currentPageIndex == 4) {
        _currentPageIndex = 2;
      } else if (_currentPageIndex == 2) {
        _currentPageIndex = 0;
      }
    });
  }

  void _processReport() {
    setState(() {
      _currentPageIndex = 3;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _currentPageIndex <= 1 
              ? 'Kelola Data Warga - Show Data'
              : _currentPageIndex == 4 
                  ? 'Form Eskalasi'
                  : 'Detail Laporan',
        ),
        centerTitle: true,
        leading: _currentPageIndex >= 2 
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: _goBack,
              )
            : null,
        actions: _currentPageIndex <= 1 
            ? [
                IconButton(
                  icon: const Icon(Icons.filter_list),
                  onPressed: _showFilterModal,
                ),
              ]
            : null,
      ),
      body: IndexedStack(
        index: _currentPageIndex,
        children: [
          // Page 0: Report List
          _buildReportListPage(),
          
          // Page 1: Filter Page (shown as modal)
          Container(),
          
          // Page 2: Report Detail
          if (_selectedReport != null)
            ReportDetail(
              report: _selectedReport!,
              onProcess: _processReport,
              onEscalate: () {
                setState(() {
                  _currentPageIndex = 4;
                });
              },
              showProcessButton: true,
            ),
            
          // Page 3: Report Detail with Complete Button
          if (_selectedReport != null)
            ReportDetail(
              report: _selectedReport!,
              onComplete: () {
                // Handle completion logic
                setState(() {
                  _currentPageIndex = 0;
                });
              },
              showCompleteButton: true,
            ),
            
          // Page 4: Escalation Form
          EscalationForm(
            onSubmit: (data) {
              // Handle escalation submission
              setState(() {
                _currentPageIndex = 0;
              });
            },
            onCancel: _goBack,
          ),
        ],
      ),
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

  Widget _buildReportListPage() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Cari Laporan Warga',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.grey[200],
              contentPadding: const EdgeInsets.symmetric(vertical: 0),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.blue[100],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.location_on, size: 16, color: Colors.blue),
                    const SizedBox(width: 4),
                    const Text('Kecamatan', style: TextStyle(fontSize: 12)),
                    const SizedBox(width: 4),
                    InkWell(
                      onTap: () {
                        // Remove filter
                      },
                      child: const Icon(Icons.close, size: 16, color: Colors.blue),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.blue[100],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.category, size: 16, color: Colors.blue),
                    const SizedBox(width: 4),
                    const Text('RT 8', style: TextStyle(fontSize: 12)),
                    const SizedBox(width: 4),
                    InkWell(
                      onTap: () {
                        // Remove filter
                      },
                      child: const Icon(Icons.close, size: 16, color: Colors.blue),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: _reports.length,
            itemBuilder: (context, index) {
              return ReportListItem(
                report: _reports[index],
                onTap: () => _viewReportDetail(_reports[index]),
              );
            },
          ),
        ),
      ],
    );
  }
}
