class Pokemon {
  final String name;
  final String url;
  Pokemon(this.name, this.url);
  @override
  String toString() {
    return "$name $url";
  }
}
