import 'package:flutter/material.dart';
import 'package:iseneca/widgets/lista_opciones.dart';

//Clase actualizada horario quitado por quela dependencia que se utilizaba no es compatible con la compilacion a web
class AgendaScreen extends StatelessWidget {
  const AgendaScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            const BackgroundPaginas(),
            Container(
              margin: const EdgeInsets.only(bottom: 15),
              child: Column(
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      margin: const EdgeInsets.only(top: 20),
                      width: double.infinity,
                      alignment: Alignment.center,
                      child: const Text("Agenda",
                          style: TextStyle(
                              fontSize: 60,
                              color: Colors.white,
                              fontFamily: 'ErasDemi')),
                    ),
                  ),
                ],
              ),
            ),
            const ListaOpciones()
          ],
        ),
      ),
    );
  }
}

class BackgroundPaginas extends StatelessWidget {
  const BackgroundPaginas({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              color: const Color(0xFF02569d),
            ),
          ),
          Expanded(
            flex: 8,
            child: Container(
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}
