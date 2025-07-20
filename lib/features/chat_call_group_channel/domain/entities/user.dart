class User {
  final String id;
  final String name;
  final String imageUrl;

  const User({required this.id, required this.name, required this.imageUrl});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is User && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
