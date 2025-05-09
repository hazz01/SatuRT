class CctvItem {
  final int id;
  final String name;
  final String location;
  final String? streamUrl;
  final bool isLive;

  CctvItem({
    required this.id,
    required this.name,
    required this.location,
    this.streamUrl,
    this.isLive = true,
  });
}
