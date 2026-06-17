import 'package:mongo_dart/mongo_dart.dart';
import '../models/peliculas.dart';

class MongoDatabase {
  static const String mongoUrl =
      'mongodb+srv://kaellroom_db_user:zT2gjjFiXIYiXQ4e@cluster0.bnyojcg.mongodb.net/peliculas_db?retryWrites=true&w=majority&appName=Cluster0';

  static const String collectionName = 'peliculas';

  static Db? db;
  static DbCollection? collection;

  static Future<void> connect() async {
    try {
      if (db != null && db!.isConnected) {
        return;
      }

      db = await Db.create(mongoUrl);
      await db!.open();

      collection = db!.collection(collectionName);

      print('MongoDB conectado');
    } catch (e) {
      print('Error conectando MongoDB: $e');
      rethrow;
    }
  }

  static Future<void> verificarConexion() async {
    if (db == null || !db!.isConnected) {
      await connect();
    }
  }

  static Future<List<Pelicula>> getPeliculas() async {
    await verificarConexion();

    final data =
        await collection!.find().toList();

    return data
        .map((e) => Pelicula.fromMap(e))
        .toList();
  }

  static Future<void> insertPelicula(
      Pelicula pelicula) async {
    await verificarConexion();

    await collection!.insertOne(
      pelicula.toMap(),
    );
  }

  static Future<void> updatePelicula(
      Pelicula pelicula) async {
    await verificarConexion();

    await collection!.updateOne(
      where.eq('id', pelicula.id),
      modify
          .set('titulo', pelicula.titulo)
          .set('genero', pelicula.genero)
          .set('director', pelicula.director)
          .set('anio', pelicula.anio)
          .set('calificacion',
              pelicula.calificacion)
          .set('poster', pelicula.poster)
          .set('descripcion',
              pelicula.descripcion)
          .set('fuente', pelicula.fuente),
    );
  }

  static Future<void> deletePelicula(
      String id) async {
    await verificarConexion();

    await collection!.deleteOne(
      where.eq('id', id),
    );
  }
}