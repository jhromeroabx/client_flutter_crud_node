class Login {
  Login({
    this.state,
    this.userData,
  });

  State? state;
  UserData? userData;

  factory Login.fromMap(Map<String, dynamic> json) => Login(
        state: State.fromMap(json["state"]),
        userData: json["userData"] == null
            ? null
            : UserData.fromMap(json["userData"]),
      );
}

class State {
  State({
    this.msg,
    this.state,
  });

  String? msg;
  bool? state;

  factory State.fromMap(Map<String, dynamic> json) => State(
        msg: json["msg"],
        state: json["state"] == 1 ? true : false,
      );
}

class UserData {
  UserData({
    this.id,
    this.nombre,
    this.apellido,
    this.dni,
    this.telefono,
    this.email,
    this.fechaNacimiento,
    this.estado,
    this.idUserType,
  });

  int? id;
  String? nombre;
  String? apellido;
  String? dni;
  String? telefono;
  String? email;
  DateTime? fechaNacimiento;
  int? estado;
  int? idUserType;

  factory UserData.fromMap(Map<String, dynamic> json) => UserData(
        id: json["id"],
        nombre: json["nombre"],
        apellido: json["apellido"],
        dni: json["dni"],
        telefono: json["telefono"],
        email: json["email"],
        fechaNacimiento: DateTime.parse(json["fecha_nacimiento"]),
        estado: json["estado"],
        idUserType: json["id_user_type"],
      );
}
