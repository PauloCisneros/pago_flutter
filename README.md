# Simulador de Pagos con Flutter & Supabase

Esta aplicación es un simulador de sistema de punto de venta (POS) que permite a los usuarios seleccionar productos, gestionar un carrito de compras, procesar pagos simulados de forma segura y consultar su historial de transacciones.

## Flujo de la Aplicación

El flujo de usuario ha sido diseñado para ser intuitivo y seguro:

1. **Catálogo de Productos:** Selección de artículos mediante una lista dinámica.
2. **Carrito de Compras:** Gestión global de productos seleccionados con cálculo de total en tiempo real.
3. **Resumen de Compra:** Validación final del pedido antes de proceder al pago.
4. **Procesamiento de Pago:** Formulario con validaciones de seguridad para datos de tarjeta (titular, número, expiración y CVV).
5. **Historial:** Consulta en tiempo real de los pagos aprobados guardados en la base de datos.

## Validaciones y Seguridad

Para garantizar una experiencia de usuario robusta, se han implementado las siguientes validaciones:

- **Formato de Fecha:** Uso de `TextInputFormatter` para aplicar el formato `MM/AA` automáticamente, evitando errores de entrada.
- **Seguridad en Botones:** Bloqueo del botón "Pagar" durante el proceso de envío (`isLoading`) para evitar transacciones duplicadas.
- **Validación de Formularios:** Verificación estricta de:
    - Longitud mínima de tarjeta (16 dígitos).
    - Formato de CVV (3 dígitos).
    - Campos obligatorios (titular y fechas).
- **Integridad de Datos:** Limpieza automática del carrito al finalizar el pago exitosamente.

## Datos Almacenados en Supabase

Cada transacción exitosa se registra en la tabla `pagos_simulados`. Los datos almacenados incluyen:

- `producto`: Cadena concatenada de los nombres de los productos comprados.
- `total`: Monto final de la transacción.
- `titular`: Nombre del propietario de la tarjeta.
- `ultimos4`: Últimos 4 dígitos de la tarjeta (para trazabilidad sin comprometer seguridad).
- `estado`: Confirmación de 'aprobado'.

### Capturas de la app

Productos

<img width="1918" height="1078" alt="Captura de pantalla 2026-06-19 154639" src="https://github.com/user-attachments/assets/d54b4a72-65ef-446c-ad5b-4879ffc6119e" />

Resumen

<img width="1918" height="972" alt="Captura de pantalla 2026-06-19 154654" src="https://github.com/user-attachments/assets/1255fccc-841f-43d9-85f8-5a031a979666" />

Pago

<img width="1918" height="916" alt="Captura de pantalla 2026-06-19 154716" src="https://github.com/user-attachments/assets/e4853252-1d73-4baa-92ab-7c2ccf2d0f5a" />

Historial

<img width="1918" height="963" alt="Captura de pantalla 2026-06-19 154728" src="https://github.com/user-attachments/assets/68d8badc-a1eb-47c6-8449-74b7ab190410" />

### Capturas del Historial (Base de Datos)

<img width="1912" height="537" alt="image" src="https://github.com/user-attachments/assets/47ec9a0a-0cca-4a7c-a637-0196ce576f98" />

---

## 🛠️ Tecnologías Utilizadas
- **Flutter** (Framework de UI)
- **Supabase** (Backend como Servicio - Base de datos PostgreSQL)
- **Dart** (Lenguaje de programación)

---
*Desarrollado como proyecto de simulación de pasarela de pagos.*
