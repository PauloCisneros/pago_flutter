import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'pages/productos_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: '',
    anonKey: '', 
  );

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PantallaProductos(),
    );
  }
}

final supabase = Supabase.instance.client;

Future<void> guardarPagoSupabase({
  required String productos, // Recibimos la lista como texto
  required double total,
  required String titular,
  required String ultimos4,
  required String estado,
}) async {
  await supabase.from('pagos_simulados').insert({
    'producto': productos, // Ej: "Audífonos, Teclado"
    'total': total,
    'titular': titular,
    'ultimos4': ultimos4,
    'estado': estado,
  });
}
