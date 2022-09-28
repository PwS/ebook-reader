class SearchInfo {
  final String textSnippet;

  const SearchInfo({required this.textSnippet});

  static const empty = SearchInfo(textSnippet: '');

  factory SearchInfo.fromJson(Map<String, dynamic> json) {
    return SearchInfo(textSnippet: json['textSnippet'] ?? '');
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['textSnippet'] = textSnippet;
    return data;
  }
}
