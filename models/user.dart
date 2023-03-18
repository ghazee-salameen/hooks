class User {
  final String? ID;
  final String? userName;
  final String? passWord;
  final String? email;
  const User({this.ID, this.userName, this.passWord, this.email});
  User copyWith(
      {String? ID, String? userName, String? passWord, String? email}) {
    return User(
        ID: ID ?? this.ID,
        userName: userName ?? this.userName,
        passWord: passWord ?? this.passWord,
        email: email ?? this.email);
  }

  Map<String, Object?> toJson() {
    return {
      'ID': ID,
      'userName': userName,
      'passWord': passWord,
      'email': email
    };
  }

  factory User.fromJson(Map<String, Object?> json) {
    return User(
        ID: json['ID'] == null ? null : json['ID'] as String,
        userName: json['userName'] == null ? null : json['userName'] as String,
        passWord: json['passWord'] == null ? null : json['passWord'] as String,
        email: json['email'] == null ? null : json['email'] as String);
  }

  @override
  String toString() {
    return '''User(
                ID:$ID,
userName:$userName,
passWord:$passWord,
email:$email
    ) ''';
  }

  @override
  bool operator ==(Object other) {
    return other is User &&
        other.runtimeType == runtimeType &&
        other.ID == ID &&
        other.userName == userName &&
        other.passWord == passWord &&
        other.email == email;
  }

  @override
  int get hashCode {
    return Object.hash(runtimeType, ID, userName, passWord, email);
  }
}
