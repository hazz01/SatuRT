import 'package:flutter/material.dart';
import '../../widgets/bottom_navbar_admin.dart';
import 'widgets/data_warga_widgets.dart';
import 'widgets/popup_widgets.dart';

class KelolaWargaPage extends StatefulWidget {
  const KelolaWargaPage({super.key});

  @override
  State<KelolaWargaPage> createState() => _KelolaWargaPageState();
}

class _KelolaWargaPageState extends State<KelolaWargaPage> {
  final TextEditingController _searchController = TextEditingController();
  bool _isSelectMode = false;
  bool _isFilterOpen = false;
  bool _isAddDataOpen = false;
  bool _isUploadCSVOpen = false;
  List<Warga> _wargaList = [];
  List<Warga> _selectedWarga = [];
  
  // Filter values
  String _filterRT = '';
  String _filterRW = '';
  String _gender = '';
  
  @override
  void initState() {
    super.initState();
    _loadData();
  }
  
  void _loadData() {
    // Mock data for demonstration
    setState(() {
      _wargaList = List.generate(
        4,
        (index) => Warga(
          name: 'Budi Santoso',
          phone: '09990990${7970 + index}',
          address: 'Jl. Melati Putri',
          rt: 'RT 1',
          rw: 'RW 8',
        ),
      );
    });
  }
  
  void _toggleSelectMode() {
    setState(() {
      _isSelectMode = !_isSelectMode;
      if (!_isSelectMode) {
        _selectedWarga.clear();
      }
    });
  }
  
  void _toggleFilterPopup() {
    setState(() {
      _isFilterOpen = !_isFilterOpen;
    });
  }
  
  void _toggleAddDataPopup() {
    setState(() {
      _isAddDataOpen = !_isAddDataOpen;
    });
  }
  
  void _toggleUploadCSVPopup() {
    setState(() {
      _isUploadCSVOpen = !_isUploadCSVOpen;
    });
  }
  
  void _toggleWargaSelection(Warga warga) {
    setState(() {
      if (_selectedWarga.contains(warga)) {
        _selectedWarga.remove(warga);
      } else {
        _selectedWarga.add(warga);
      }
    });
  }
  
  void _selectAll() {
    setState(() {
      if (_selectedWarga.length == _wargaList.length) {
        _selectedWarga.clear();
      } else {
        _selectedWarga = List.from(_wargaList);
      }
    });
  }
  
  void _applyFilter(String rt, String rw, String gender) {
    setState(() {
      _filterRT = rt;
      _filterRW = rw;
      _gender = gender;
    });
    _toggleFilterPopup();
  }
  
  void _handleAddData() {
    // Logic to add new data
    _toggleAddDataPopup();
  }
  
  void _handleUploadCSV() {
    // Logic to process uploaded CSV
    _toggleUploadCSVPopup();
  }
  
  void _handleSelectFile() {
    // Logic to select CSV file from device
  }
  
  void _hapusWarga(Warga warga) {
    setState(() {
      _wargaList.remove(warga);
      if (_selectedWarga.contains(warga)) {
        _selectedWarga.remove(warga);
      }
    });
  }
  
  void _hapusSelected() {
    setState(() {
      _wargaList.removeWhere((warga) => _selectedWarga.contains(warga));
      _selectedWarga.clear();
    });
  }
  
  void _hapusAll() {
    setState(() {
      _wargaList.clear();
      _selectedWarga.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kelola Data Warga'),
        actions: [
          if (_isSelectMode)
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: _toggleSelectMode,
            ),
        ],
      ),
      body: Stack(
        children: [
          Column(
            children: [
              SearchBarWidget(controller: _searchController),
              _buildFilterChips(),
              Expanded(
                child: _isSelectMode 
                  ? _buildSelectModeList() 
                  : _buildWargaList(),
              ),
            ],
          ),
          if (_isFilterOpen) 
            FilterPopupWidget(
              initialRT: _filterRT,
              initialRW: _filterRW,
              initialGender: _gender,
              onApply: _applyFilter,
              onCancel: _toggleFilterPopup,
            ),
          if (_isAddDataOpen) 
            AddDataPopupWidget(
              onSave: _handleAddData,
              onCancel: _toggleAddDataPopup,
            ),
          if (_isUploadCSVOpen) 
            UploadCSVPopupWidget(
              onUpload: _handleUploadCSV,
              onCancel: _toggleUploadCSVPopup,
              onSelectFile: _handleSelectFile,
            ),
        ],
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (_isSelectMode)
            SelectAllActionWidget(
              selectedCount: _selectedWarga.length,
              totalCount: _wargaList.length,
              onSelectAll: _selectAll,
              onHapusAll: _hapusAll,
            ),
          BottomActionBarWidget(
            onUploadCSV: _toggleUploadCSVPopup,
            onAddData: _toggleAddDataPopup,
          ),
          BottomNavbarAdmin(
            currentIndex: 0,
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
        ],
      ),
    );
  }
  
  Widget _buildFilterChips() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(20),
            ),
            child: IconButton(
              icon: const Icon(Icons.filter_list, color: Colors.white),
              onPressed: _toggleFilterPopup,
            ),
          ),
          const SizedBox(width: 10),
          if (_filterRT.isNotEmpty)
            FilterChipWidget(
              label: 'RT $_filterRT',
              onRemove: () {
                setState(() {
                  _filterRT = '';
                });
              },
            ),
          const SizedBox(width: 10),
          if (_filterRW.isNotEmpty)
            FilterChipWidget(
              label: 'RW $_filterRW',
              onRemove: () {
                setState(() {
                  _filterRW = '';
                });
              },
            ),
        ],
      ),
    );
  }
  
  Widget _buildWargaList() {
    return ListView.builder(
      itemCount: _wargaList.length,
      itemBuilder: (context, index) {
        final warga = _wargaList[index];
        return WargaCardWidget(
          warga: warga,
          onEdit: () {
            // Implement edit functionality
          },
          onDelete: () => _hapusWarga(warga),
        );
      },
    );
  }
  
  Widget _buildSelectModeList() {
    return ListView.builder(
      itemCount: _wargaList.length,
      itemBuilder: (context, index) {
        final warga = _wargaList[index];
        return SelectableWargaCardWidget(
          warga: warga,
          isSelected: _selectedWarga.contains(warga),
          onToggleSelection: () => _toggleWargaSelection(warga),
          onEdit: () {
            // Implement edit functionality
          },
          onDelete: () => _hapusWarga(warga),
        );
      },
    );
  }
}