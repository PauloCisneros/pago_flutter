import 'producto.dart';

// Esta lista será accesible desde cualquier archivo
List<Producto> carrito = [];

// Función auxiliar para calcular el total
double calcularTotal() {
  return carrito.fold(0, (sum, item) => sum + item.precio);
}