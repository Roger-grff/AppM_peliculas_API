import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../db/mongo_database.dart';
import '../models/peliculas.dart';

class FormPage extends StatefulWidget {
  final Pelicula? pelicula;

  const FormPage({
    super.key,
    this.pelicula,
  });

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController tituloCtrl = TextEditingController();
  final TextEditingController generoCtrl = TextEditingController();
  final TextEditingController directorCtrl = TextEditingController();
  final TextEditingController anioCtrl = TextEditingController();
  final TextEditingController calificacionCtrl = TextEditingController();
  final TextEditingController posterCtrl = TextEditingController();
  final TextEditingController descripcionCtrl = TextEditingController();
  final TextEditingController fuenteCtrl = TextEditingController();

  bool guardando = false;

  @override
  void initState() {
    super.initState();

    final Pelicula? item = widget.pelicula;

    if (item != null) {
      tituloCtrl.text = item.titulo;
      generoCtrl.text = item.genero;
      directorCtrl.text = item.director;
      anioCtrl.text = item.anio.toString();
      calificacionCtrl.text = item.calificacion.toString();
      posterCtrl.text = item.poster;
      descripcionCtrl.text = item.descripcion;
      fuenteCtrl.text = item.fuente;
    }
  }

  @override
  void dispose() {
    tituloCtrl.dispose();
    generoCtrl.dispose();
    directorCtrl.dispose();
    anioCtrl.dispose();
    calificacionCtrl.dispose();
    posterCtrl.dispose();
    descripcionCtrl.dispose();
    fuenteCtrl.dispose();
    super.dispose();
  }

  Future<void> guardar() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      guardando = true;
    });

    final Pelicula pelicula = Pelicula(
  id: widget.pelicula?.id ?? const Uuid().v4(),
  titulo: tituloCtrl.text.trim(),
  genero: generoCtrl.text.trim(),
  director: directorCtrl.text.trim(),
  anio: int.tryParse(anioCtrl.text.trim()) ?? 0,
  calificacion:
      double.tryParse(
        calificacionCtrl.text.trim(),
      ) ??
      0,
  poster: posterCtrl.text.trim(),
  descripcion: descripcionCtrl.text.trim(),
  fuente: fuenteCtrl.text.trim(),
);
print('Guardando...');    
    try {
      if (widget.pelicula == null) {
        await MongoDatabase.insertPelicula(pelicula);
      } else {
        await MongoDatabase.updatePelicula(pelicula);
      }

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Película guardada correctamente'),
        ),
      );

      tituloCtrl.clear();
      generoCtrl.clear();
      directorCtrl.clear();
      anioCtrl.clear();
      calificacionCtrl.clear();
      posterCtrl.clear();
      descripcionCtrl.clear();
      fuenteCtrl.clear();

    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error al guardar: $e'),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          guardando = false;
        });
      }
    }
  }

  Widget campoTexto(
    TextEditingController controller,
    String label, {
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'Campo obligatorio';
          }
          return null;
        },
      ),
    );
  }

  Widget campoNumero(
    TextEditingController controller,
    String label,
  ) {
    return campoTexto(
      controller,
      label,
      keyboardType: const TextInputType.numberWithOptions(
        decimal: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool editando = widget.pelicula != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          editando
              ? 'Editar Serie'
              : 'Nueva Serie',
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              campoTexto(
                tituloCtrl,
                'Título',
              ),
              campoTexto(
                generoCtrl,
                'Género',
              ),
              campoTexto(
                directorCtrl,
                'Director',
              ),
              campoNumero(
                anioCtrl,
                'Año',
              ),
              campoNumero(
                calificacionCtrl,
                'Calificación',
              ),
              campoTexto(
                posterCtrl,
                'URL del Poster',
              ),
              campoTexto(
                descripcionCtrl,
                'Descripción',
                maxLines: 3,
              ),
              campoTexto(
                fuenteCtrl,
                'Fuente',
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed:
                      guardando ? null : guardar,
                  icon: const Icon(Icons.save),
                  label: Text(
                    guardando
                        ? 'Guardando...'
                        : 'Guardar',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}