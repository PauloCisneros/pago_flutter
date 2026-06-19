import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '/models/carrito_global.dart'; // Importamos la lista global
import '/main.dart'; // Para acceder a guardarPagoSupabase

// Formateador para fecha MM/AA
class DateFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    var text = newValue.text;
    if (newValue.selection.baseOffset == 0) return newValue;
    if (text.length > 5) return oldValue;
    if (text.length == 2 && oldValue.text.length != 3) text += '/';
    return TextEditingValue(text: text, selection: TextSelection.collapsed(offset: text.length));
  }
}

class FormularioPago extends StatefulWidget {
  const FormularioPago({super.key});

  @override
  State<FormularioPago> createState() => _FormularioPagoState();
}

class _FormularioPagoState extends State<FormularioPago> {
  final formKey = GlobalKey<FormState>();
  final titularCtrl = TextEditingController();
  final tarjetaCtrl = TextEditingController();
  final expiracionCtrl = TextEditingController();
  final cvvCtrl = TextEditingController();
  bool _isLoading = false;

  Future<void> _procesarPago() async {
    if (!formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      // Unimos los nombres de los productos del carrito en una cadena
      String productosNombres = carrito.map((p) => p.nombre).join(', ');
      String ultimos4 = tarjetaCtrl.text.substring(tarjetaCtrl.text.length - 4);

      await guardarPagoSupabase(
        productos: productosNombres,
        total: calcularTotal(), // Usamos el total global
        titular: titularCtrl.text,
        ultimos4: ultimos4,
        estado: 'aprobado',
      );

      if (!mounted) return;

      // Limpiamos el carrito tras el pago exitoso
      carrito.clear();

      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text("¡Pago Exitoso!"),
          content: const Text("Tu compra ha sido procesada correctamente."),
          actions: [
            TextButton(
              onPressed: () {
                // Volvemos al inicio eliminando las pantallas previas
                Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
              },
              child: const Text("Aceptar"),
            )
          ],
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error: $e")));
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Datos de Pago")),
      body: Form(
        key: formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: titularCtrl,
              decoration: const InputDecoration(labelText: 'Titular de la tarjeta'),
              validator: (v) => (v?.isEmpty ?? true) ? 'Campo obligatorio' : null,
            ),
            TextFormField(
              controller: tarjetaCtrl,
              decoration: const InputDecoration(labelText: 'Número de tarjeta'),
              keyboardType: TextInputType.number,
              validator: (v) => (v?.length ?? 0) < 16 ? 'Mínimo 16 dígitos' : null,
            ),
            TextFormField(
              controller: expiracionCtrl,
              decoration: const InputDecoration(labelText: 'Expiración (MM/AA)'),
              keyboardType: TextInputType.number,
              inputFormatters: [DateFormatter()],
              validator: (v) => (v?.length != 5) ? 'Formato MM/AA' : null,
            ),
            TextFormField(
              controller: cvvCtrl,
              decoration: const InputDecoration(labelText: 'CVV'),
              keyboardType: TextInputType.number,
              obscureText: true,
              validator: (v) => (v?.length != 3) ? '3 dígitos' : null,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isLoading ? null : _procesarPago,
              child: _isLoading 
                ? const CircularProgressIndicator() 
                : Text("Pagar \$${calcularTotal().toStringAsFixed(2)}"),
            ),
          ],
        ),
      ),
    );
  }
}