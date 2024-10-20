enum UserRole {
  usuario,
  administrador,
  pasajero,
  conductor,
}

extension UserRoleExtension on UserRole {
  String get name {
    switch (this) {
      case UserRole.usuario:
        return 'Usuario';
      case UserRole.administrador:
        return 'Administrador';
      case UserRole.pasajero:
        return 'Pasajero';
      case UserRole.conductor:
        return 'Conductor';
      default:
        return '';
    }
  }

  static UserRole fromString(String role) {
    switch (role) {
      case 'Administrador':
        return UserRole.administrador;
      case 'Pasajero':
        return UserRole.pasajero;
      case 'Conductor':
        return UserRole.conductor;
      case 'Usuario':
      default:
        return UserRole.usuario;
    }
  }
}
