class Mensaje {
  final int id;
  final String nick;
  final String mensaje;

  Mensaje({
    required this.id,
    required this.nick,
    required this.mensaje,
  });

  factory Mensaje.fromJson(Map<String, dynamic> json) => Mensaje(
        id: json["id"],
        nick: json["nick"],
        mensaje: json["mensaje"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nick": nick,
        "mensaje": mensaje,
      };
}
