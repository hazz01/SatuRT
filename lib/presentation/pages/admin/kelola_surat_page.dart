import 'package:flutter/material.dart';
import '../../widgets/bottom_navbar_admin.dart';
import '../../widgets/letter_list_item.dart';
import '../../widgets/filter_modal.dart';
import '../../widgets/letter_detail.dart';
import '../../widgets/rejection_form.dart';
import '../../widgets/letter_preview.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/models/letter_application.dart';

class KelolaSuratPage extends StatefulWidget {
  const KelolaSuratPage({super.key});

  @override
  State<KelolaSuratPage> createState() => _KelolaSuratPageState();
}

class _KelolaSuratPageState extends State<KelolaSuratPage> {
  // Current view state
  int _currentView = 0; // 0: List, 1: Detail, 2: Rejection Form, 3: Preview
  
  // Modal states
  bool _showFilterModal = false;
  
  // Selected letter
  LetterApplication? _selectedLetter;
  
  // Active filters
  final List<String> _activeFilters = ['Surat Izin', 'Surat Permohonan'];
  
  // Sample letter data
  final List<LetterApplication> _letters = [
    LetterApplication(
      id: '1',
      type: 'Surat Izin Kegiatan KKN',
      applicantName: 'Budi Hariono',
      date: '01/05/2025',
      nik: '099900090797',
      address: 'Jl. Merdeka No.10 Kebayoran Baru',
      description: 'Saya izin buat kkn pak, mohon izinnya',
      status: LetterStatus.pending,
    ),
    LetterApplication(
      id: '2',
      type: 'Surat Izin Kegiatan KKN',
      applicantName: 'Budi Hariono',
      date: '01/05/2025',
      nik: '099900090797',
      address: 'Jl. Merdeka No.10 Kebayoran Baru',
      description: 'Saya izin buat kkn pak, mohon izinnya',
      status: LetterStatus.pending,
    ),
    LetterApplication(
      id: '3',
      type: 'Surat Izin Kegiatan KKN',
      applicantName: 'Budi Hariono',
      date: '01/05/2025',
      nik: '099900090797',
      address: 'Jl. Merdeka No.10 Kebayoran Baru',
      description: 'Saya izin buat kkn pak, mohon izinnya',
      status: LetterStatus.pending,
    ),
    LetterApplication(
      id: '4',
      type: 'Surat Izin Kegiatan KKN',
      applicantName: 'Budi Hariono',
      date: '01/05/2025',
      nik: '099900090797',
      address: 'Jl. Merdeka No.10 Kebayoran Baru',
      description: 'Saya izin buat kkn pak, mohon izinnya',
      status: LetterStatus.pending,
    ),
  ];

  void _viewLetterDetail(LetterApplication letter) {
    setState(() {
      _selectedLetter = letter;
      _currentView = 1;
    });
  }

  void _showRejectionForm() {
    setState(() {
      _currentView = 2;
    });
  }

  void _showLetterPreview() {
    setState(() {
      _currentView = 3;
    });
  }

  void _goBack() {
    setState(() {
      if (_currentView > 0) {
        _currentView = _currentView - 1;
      }
      
      // If going back from rejection form or preview, go to list
      if (_currentView == 0) {
        _selectedLetter = null;
      }
    });
  }

  void _toggleFilterModal() {
    setState(() {
      _showFilterModal = !_showFilterModal;
    });
  }

  void _applyFilters(Map<String, dynamic> filters) {
    // Apply filters logic
    setState(() {
      _showFilterModal = false;
    });
  }

  void _acceptLetter() {
    if (_selectedLetter != null) {
      setState(() {
        final index = _letters.indexWhere((letter) => letter.id == _selectedLetter!.id);
        if (index != -1) {
          _letters[index] = _letters[index].copyWith(status: LetterStatus.approved);
        }
        _showLetterPreview();
      });
    }
  }

  void _rejectLetter(String reason) {
    if (_selectedLetter != null) {
      setState(() {
        final index = _letters.indexWhere((letter) => letter.id == _selectedLetter!.id);
        if (index != -1) {
          _letters[index] = _letters[index].copyWith(
            status: LetterStatus.rejected,
            rejectionReason: reason,
          );
        }
        _currentView = 0;
        _selectedLetter = null;
      });
    }
  }

  void _publishLetter() {
    if (_selectedLetter != null) {
      setState(() {
        final index = _letters.indexWhere((letter) => letter.id == _selectedLetter!.id);
        if (index != -1) {
          _letters[index] = _letters[index].copyWith(status: LetterStatus.published);
        }
        _currentView = 0;
        _selectedLetter = null;
      });
    }
  }

  void _removeFilter(String filter) {
    setState(() {
      _activeFilters.remove(filter);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_getAppBarTitle()),
        centerTitle: true,
        leading: _currentView > 0
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: _goBack,
              )
            : null,
        actions: _currentView == 0
            ? [
                IconButton(
                  icon: const Icon(Icons.filter_list),
                  onPressed: _toggleFilterModal,
                ),
              ]
            : null,
      ),
      body: Stack(
        children: [
          // Main content based on current view
          _buildMainContent(),
          
          // Filter modal
          if (_showFilterModal)
            FilterModal(
              onApply: _applyFilters,
              onCancel: _toggleFilterModal,
            ),
        ],
      ),
      bottomNavigationBar: BottomNavbarAdmin(
        currentIndex: 3,
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

  String _getAppBarTitle() {
    switch (_currentView) {
      case 0:
        return 'Kelola Pengajuan Surat';
      case 1:
        return 'Detail Pengajuan';
      case 2:
        return 'Alasan Penolakan';
      case 3:
        return 'Preview Surat';
      default:
        return 'Kelola Pengajuan Surat';
    }
  }

  Widget _buildMainContent() {
    switch (_currentView) {
      case 0:
        return _buildLetterListView();
      case 1:
        return _selectedLetter != null
            ? LetterDetail(
                letter: _selectedLetter!,
                onAccept: _acceptLetter,
                onReject: _showRejectionForm,
              )
            : const SizedBox.shrink();
      case 2:
        return RejectionForm(
          onSubmit: _rejectLetter,
        );
      case 3:
        return _selectedLetter != null
            ? LetterPreview(
                letter: _selectedLetter!,
                onPublish: _publishLetter,
              )
            : const SizedBox.shrink();
      default:
        return _buildLetterListView();
    }
  }

  Widget _buildLetterListView() {
    return Column(
      children: [
        // Search bar
        Padding(
          padding: const EdgeInsets.all(16),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Cari Surat Permohonan',
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
        
        // Filter chips
        if (_activeFilters.isNotEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.filter_list,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: _activeFilters.map((filter) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: Chip(
                            label: Text(filter),
                            deleteIcon: const Icon(Icons.close, size: 16),
                            onDeleted: () => _removeFilter(filter),
                            backgroundColor: Colors.blue[100],
                            labelStyle: const TextStyle(color: Colors.blue),
                            deleteIconColor: Colors.blue,
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        
        // Letters list
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: _letters.length,
            itemBuilder: (context, index) {
              return LetterListItem(
                letter: _letters[index],
                onTap: () => _viewLetterDetail(_letters[index]),
              );
            },
          ),
        ),
      ],
    );
  }
}
