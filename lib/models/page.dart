class Page {
  final List<dynamic> content;
  final bool first;
  final bool last;
  final int number;
  final int numberOfElements;
  final int size;
  final int totalPages;

  Page({
    this.content,
    this.first,
    this.last,
    this.number,
    this.numberOfElements,
    this.size,
    this.totalPages,
  });

  factory Page.fromMap(Map<String, dynamic> map) {
    return Page(
      content: map['content'].toList(),
      first: map['first'] as bool,
      last: map['last'] as bool,
      number: map['number'] as int,
      numberOfElements: map['numberOfElements'] as int,
      size: map['size'] as int,
      totalPages: map['totalPages'] as int,
    );
  }
}
