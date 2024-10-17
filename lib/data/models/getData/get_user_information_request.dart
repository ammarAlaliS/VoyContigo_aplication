class UserInformation {
  final String name;
  final String lastName;
  final String email;
  final String profileImgUrl; 
  final String presentationImgUrl; 
  final String userDescription;
  final String role; 

  UserInformation({
    required this.name,
    required this.lastName,
    required this.email,
    this.profileImgUrl = '', 
    this.presentationImgUrl = '',
    this.userDescription = '',
    this.role = 'user',
  });

  factory UserInformation.fromMap(Map<String, dynamic> data) {
    return UserInformation(
      name: data['name'] ?? '',
      lastName: data['lastName'] ?? '',
      email: data['email'] ?? '',
      profileImgUrl: data['profileImgUrl'] ?? '',
      presentationImgUrl: data['presentationImgUrl'] ?? '',
      userDescription: data['userDescription'] ?? '',
      role: data['role'] ?? 'user',
    );
  }
}
