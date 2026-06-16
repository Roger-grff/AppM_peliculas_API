import 'package:mongo_dart/mongo_dart.dart';

import '../models/peliculas.dart';

class MongoDatabase {
  static const String mongoUrl =
      'mongodb+srv://kaellroom_db_user:zT2gjjFiXIYiXQ4e@cluster0.bnyojcg.mongodb.net/?appName=Cluster0';

  static const String collectionName = 'peliculas';

  static late Db db;
  static late DbCollection collection;

  static Future<void> connect() async {
    db = await Db.create(mongoUrl);
    await db.open();
    collection = db.collection(collectionName);
  }

  static Future<List<Pelicula>> getPeliculas() async {
    final List<Map<String, dynamic>> data = await collection.find().toList();

    return data.map((item) {
      return Pelicula.fromMap(item);
    }).toList();
  }

  static Future<void> insertPelicula(Pelicula pelicula) async {
    await collection.insertOne(pelicula.toMap());
  }

  static Future<void> updatePelicula(Pelicula pelicula) async {
    await collection.updateOne(
      where.eq('id', pelicula.id),
      modify
          .set('titulo', pelicula.titulo)
          .set('genero', pelicula.genero)
          .set('director', pelicula.director)
          .set('anio', pelicula.anio)
          .set('calificacion', pelicula.calificacion)
          .set('poster', pelicula.poster)
          .set('descripcion', pelicula.descripcion)
          .set('fuente', pelicula.fuente),
    );
  }

  static Future<void> deletePelicula(String id) async {
    await collection.deleteOne(
      where.eq('id', id),
    );
  }
}