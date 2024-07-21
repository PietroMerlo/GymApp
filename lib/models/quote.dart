class Quote {
  final String id;
  final String content;
  final String author;

  Quote(
    this.id,
    this.content,
    this.author,
  );

  /*factory Quote.fromJson(Map<String, dynamic> json) {
    return Quote(
        json['_id'] ?? 'Unknown',
        json['content'] ?? "unknown",
        json['author'] ?? "unknown",
        json['authorSlug'] ?? "unknown",
        json['length'] ?? "unknown",
        json['dateAdded'] ?? "unknown",
        json['dateModified'] ?? "unknown");
  }*/
  Quote.fromJson(Map<String, dynamic> json)
      : id = json['_id'],
        content = json['content'],
        author = json['author'];
}
