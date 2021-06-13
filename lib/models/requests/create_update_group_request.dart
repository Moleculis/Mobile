class CreateUpdateGroupRequest {
  final String? title;
  final String? description;
  final List<String>? usersUsernames;
  final List<String>? admins;

  CreateUpdateGroupRequest({
    this.title,
    this.description,
    this.usersUsernames,
    this.admins,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': this.title,
      'description': this.description,
      'users': this.usersUsernames,
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
      usersUsernames: users ?? this.usersUsernames,
      admins: admins ?? this.admins,
    );
  }
}
