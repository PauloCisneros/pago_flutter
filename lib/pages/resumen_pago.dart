import 'package:flutter/material.dart';
import '/models/carrito_global.dart'; // Tu lista global y función de total
import '/pages/formulario.dart'; // El formulario de pago (Paso 3)

class ResumenPago extends StatefulWidget {
  const ResumenPago({super.key});

  @override
  State<ResumenPago> createState() => _ResumenPagoState();
}

class _ResumenPagoState extends State<ResumenPago> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Resumen de Compra")),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: carrito.length,
              itemBuilder: (context, index) {
                final producto = carrito[index];
                return ListTile(
                  title: Text(producto.nombre),
                  trailing: Text("\$${producto.precio.toStringAsFixed(2)}"),
                );
              },
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Total a pagar:", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                Text("\$${calcularTotal().toStringAsFixed(2)}", style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 30),
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(250, 50),
              ),
              icon: const Icon(Icons.credit_card),
              label: const Text("Proceder al Pago"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const FormularioPago()),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}