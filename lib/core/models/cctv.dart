class CCTV {
  final String id;
  final String name;
  final String location;
  final String imageUrl;
  final bool isLive;

  CCTV({
    required this.id,
    required this.name,
    required this.location,
    required this.imageUrl,
    this.isLive = true,
  });
}
