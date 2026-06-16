class Pelicula {
  String? id;
  String titulo;
  String genero;
  String director;
  int anio;
  double calificacion;
  String poster;
  String descripcion;
  String fuente;

  Pelicula({
    this.id,
    required this.titulo,
    required this.genero,
    required this.director,
    required this.anio,
    required this.calificacion,
    required this.poster,
    required this.descripcion,
    required this.fuente,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'titulo': titulo,
      'genero': genero,
      'director': director,
      'anio': anio,
      'calificacion': calificacion,
      'poster': poster,
      'descripcion': descripcion,
      'fuente': fuente,
    };
  }

  factory Pelicula.fromMap(Map<String, dynamic> map) {
    return Pelicula(
      id: map['id'],
      titulo: map['titulo'],
      genero: map['genero'],
      director: map['director'],
      anio: map['anio'],
      calificacion: map['calificacion'].toDouble(),
      poster: map['poster'],
      descripcion: map['descripcion'],
      fuente: map['fuente'],
    );
  }
}