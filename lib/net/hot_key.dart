class HotKey {
  final String name;
  final String link;

  HotKey({required this.name, required this.link});

  HotKey.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        link = json['link'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'link': link,
      };

  @override
  String toString() {
    return 'HotKey{name: $name, link: $link}';
  }
}
