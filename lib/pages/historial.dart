import 'package:flutter/material.dart';
import '../main.dart'; 

class HistorialPago extends StatelessWidget {
  const HistorialPago({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Historial de Pagos")),
      body: StreamBuilder(
        // Escucha cambios en tiempo real en la tabla
        stream: supabase.from('pagos_simulados').stream(primaryKey: ['id']),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No hay pagos registrados aún."));
          }

          final pagos = snapshot.data!;

          return ListView.builder(
            itemCount: pagos.length,
            itemBuilder: (context, i) {
              final pago = pagos[i];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: ListTile(
                  leading: const Icon(Icons.receipt_long, color: Colors.green),
                  title: Text(pago['producto']), // Los productos concatenados
                  subtitle: Text("Titular: ${pago['titular']} • ****${pago['ultimos4']}"),
                  trailing: Text("\$${pago['total'].toStringAsFixed(2)}", 
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                ),
              );
            },
          );
        },
      ),
    );
  }
}