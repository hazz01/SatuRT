import 'package:flutter/material.dart';

class RejectionForm extends StatefulWidget {
  final Function(String) onSubmit;

  const RejectionForm({
    super.key,
    required this.onSubmit,
  });

  @override
  State<RejectionForm> createState() => _RejectionFormState();
}

class _RejectionFormState extends State<RejectionForm> {
  final _reasonController = TextEditingController();

  @override
  void dispose() {
    _reasonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: _reasonController,
            decoration: InputDecoration(
              hintText: 'Masukkan Alasan Penolakan',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              contentPadding: const EdgeInsets.all(16),
            ),
            maxLines: 5,
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                if (_reasonController.text.isNotEmpty) {
                  widget.onSubmit(_reasonController.text);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Tolak'),
            ),
          ),
        ],
      ),
    );
  }
}
