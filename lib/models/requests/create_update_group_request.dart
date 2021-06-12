class CreateUpdateGroupRequest {
  final String? title;
  final String? description;
  final List<String>? users;
  final List<String>? admins;

  CreateUpdateGroupRequest({
    this.title,
    this.description,
    this.users,
    this.admins,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': this.title,
      'description': this.description,
      'users': this.users,
      'admins': this.admins,
    };
  }

  CreateUpdateGroupRequest copyWith({
    String? title,
    String? description,
    List<String>? users,
    List<String>? admins,
  }) {
    return CreateUpdateGroupRequest(
      title: title ?? this.title,
      description: description ?? this.description,
      users: users ?? this.users,
      admins: admins ?? this.admins,
    );
  }
}
