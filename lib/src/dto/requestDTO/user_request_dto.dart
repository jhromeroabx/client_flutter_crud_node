class UserLoginBody {
  String? user;
  String? contrasenia;

  UserLoginBody({
    required this.user,
    required this.contrasenia,
  });

  Map<String, dynamic> toJson() => {
        "user": user,
        "contrasenia": contrasenia,
      };
}

class UserReqAddEditBody {
  int? id;
  String? nombre;
  String? apellido;
  String? dni;
  String? telefono;
  String? email;
  String? fechaNacimiento;
  String? contrasenia;

  UserReqAddEditBody({
    this.id,
    required this.nombre,
    required this.apellido,
    required this.dni,
    required this.telefono,
    required this.email,
    required this.fechaNacimiento,
    required this.contrasenia,
  });

  Map<String, dynamic> toJson() => {
        "id": id ?? 0,
        "nombre": nombre,
        "apellido": apellido,
        "dni": dni,
        "telefono": telefono,
        "email": email,
        "fechaNacimiento": fechaNacimiento,
        "contrasenia": contrasenia,
      };
}
