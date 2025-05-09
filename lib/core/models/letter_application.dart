enum LetterStatus {
  pending,
  approved,
  rejected,
  published,
}

class LetterApplication {
  final String id;
  final String type;
  final String applicantName;
  final String date;
  final String nik;
  final String address;
  final String description;
  final LetterStatus status;
  final String? rejectionReason;

  LetterApplication({
    required this.id,
    required this.type,
    required this.applicantName,
    required this.date,
    required this.nik,
    required this.address,
    required this.description,
    required this.status,
    this.rejectionReason,
  });

  LetterApplication copyWith({
    String? id,
    String? type,
    String? applicantName,
    String? date,
    String? nik,
    String? address,
    String? description,
    LetterStatus? status,
    String? rejectionReason,
  }) {
    return LetterApplication(
      id: id ?? this.id,
      type: type ?? this.type,
      applicantName: applicantName ?? this.applicantName,
      date: date ?? this.date,
      nik: nik ?? this.nik,
      address: address ?? this.address,
      description: description ?? this.description,
      status: status ?? this.status,
      rejectionReason: rejectionReason ?? this.rejectionReason,
    );
  }
}
