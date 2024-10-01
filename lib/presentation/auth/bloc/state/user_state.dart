class UserState {
  final String firstName;
  final String lastName;
  final String email;
  final String password; // Campo añadido
  final String profileImgUrl; 
  final String presentationImgUrl; 
  final String userDescription;
  final String role; 

  UserState({
    this.firstName = '',
    this.lastName = '',
    this.email = '',
    this.password = '', // Campo añadido
    this.profileImgUrl = '', 
    this.presentationImgUrl = '', 
    this.userDescription = '',
    String role = 'user', 
  }) : this.role = (role == 'user' || role == 'admin' || role == 'passenger' || role == 'driver') ? role : 'user';

  UserState copyWith({
    String? firstName,
    String? lastName,
    String? email,
    String? password, // Campo añadido
    String? profileImgUrl,
    String? presentationImgUrl,
    String? userDescription,
    String? role,
  }) {
    return UserState(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      password: password ?? this.password, // Campo añadido
      profileImgUrl: profileImgUrl ?? this.profileImgUrl,
      presentationImgUrl: presentationImgUrl ?? this.presentationImgUrl,
      userDescription: userDescription ?? this.userDescription,
      role: role ?? this.role,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'password': password, // Campo añadido
      'profileImgUrl': profileImgUrl, 
      'presentationImgUrl': presentationImgUrl, 
      'userDescription': userDescription,
      'role': role,
    };
  }

  factory UserState.fromJson(Map<String, dynamic> json) {
    return UserState(
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      email: json['email'] ?? '',
      password: json['password'] ?? '', // Campo añadido
      profileImgUrl: json['profileImgUrl'] ?? '',
      presentationImgUrl: json['presentationImgUrl'] ?? '',
      userDescription: json['userDescription'] ?? '',
      role: json['role'] ?? 'user',
    );
  }
}
