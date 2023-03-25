class UserModel {
  final String userName;
  final String email;
  // final String password;
  final String? phone;
  final String? location;
  final String? image;
  final String? id;
  final String? companyName;
  final String? description;
  final String userRole;
  UserModel({
    required this.userName,
    required this.userRole,
    required this.email,
    // required this.password,
    this.phone,
    this.location,
    this.image,
    this.id,
    this.companyName,
    this.description,
  });

  UserModel copyWith({
    String? userName,
    String? email,
    String? password,
    String? phone,
    String? location,
    String? image,
    String? id,
    String? companyName,
    String? description,
    String? userRole,
  }) {
    return UserModel(
      userName: userName ?? this.userName,
      email: email ?? this.email,
      //  password: password ?? this.password,
      phone: phone ?? this.phone,
      location: location ?? this.location,
      image: image ?? this.image,
      id: id ?? this.id,
      companyName: companyName ?? this.companyName,
      description: description ?? this.description,
      userRole: userRole ?? this.userRole,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userName': userName,
      'email': email,
      'phone': phone,
      'location': location,
      'image': image,
      'id': id,
      'companyName': companyName,
      'description': description,
      'userRole': userRole,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      userName: map['userName'] as String,
      email: map['email'] as String,
      phone: map['phone'] as String,
      location: map['location'] as String,
      image: map['image'] as String,
      id: map['id'] as String,
      companyName:
          map['companyName'] != null ? map['companyName'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      userRole: map['userRole'] as String,
    );
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.userName == userName &&
        other.email == email &&
        other.phone == phone &&
        other.location == location &&
        other.image == image &&
        other.id == id &&
        other.companyName == companyName &&
        other.description == description;
  }

  @override
  int get hashCode {
    return userName.hashCode ^
        email.hashCode ^
        phone.hashCode ^
        location.hashCode ^
        image.hashCode ^
        id.hashCode ^
        companyName.hashCode ^
        description.hashCode;
  }
}
