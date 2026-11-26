// Carga el paquete base de Flutter con los componentes gráficos de Material Design
import 'package:flutter/material.dart';

// Punto de entrada de la aplicación móvil; inicia el árbol de widgets en pantalla
void main() {
  debugPrint('Arrancando módulo de registro laboral - Melissa Campos...');
  runApp(const FormularioPersonalApp());
}

// Widget principal sin estado que define la configuración global, colores y pantalla inicial
class FormularioPersonalApp extends StatelessWidget {
  const FormularioPersonalApp({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint('Renderizando la aplicación raíz FormularioPersonalApp');
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Elimina la etiqueta "DEBUG" de la esquina superior derecha
      title: 'Empresa XYZ · Registro',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1B5E20)),
        useMaterial3: true,
      ),
      home: const PantallaFichaEmpleado(), // Establece la vista del formulario como inicio
    );
  }
}

// Widget con estado (StatefulWidget) necesario para redibujar la interfaz al pulsar el botón
class PantallaFichaEmpleado extends StatefulWidget {
  const PantallaFichaEmpleado({super.key});

  @override
  State<PantallaFichaEmpleado> createState() => _PantallaFichaEmpleadoState();
}

// Estado interno donde se gestionan los controladores de entrada y la salida en pantalla
class _PantallaFichaEmpleadoState extends State<PantallaFichaEmpleado> {
  // Instancias de TextEditingController para capturar el texto digitado en los 4 campos
  final TextEditingController _inputNombres = TextEditingController();
  final TextEditingController _inputDomicilio = TextEditingController();
  final TextEditingController _inputNacimiento = TextEditingController();
  final TextEditingController _inputPuesto = TextEditingController();

  // Cadena que almacenará el resumen concatenado una vez que se presione el botón
  String resumenDatos = '';

  // Libera los recursos asociados a cada controlador al cerrar la vista
  @override
  void dispose() {
    _inputNombres.dispose();
    _inputDomicilio.dispose();
    _inputNacimiento.dispose();
    _inputPuesto.dispose();
    super.dispose();
  }

  // Método auxiliar que construye las etiquetas superiores de cada campo del formulario
  Widget _etiquetaCampo(String titulo) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6.0),
      child: Text(
        titulo,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: Color(0xFF1C2833),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('Actualizando interfaz gráfica en _PantallaFichaEmpleadoState');

    // Paleta en tonos verde bosque y verde menta suave para mantener la línea visual solicitada
    const Color colorPrimario = Color(0xFF1B5E20);
    const Color fondoTarjeta = Color(0xFFE8F5E9);

    // Scaffold arma la estructura visual estándar: barra de título superior y área de contenido
    return Scaffold(
      appBar: AppBar(
        title: const Text('Empresa XYZ · Registro'),
        backgroundColor: colorPrimario,
        foregroundColor: Colors.white,
        elevation: 2,
      ),
      // Permite desplazar la pantalla verticalmente cuando el teclado virtual ocupa espacio
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Bloque 1: Captura de nombres completos
            _etiquetaCampo('Nombres completos'),
            TextField(
              controller: _inputNombres,
              textCapitalization: TextCapitalization.words,
              decoration: InputDecoration(
                hintText: 'Ej.: Melissa Elizabeth Campos Ortega',
                hintStyle: TextStyle(color: Colors.grey.shade400),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              ),
            ),
            const SizedBox(height: 14),

            // Bloque 2: Captura de dirección domiciliaria
            _etiquetaCampo('Dirección'),
            TextField(
              controller: _inputDomicilio,
              decoration: InputDecoration(
                hintText: 'Ej.: Av. 9 de Octubre y Malecón, Guayaquil',
                hintStyle: TextStyle(color: Colors.grey.shade400),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              ),
            ),
            const SizedBox(height: 14),

            // Bloque 3: Captura de fecha de nacimiento con ícono informativo de calendario
            _etiquetaCampo('Fecha de nacimiento'),
            TextField(
              controller: _inputNacimiento,
              keyboardType: TextInputType.datetime,
              decoration: InputDecoration(
                hintText: 'dd/mm/aaaa',
                hintStyle: TextStyle(color: Colors.grey.shade400),
                suffixIcon: const Icon(Icons.event_note_outlined, size: 20, color: colorPrimario),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              ),
            ),
            const SizedBox(height: 14),

            // Bloque 4: Captura del cargo laboral
            _etiquetaCampo('Cargo'),
            TextField(
              controller: _inputPuesto,
              decoration: InputDecoration(
                hintText: 'Ej.: Analista de sistemas',
                hintStyle: TextStyle(color: Colors.grey.shade400),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              ),
            ),
            const SizedBox(height: 22),

            // Botón de acción que dispara setState() para volcar los valores ingresados en pantalla
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: colorPrimario,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              onPressed: () {
                // Notifica a Flutter que el estado cambió y debe volver a ejecutar build()
                setState(() {
                  resumenDatos = 'Nombre: ${_inputNombres.text}\n'
                      'Dirección: ${_inputDomicilio.text}\n'
                      'Nacimiento: ${_inputNacimiento.text}\n'
                      'Cargo: ${_inputPuesto.text}';
                });
              },
              child: const Text(
                'MOSTRAR DATOS',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, letterSpacing: 0.6),
              ),
            ),
            const SizedBox(height: 18),

            // Panel inferior dinámico: muestra mensaje de espera al inicio y los datos al pulsar el botón
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: resumenDatos.isEmpty ? Colors.grey.shade100 : fondoTarjeta,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: resumenDatos.isEmpty ? Colors.grey.shade300 : colorPrimario,
                  width: 1.2,
                ),
              ),
              child: resumenDatos.isEmpty
                  ? Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  child: Text(
                    'Aquí se mostrarán los datos\nal presionar el botón',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey.shade500, fontSize: 14),
                  ),
                ),
              )
                  : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Título superior del cuadro de salida de datos
                  const Text(
                    'DATOS REGISTRADOS',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: colorPrimario,
                    ),
                  ),
                  const Divider(height: 12, thickness: 0.8),
                  // Texto formateado con la información capturada de los 4 TextField
                  Text(
                    resumenDatos,
                    style: const TextStyle(fontSize: 14, color: Colors.black87, height: 1.45),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}