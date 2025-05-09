import 'package:flutter/material.dart';
import '../../widgets/bottom_navbar_admin.dart';
import '../../widgets/transaction_list_item.dart';
import '../../widgets/add_transaction_modal.dart';
import '../../widgets/cash_settings_modal.dart';
import '../../widgets/add_dues_modal.dart';
import '../../widgets/filter_modal.dart';
import '../../widgets/summary_card.dart';
import '../../widgets/menu_button.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/models/transaction.dart';
import '../../../core/models/dues.dart';

class KelolaKeuanganPage extends StatefulWidget {
  const KelolaKeuanganPage({super.key});

  @override
  State<KelolaKeuanganPage> createState() => _KelolaKeuanganPageState();
}

class _KelolaKeuanganPageState extends State<KelolaKeuanganPage> {
  // Current view state
  int _currentView =
      0; // 0: Dashboard, 1: Cash List, 2: Dues List, 3: Arrears List, 4: Success

  // Modal states
  bool _showAddTransactionModal = false;
  bool _showCashSettingsModal = false;
  bool _showAddDuesModal = false;
  bool _showFilterModal = false;

  // Financial data
  double _balance = 12500000;
  double _income = 5000000;
  double _expense = 2500000;

  // Sample transaction data
  final List<Transaction> _transactions = [
    Transaction(
      id: '1',
      name: 'Budi Santoso',
      date: '01/05/2023',
      amount: 25000,
      type: TransactionType.income,
      description: '2 Meter Pasti - RT 1 RW 8',
    ),
    Transaction(
      id: '2',
      name: 'Budi Santoso',
      date: '01/05/2023',
      amount: 25000,
      type: TransactionType.income,
      description: '2 Meter Pasti - RT 1 RW 8',
    ),
    Transaction(
      id: '3',
      name: 'Budi Santoso',
      date: '01/05/2023',
      amount: 25000,
      type: TransactionType.income,
      description: '2 Meter Pasti - RT 1 RW 8',
    ),
    Transaction(
      id: '4',
      name: 'Budi Santoso',
      date: '01/05/2023',
      amount: 25000,
      type: TransactionType.expense,
      description: '2 Meter Pasti - RT 1 RW 8',
    ),
  ];

  // Sample dues data
  final List<Dues> _duesList = [
    Dues(
      id: '1',
      name: 'Budi Santoso',
      date: '01/05/2023',
      amount: 25000,
      isPaid: true,
      description: '2 Meter Pasti - RT 1 RW 8',
    ),
    Dues(
      id: '2',
      name: 'Budi Santoso',
      date: '01/05/2023',
      amount: 25000,
      isPaid: true,
      description: '2 Meter Pasti - RT 1 RW 8',
    ),
    Dues(
      id: '3',
      name: 'Budi Santoso',
      date: '01/05/2023',
      amount: 25000,
      isPaid: true,
      description: '2 Meter Pasti - RT 1 RW 8',
    ),
    Dues(
      id: '4',
      name: 'Budi Santoso',
      date: '01/05/2023',
      amount: 25000,
      isPaid: false,
      description: '2 Meter Pasti - RT 1 RW 8',
    ),
  ];

  // Sample arrears data
  final List<Dues> _arrearsList = [
    Dues(
      id: '1',
      name: 'Peringatan IKRT RI ke-100',
      date: '01/05/2023',
      amount: 25000,
      isPaid: false,
      description: 'Budi Santoso\n2 Meter Pasti - RT 1 RW 8',
    ),
    Dues(
      id: '2',
      name: 'Peringatan IKRT RI ke-100',
      date: '01/05/2023',
      amount: 25000,
      isPaid: false,
      description: 'Budi Santoso\n2 Meter Pasti - RT 1 RW 8',
    ),
    Dues(
      id: '3',
      name: 'Peringatan IKRT RI ke-100',
      date: '01/05/2023',
      amount: 25000,
      isPaid: false,
      description: 'Budi Santoso\n2 Meter Pasti - RT 1 RW 8',
    ),
    Dues(
      id: '4',
      name: 'Peringatan IKRT RI ke-100',
      date: '01/05/2023',
      amount: 25000,
      isPaid: false,
      description: 'Budi Santoso\n2 Meter Pasti - RT 1 RW 8',
    ),
  ];

  void _navigateToCashList() {
    setState(() {
      _currentView = 1;
    });
  }

  void _navigateToDuesList() {
    setState(() {
      _currentView = 2;
    });
  }

  void _navigateToArrearsList() {
    setState(() {
      _currentView = 3;
    });
  }

  void _navigateToDashboard() {
    setState(() {
      _currentView = 0;
    });
  }

  void _showSuccessScreen() {
    setState(() {
      _currentView = 4;
      // Hide any open modals
      _showAddTransactionModal = false;
      _showCashSettingsModal = false;
      _showAddDuesModal = false;
      _showFilterModal = false;
    });

    // Automatically go back to dashboard after 2 seconds
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _currentView = 0;
        });
      }
    });
  }

  void _toggleAddTransactionModal() {
    setState(() {
      _showAddTransactionModal = !_showAddTransactionModal;
      if (_showAddTransactionModal) {
        _showCashSettingsModal = false;
        _showAddDuesModal = false;
        _showFilterModal = false;
      }
    });
  }

  void _toggleCashSettingsModal() {
    setState(() {
      _showCashSettingsModal = !_showCashSettingsModal;
      if (_showCashSettingsModal) {
        _showAddTransactionModal = false;
        _showAddDuesModal = false;
        _showFilterModal = false;
      }
    });
  }

  void _toggleAddDuesModal() {
    setState(() {
      _showAddDuesModal = !_showAddDuesModal;
      if (_showAddDuesModal) {
        _showAddTransactionModal = false;
        _showCashSettingsModal = false;
        _showFilterModal = false;
      }
    });
  }

  void _toggleFilterModal() {
    setState(() {
      _showFilterModal = !_showFilterModal;
      if (_showFilterModal) {
        _showAddTransactionModal = false;
        _showCashSettingsModal = false;
        _showAddDuesModal = false;
      }
    });
  }

  void _addTransaction(Transaction transaction) {
    setState(() {
      _transactions.add(transaction);
      _showAddTransactionModal = false;
    });
    _showSuccessScreen();
  }

  void _addDues(Dues dues) {
    setState(() {
      _duesList.add(dues);
      _showAddDuesModal = false;
    });
    _showSuccessScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_getAppBarTitle()),
        centerTitle: true,
        leading: _currentView > 0 && _currentView < 4
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: _navigateToDashboard,
              )
            : null,
        actions: _currentView > 0 && _currentView < 4
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

          // Modals
          if (_showAddTransactionModal)
            AddTransactionModal(
              onAdd: _addTransaction,
              onCancel: _toggleAddTransactionModal,
            ),

          if (_showCashSettingsModal)
            CashSettingsModal(
              onSave: (settings) {
                // Handle settings save
                _toggleCashSettingsModal();
                _showSuccessScreen();
              },
              onCancel: _toggleCashSettingsModal,
            ),

          if (_showAddDuesModal)
            AddDuesModal(
              onAdd: _addDues,
              onCancel: _toggleAddDuesModal,
            ),

          if (_showFilterModal)
            FilterModal(
              onApply: (filters) {
                // Apply filters logic
                _toggleFilterModal();
              },
              onCancel: _toggleFilterModal,
            ),
        ],
      ),
      floatingActionButton: _currentView > 0 && _currentView < 4
          ? FloatingActionButton(
              onPressed: _currentView == 1
                  ? _toggleAddTransactionModal
                  : _currentView == 2
                      ? _toggleAddDuesModal
                      : null,
              child: const Icon(Icons.add),
            )
          : null,
      bottomNavigationBar: BottomNavbarAdmin(
        currentIndex: 1,
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushReplacementNamed(context, '/admin/home');
              break;
            case 1:
              Navigator.pushReplacementNamed(context, '/admin/keuangan');
              break;
            case 2:
              Navigator.pushReplacementNamed(context, '/admin/cctv');
              break;
            case 3:
              Navigator.pushReplacementNamed(context, '/admin/surat');
              break;
            case 4:
              Navigator.pushReplacementNamed(context, '/admin/laporan');
              break;
          }
        },
      ),
    );
  }

  String _getAppBarTitle() {
    switch (_currentView) {
      case 0:
        return 'Kelola Keuangan';
      case 1:
        return 'Daftar Kas';
      case 2:
        return 'Daftar Iuran';
      case 3:
        return 'Daftar Tunggakan';
      case 4:
        return 'Laporan Telah Dibuat';
      default:
        return 'Kelola Keuangan';
    }
  }

  Widget _buildMainContent() {
    switch (_currentView) {
      case 0:
        return _buildDashboardView();
      case 1:
        return _buildCashListView();
      case 2:
        return _buildDuesListView();
      case 3:
        return _buildArrearsListView();
      case 4:
        return _buildSuccessView();
      default:
        return _buildDashboardView();
    }
  }

  Widget _buildDashboardView() {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Balance Card
          Card(
            elevation: 4,
            shadowColor: Colors.black.withOpacity(0.15),
            color: Colors.white,
            margin: const EdgeInsets.fromLTRB(0, 16, 0, 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Saldo RT/RW',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF636363),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Rp ${_formatCurrency(_balance)}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Rekapitulasi Bulan Ini',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildSummaryItem(
                    icon: Icons.arrow_downward,
                    color: Colors.green,
                    label: 'Pemasukan',
                    amount: _income,
                  ),
                  const SizedBox(height: 8),
                  _buildSummaryItem(
                    icon: Icons.arrow_upward,
                    color: Colors.red,
                    label: 'Pengeluaran',
                    amount: _expense,
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // Navigate to detailed report
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1658B3),
                        foregroundColor: Colors.white,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(68),
                        ),
                      ),
                      child: const Text(
                        'Buat Laporan Keuangan',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 24),

          // Menu Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: MenuButton(
                  icon: Icons.account_balance_wallet,
                  label: 'Kas',
                  onTap: _navigateToCashList,
                  backgroundColor: const Color(0x261658B3),
                  textColor: const Color(0xFF1658B3),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: MenuButton(
                  icon: Icons.receipt_long,
                  label: 'Iuran',
                  onTap: _navigateToDuesList,
                  backgroundColor: const Color(0x261658B3),
                  textColor: const Color(0xFF1658B3),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: MenuButton(
                  icon: Icons.warning_amber,
                  label: 'Tunggakan',
                  onTap: _navigateToArrearsList,
                  backgroundColor: const Color(0x261658B3),
                  textColor: const Color(0xFF1658B3),
                ),
              ),
              // const SizedBox(width: 8),
              // Expanded(
              //   child: MenuButton(
              //     icon: Icons.bar_chart,
              //     label: 'Laporan',
              //     onTap: () {
              //       // Navigate to reports
              //     },
              //     backgroundColor: const Color(0x261658B3),
              //     textColor: const Color(0xFF1658B3),
              //   ),
              // ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryItem({
    required IconData icon,
    required Color color,
    required String label,
    required double amount,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: color,
            size: 16,
          ),
        ),
        const SizedBox(width: 12),
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
          ),
        ),
        const Spacer(),
        Text(
          'Rp ${_formatCurrency(amount)}',
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildCashListView() {
  return Column(
    children: [
      // Filter chips
      Padding(
        padding: const EdgeInsets.fromLTRB(24, 16, 24, 8),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _buildFilterChip(
                label: 'Pemasukan',
                isActive: true,
              ),
              const SizedBox(width: 8),
              _buildFilterChip(
                label: 'Pengeluaran',
                isActive: false,
              ),
              const SizedBox(width: 8),
              _buildFilterChip(
                label: 'Semua',
                isActive: false,
              ),
            ],
          ),
        ),
      ),

      // Transactions list
      Expanded(
        child: ListView.builder(
          padding: const EdgeInsets.fromLTRB(24, 8, 24, 16),
          itemCount: _transactions.length,
          itemBuilder: (context, index) {
            return TransactionListItem(
              transaction: _transactions[index],
              onTap: () {
                // View transaction details
              },
            );
          },
        ),
      ),
    ],
  );
}

  Widget _buildDuesListView() {
    return Column(
      children: [
        // Filter chips
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildFilterChip(
                  label: 'Pengaturan Iuran',
                  isActive: true,
                ),
                const SizedBox(width: 8),
                _buildFilterChip(
                  label: 'Riwayat Iuran',
                  isActive: false,
                ),
              ],
            ),
          ),
        ),

        // Dues list
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: _duesList.length,
            itemBuilder: (context, index) {
              return TransactionListItem(
                transaction: Transaction(
                  id: _duesList[index].id,
                  name: _duesList[index].name,
                  date: _duesList[index].date,
                  amount: _duesList[index].amount,
                  type: _duesList[index].isPaid
                      ? TransactionType.income
                      : TransactionType.pending,
                  description: _duesList[index].description,
                ),
                onTap: () {
                  // View dues details
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget  _buildArrearsListView() {
    return Column(
      children: [
        // Search bar
        Padding(
          padding: const EdgeInsets.all(16),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Cari tunggakan...',
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
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildFilterChip(
                  label: 'Peringatan/RT/RW 100',
                  isActive: true,
                  icon: Icons.warning,
                ),
                const SizedBox(width: 8),
                _buildFilterChip(
                  label: 'Iuran Bulanan',
                  isActive: false,
                  icon: Icons.calendar_today,
                ),
              ],
            ),
          ),
        ),

        // Arrears list
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: _arrearsList.length,
            itemBuilder: (context, index) {
              return Card(
                margin: const EdgeInsets.only(bottom: 16),
                elevation: 1,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _arrearsList[index].name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _arrearsList[index].description,
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _arrearsList[index].date,
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            'Rp ${_formatCurrency(_arrearsList[index].amount)}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSuccessView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.blue[50],
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.check,
              color: Colors.blue,
              size: 60,
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Laporan Telah Dibuat',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _navigateToDashboard,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text('Kembali'),
          ),
        ],
      ),
    );
  }

Widget _buildFilterChip({
  required String label,
  required bool isActive,
  IconData? icon,
}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    decoration: BoxDecoration(
      color: isActive ? const Color(0xFF1658B3) : const Color(0x261658B3),
      borderRadius: BorderRadius.circular(68),
    ),
    child: Row(
      children: [
        if (icon != null) ...[
          Icon(
            icon,
            size: 16,
            color: isActive ? Colors.white : const Color(0xFF1658B3),
          ),
          const SizedBox(width: 6),
        ],
        Text(
          label,
          style: TextStyle(
            color: isActive ? Colors.white : const Color(0xFF1658B3),
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
      ],
    ),
  );
}


  String _formatCurrency(double amount) {
    return amount.toStringAsFixed(0).replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]}.',
        );
  }
}
