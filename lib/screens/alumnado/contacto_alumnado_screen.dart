import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:iseneca/providers/providers.dart';

/// Pantalla de Contacto Alumnado.
///
/// Esta pantalla permite a los usuarios buscar y seleccionar cursos de los
/// estudiantes para obtener detalles de contacto. Utiliza un `TextEditingController`
/// para manejar la búsqueda y proporciona una lista filtrada de cursos.
///
/// Parámetros:
/// - `key`: Clave opcional para el widget, usada para identificar y actualizar el widget.
class ContactoAlumnadoScreen extends StatefulWidget {
  const ContactoAlumnadoScreen({Key? key}) : super(key: key);

  @override
  _ContactoAlumnadoScreenState createState() => _ContactoAlumnadoScreenState();
}

/// Estado de la pantalla de Contacto Alumnado.
///
/// Gestiona la lógica para inicializar la lista de cursos, manejar la búsqueda
/// y construir la interfaz de usuario.
class _ContactoAlumnadoScreenState extends State<ContactoAlumnadoScreen> {
  List<String> cursosUnicos = [];
  List<String> cursosFiltrados = [];
  TextEditingController _controller = TextEditingController();

  // Método que se llama cuando el widget se ha inicializado en el árbol de widgets.
  // Aquí se configuran las variables necesarias y se preparan los datos para el estado del widget.
  @override
  void initState() {
    super.initState();
    // Inicializa la lista de cursos al inicio
    final alumnadoProvider =
        Provider.of<AlumnadoProvider>(context, listen: false);
    final listadoAlumnos = alumnadoProvider.listadoAlumnos;

    cursosUnicos =
        listadoAlumnos.map((student) => student.curso).toSet().toList();
    cursosFiltrados =
        List.from(cursosUnicos); // Al principio, no se ha filtrado nada
  }

  /// Filtra los resultados de búsqueda según la consulta ingresada.
  ///
  /// - `query`: la cadena de texto ingresada por el usuario para realizar la búsqueda.
  void filterSearchResults(String query) {
    if (query.isNotEmpty) {
      setState(() {
        cursosFiltrados = cursosUnicos
            .where((curso) => curso.toLowerCase().contains(query.toLowerCase()))
            .toList();
      });
    } else {
      setState(() {
        cursosFiltrados = List.from(cursosUnicos);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final alumnadoProvider = Provider.of<AlumnadoProvider>(context);
    final listadoAlumnos = alumnadoProvider.listadoAlumnos;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'CONTACTO',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              width: screenWidth * 0.3,
              margin: const EdgeInsets.only(left: 20),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.grey),
              ),
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.search, color: Colors.white),
                  ),
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      onChanged: (value) {
                        filterSearchResults(value);
                      },
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        hintText: 'Buscar',
                        hintStyle: TextStyle(color: Colors.white54),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: listadoAlumnos.isEmpty
            ? const CircularProgressIndicator()
            : ListView.builder(
                itemCount: cursosFiltrados.length,
                itemBuilder: (BuildContext context, int index) {
                  final curso = cursosFiltrados[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        "contacto_detalles_alumnado_screen",
                        arguments: curso,
                      );
                    },
                    child: Card(
                      elevation: 5,
                      margin: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 20),
                        leading: const Icon(
                          Icons.school,
                          color: Colors.blue,
                          size: 30,
                        ),
                        title: Text(
                          curso,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        trailing: const Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
