import 'package:flutter/material.dart';
import '../models/producto.dart';
import '../models/carrito_global.dart';
import 'resumen_pago.dart';
import 'historial''.dart'; 

class PantallaProductos extends StatefulWidget {
  const PantallaProductos({super.key});

  @override
  State<PantallaProductos> createState() => _PantallaProductosState();
}

class _PantallaProductosState extends State<PantallaProductos> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Catálogo de Productos"),
        centerTitle: true,
        actions: [
          // <--- 2. Botón para acceder al historial
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const HistorialPago()),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.only(bottom: 80),
        itemCount: listaProductos.length,
        itemBuilder: (context, index) {
          final producto = listaProductos[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: ListTile(
              leading: const CircleAvatar(child: Icon(Icons.shopping_bag)),
              title: Text(producto.nombre),
              subtitle: Text("\$${producto.precio.toStringAsFixed(2)}"),
              trailing: IconButton(
                icon: const Icon(Icons.add_circle, color: Colors.blue, size: 30),
                onPressed: () {
                  setState(() {
                    carrito.add(producto);
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${producto.nombre} agregado'),
                      duration: const Duration(seconds: 1),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: carrito.isEmpty 
          ? null 
          : () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ResumenPago()),
              );
            },
        label: Text("Pagar \$${calcularTotal().toStringAsFixed(2)}"),
        icon: const Icon(Icons.payment),
        backgroundColor: carrito.isEmpty ? Colors.grey : Colors.blue,
      ),
    );
  }
}