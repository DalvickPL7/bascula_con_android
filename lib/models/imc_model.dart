import 'package:flutter/material.dart';
import 'package:flutter_application/models/tip_model.dart';

class IMCModel {
  final String indicador;
  final String silueta;
  final Color color;
  final String nombre;
  final List<TipModel> tips;

  IMCModel({
    required this.indicador,
    required this.silueta,
    required this.color,
    required this.nombre,
    required this.tips,
  });

  factory IMCModel.bajo() => IMCModel(
        indicador: 'assets/images/indicador_bajo.png',
        silueta: 'assets/images/silueta_v_bajo.png',
        color: Color(0xFF49bade),
        nombre: "Bajo",
        tips: [
          TipModel('assets/images/tip1.png', 'Come más y variado',
              'Come muchas frutas, verduras, carnes, y granos. ¡Tu cuerpo necesita energía para crecer fuerte como un superhéroe!'),
          TipModel('assets/images/tip2.png', 'Snack saludables',
              'Come almendras, frutas secas, y yogur entre comidas. ¡Son deliciosos y te darán mucha energía!'),
          TipModel('assets/images/tip3.png', 'Bebe leche',
              'La leche y los productos lácteos te ayudan a tener huesos fuertes como los de un robot'),
        ],
      );

  factory IMCModel.saludable() => IMCModel(
        indicador: 'assets/images/indicador_saludable.png',
        silueta: 'assets/images/silueta_v_saludable.png',
        color: Color(0xFF98b33c),
        nombre: "Saludable",
        tips: [
          TipModel('assets/images/tip4.png', 'Sigue así',
              '¡Estás en un buen camino! Come una variedad de alimentos para mantener tu energía como un corredor rápido.'),
          TipModel('assets/images/tip5.png', 'Juega mucho',
              'Jugar deportes, correr, y saltar son formas divertidas de mantener tu cuerpo fuerte y saludable'),
          TipModel('assets/images/tip6.png', 'Dormir bien',
              'Dormir bien te hace sentir como un campeón cada día. ¡Asegúrate de dormir al menos 8 horas cada noche!'),
        ],
      );

  factory IMCModel.sobrepeso() => IMCModel(
        indicador: 'assets/images/indicador_sobrepeso.png',
        silueta: 'assets/images/silueta_v_sobrepeso.png',
        color: Color(0xFFfc8133),
        nombre: "Sobrepeso",
        tips: [
          TipModel('assets/images/tip7.png', 'Moverse más',
              'Haz que tu cuerpo se mueva. Baila, corre, o juega fútbol. ¡Así quemas energía como un dragón escupiendo fuego!'),
          TipModel('assets/images/tip8.png', 'Come frutas y verduras',
              'Come más zanahorias, manzanas, y otras frutas y verduras. Son como las pociones mágicas de los videojuegos, llenas de cosas buenas para ti.'),
          TipModel('assets/images/tip9.png', 'Menos comida chatarra',
              'Trata de comer menos papas fritas y dulces. ¡Es como evitar los obstáculos en un juego para ganar más puntos!'),
        ],
      );

  factory IMCModel.obesidadI() => IMCModel(
        indicador: 'assets/images/indicador_obesidad_I.png',
        silueta: 'assets/images/silueta_v_obesidad_I.png',
        color: Color(0xFFef433b),
        nombre: "Obesidad I",
        tips: [
          TipModel('assets/images/tip10.png', 'Plan de acción',
              'Trabaja con tus papás y tu doctor para hacer un plan de alimentación divertido y saludable. ¡Es como tener un mapa del tesoro para la salud!'),
          TipModel('assets/images/tip11.png', 'Actividades divertidas',
              'Encuentra un deporte o una actividad que te guste, como nadar, andar en bicicleta, o bailar. ¡Mueve tu cuerpo como si estuvieras en una aventura épica!'),
          TipModel('assets/images/tip12.png', 'Beber agua',
              'Bebe mucha agua en lugar de refrescos. ¡El agua es como la poción mágica que te mantiene hidratado y listo para cualquier desafío!'),
        ],
      );

  factory IMCModel.obesidadII() => IMCModel(
        indicador: 'assets/images/indicador_obesidad_II.png',
        silueta: 'assets/images/silueta_v_obesidad_II.png',
        color: Color(0xFFc53c8a),
        nombre: "Obesidad II",
        tips: [
          TipModel('assets/images/tip10.png', 'Plan de acción',
              'Trabaja con tus papás y tu doctor para hacer un plan de alimentación divertido y saludable. ¡Es como tener un mapa del tesoro para la salud!'),
          TipModel('assets/images/tip11.png', 'Actividades divertidas',
              'Encuentra un deporte o una actividad que te guste, como nadar, andar en bicicleta, o bailar. ¡Mueve tu cuerpo como si estuvieras en una aventura épica!'),
          TipModel('assets/images/tip12.png', 'Beber agua',
              'Bebe mucha agua en lugar de refrescos. ¡El agua es como la poción mágica que te mantiene hidratado y listo para cualquier desafío!'),
        ],
      );

  factory IMCModel.obesidadIII() => IMCModel(
        indicador: 'assets/images/indicador_obesidad_III.png',
        silueta: 'assets/images/silueta_v_obesidad_III.png',
        color: Color(0xFF9a3eb8),
        nombre: "Obesidad III",
        tips: [
          TipModel('assets/images/tip10.png', 'Plan de acción',
              'Trabaja con tus papás y tu doctor para hacer un plan de alimentación divertido y saludable. ¡Es como tener un mapa del tesoro para la salud!'),
          TipModel('assets/images/tip11.png', 'Actividades divertidas',
              'Encuentra un deporte o una actividad que te guste, como nadar, andar en bicicleta, o bailar. ¡Mueve tu cuerpo como si estuvieras en una aventura épica!'),
          TipModel('assets/images/tip12.png', 'Beber agua',
              'Bebe mucha agua en lugar de refrescos. ¡El agua es como la poción mágica que te mantiene hidratado y listo para cualquier desafío!'),
        ],
      );

  static IMCModel getImcModel(double imc) {
    if (imc < 18.5) {
      return IMCModel.bajo();
    } else if (imc < 24.9) {
      return IMCModel.saludable();
    } else if (imc < 29.9) {
      return IMCModel.sobrepeso();
    } else if (imc < 34.9) {
      return IMCModel.obesidadI();
    } else if (imc < 39.9) {
      return IMCModel.obesidadII();
    } else {
      return IMCModel.obesidadIII();
    }
  }

  static double calcularIMC(double peso, double altura) {
    double alturaMetro = altura / 100;
    return peso / (alturaMetro * alturaMetro);
  }
}
