import 'package:flutter/material.dart';
import '../../widgets/bottom_navbar_admin.dart';

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
  
  void _applyFilter() {
    // Implementation for filter application
    _toggleFilterPopup();
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
              _buildSearchBar(),
              _buildFilterChips(),
              Expanded(
                child: _isSelectMode 
                  ? _buildSelectModeList() 
                  : _buildWargaList(),
              ),
            ],
          ),
          if (_isFilterOpen) _buildFilterPopup(),
          if (_isAddDataOpen) _buildAddDataPopup(),
          if (_isUploadCSVOpen) _buildUploadCSVPopup(),
        ],
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (_isSelectMode)
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: _hapusAll,
                child: const Text('Hapus Semua'),
              ),
            ),
          _buildBottomActionBar(),
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
  
  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: 'Cari Data Warga',
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.grey[200],
          contentPadding: const EdgeInsets.symmetric(vertical: 0),
        ),
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
          _buildFilterChip('RT 8'),
          const SizedBox(width: 10),
          _buildFilterChip('RT 1'),
        ],
      ),
    );
  }
  
  Widget _buildFilterChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(label, style: const TextStyle(color: Colors.blue)),
          const SizedBox(width: 5),
          InkWell(
            onTap: () {
              // Remove filter
            },
            child: const Icon(Icons.close, size: 16, color: Colors.blue),
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
        return _buildWargaCard(warga);
      },
    );
  }
  
  Widget _buildSelectModeList() {
    return ListView.builder(
      itemCount: _wargaList.length,
      itemBuilder: (context, index) {
        final warga = _wargaList[index];
        return _buildSelectableWargaCard(warga);
      },
    );
  }
  
  Widget _buildWargaCard(Warga warga) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  warga.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            Text(warga.phone),
            Text('${warga.address} • ${warga.rt} ${warga.rw}'),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.grey),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    onPressed: () {
                      // Implement edit functionality
                    },
                    child: const Text('Edit', style: TextStyle(color: Colors.black)),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    onPressed: () {
                      // Implement hapus functionality
                    },
                    child: const Text('Hapus'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildSelectableWargaCard(Warga warga) {
    final isSelected = _selectedWarga.contains(warga);
    
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Checkbox(
              value: isSelected,
              onChanged: (_) => _toggleWargaSelection(warga),
              activeColor: Colors.blue,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    warga.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(warga.phone),
                  Text('${warga.address} • ${warga.rt} ${warga.rw}'),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Colors.grey),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          onPressed: () {
                            // Implement edit functionality
                          },
                          child: const Text('Edit', style: TextStyle(color: Colors.black)),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          onPressed: () {
                            // Implement hapus functionality
                          },
                          child: const Text('Hapus'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildBottomActionBar() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              icon: const Icon(Icons.upload_file),
              label: const Text('Upload CSV'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: _toggleUploadCSVPopup,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: ElevatedButton.icon(
              icon: const Icon(Icons.add),
              label: const Text('Add Data'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.blue,
                side: const BorderSide(color: Colors.blue),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: _toggleAddDataPopup,
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildFilterPopup() {
    return Stack(
      children: [
        GestureDetector(
          onTap: _toggleFilterPopup,
          child: Container(
            color: Colors.black.withOpacity(0.5),
            height: double.infinity,
            width: double.infinity,
          ),
        ),
        Center(
          child: Container(
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
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
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: _toggleFilterPopup,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('RT'),
                          TextField(
                            decoration: InputDecoration(
                              hintText: 'RT',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onChanged: (value) {
                              setState(() {
                                _filterRT = value;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Icon(Icons.arrow_forward),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('RW'),
                          TextField(
                            decoration: InputDecoration(
                              hintText: 'RW',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onChanged: (value) {
                              setState(() {
                                _filterRW = value;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Text('Gender'),
                Row(
                  children: [
                    Checkbox(
                      value: _gender == 'Laki-laki' || _gender.isEmpty,
                      onChanged: (value) {
                        setState(() {
                          _gender = value! ? 'Laki-laki' : '';
                        });
                      },
                    ),
                    const Text('Laki-laki'),
                  ],
                ),
                Row(
                  children: [
                    Checkbox(
                      value: _gender == 'Perempuan' || _gender.isEmpty,
                      onChanged: (value) {
                        setState(() {
                          _gender = value! ? 'Perempuan' : '';
                        });
                      },
                    ),
                    const Text('Perempuan'),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: _applyFilter,
                        child: const Text('Apply'),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.blue),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: _toggleFilterPopup,
                        child: const Text('Cancel', style: TextStyle(color: Colors.blue)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
  
  Widget _buildAddDataPopup() {
    return Stack(
      children: [
        GestureDetector(
          onTap: _toggleAddDataPopup,
          child: Container(
            color: Colors.black.withOpacity(0.5),
            height: double.infinity,
            width: double.infinity,
          ),
        ),
        Center(
          child: Container(
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Add Data',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: _toggleAddDataPopup,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                _buildFormField('Nama', 'Masukkan Nama Warga'),
                const SizedBox(height: 10),
                _buildFormField('NIK', 'Masukkan NIK Warga'),
                const SizedBox(height: 10),
                _buildFormField('Alamat', 'Masukkan Alamat Warga'),
                const SizedBox(height: 10),
                _buildFormField('TTL', 'Tanggal / Bulan / Tahun'),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {
                          // Add data logic here
                          _toggleAddDataPopup();
                        },
                        child: const Text('Upload'),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.blue),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: _toggleAddDataPopup,
                        child: const Text('Cancel', style: TextStyle(color: Colors.blue)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
  
  Widget _buildUploadCSVPopup() {
    return Stack(
      children: [
        GestureDetector(
          onTap: _toggleUploadCSVPopup,
          child: Container(
            color: Colors.black.withOpacity(0.5),
            height: double.infinity,
            width: double.infinity,
          ),
        ),
        Center(
          child: Container(
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Upload Data',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: _toggleUploadCSVPopup,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Container(
                  height: 150,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.upload_file, size: 40),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {
                          // Upload CSV file logic
                        },
                        child: const Text('Upload CSV'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {
                          // Process uploaded CSV
                          _toggleUploadCSVPopup();
                        },
                        child: const Text('Upload'),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.blue),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: _toggleUploadCSVPopup,
                        child: const Text('Cancel', style: TextStyle(color: Colors.blue)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
  
  Widget _buildFormField(String label, String hint) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        const SizedBox(height: 5),
        TextField(
          decoration: InputDecoration(
            hintText: hint,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ],
    );
  }
}

// Model class for Warga data
class Warga {
  final String name;
  final String phone;
  final String address;
  final String rt;
  final String rw;
  
  Warga({
    required this.name, 
    required this.phone, 
    required this.address, 
    required this.rt, 
    required this.rw,
  });
}