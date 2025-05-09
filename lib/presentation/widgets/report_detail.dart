import 'package:flutter/material.dart';

class ReportDetail extends StatelessWidget {
  final Map<String, dynamic> report;
  final VoidCallback? onProcess;
  final VoidCallback? onEscalate;
  final VoidCallback? onComplete;
  final bool showProcessButton;
  final bool showCompleteButton;

  const ReportDetail({
    super.key,
    required this.report,
    this.onProcess,
    this.onEscalate,
    this.onComplete,
    this.showProcessButton = false,
    this.showCompleteButton = false,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Informasi Laporan',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          _buildInfoRow('Judul Laporan', report['title']),
          _buildInfoRow('Pelapor', report['reporter']),
          _buildInfoRow('NIK', report['nik']),
          _buildInfoRow('Lokasi', report['fullLocation']),
          _buildInfoRow('Tanggal', report['date']),
          _buildInfoRow('Kategori Laporan', report['category']),
          _buildInfoRow('Deskripsi', report['description']),
          _buildInfoRow('Status Laporan', report['status'], isStatus: true),
          const SizedBox(height: 24),
          if (showProcessButton) ...[
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onProcess,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('Proses'),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: onEscalate,
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  side: const BorderSide(color: Colors.red),
                  foregroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('Perlu Eskalasi'),
              ),
            ),
          ],
          if (showCompleteButton) ...[
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onComplete,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('Selesaikan'),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, {bool isStatus = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: isStatus
                ? Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.amber[100],
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.refresh, size: 16, color: Colors.amber[800]),
                        const SizedBox(width: 4),
                        Text(
                          value,
                          style: TextStyle(
                            color: Colors.amber[800],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  )
                : Text(
                    value,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
