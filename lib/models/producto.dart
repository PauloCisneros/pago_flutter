import 'dart:math';

class Producto {
  final String nombre;
  final double precio;

  Producto(this.nombre, this.precio);
}

final List<Producto> listaProductos = [
  Producto('Audífonos Bluetooth', 25.0),
  Producto('Teclado Mecánico', 45.0),
  Producto('Mouse Gamer', 30.0),
  Producto('Monitor 24 pulgadas', 150.0),
  Producto('Tablet', 200.0),
  Producto('Mouse ergonomico', 25.0)
];

String simularPago() {
  final aprobado = Random().nextBool();
  return aprobado ? 'APROBADO' : 'RECHAZADO';
}