class Page {
  final List<dynamic> content;
  final bool? first;
  final bool? last;
  final int number;
  final int numberOfElements;
  final int size;
  final int totalPages;

  Page({
    required this.content,
    required this.number,
    required this.numberOfElements,
    required this.size,
    required this.totalPages,
    this.first,
    this.last,
  });

  factory Page.fromMap(Map<String, dynamic> map) {
    return Page(
      content: map['content'].toList(),
      first: map['first'] as bool?,
      last: map['last'] as bool?,
      number: (map['number'] as int?) ?? 0,
      numberOfElements: (map['numberOfElements'] as int?) ?? 0,
      size: (map['size'] as int?) ?? 0,
      totalPages: (map['totalPages'] as int?) ?? 0,
    );
  }
}
