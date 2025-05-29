
# 📱 Flutter App - Nombre del Proyecto

Este es un proyecto desarrollado con [Flutter](https://flutter.dev/) que permite ejecutar una aplicación multiplataforma (Android, iOS).

---

## 🚀 Requisitos Previos

Antes de comenzar, asegúrate de tener instalado lo siguiente:

- [Flutter SDK](https://docs.flutter.dev/get-started/install) (versión estable recomendada)
- [Dart SDK](https://dart.dev/get-dart) (viene incluido con Flutter)
- [Android Studio](https://developer.android.com/studio) o [VSCode](https://code.visualstudio.com/) con extensiones de Flutter y Dart
- Un emulador o dispositivo físico conectado

Para verificar la instalación, ejecuta:

```bash
flutter doctor
```

## 📦 Instalación del Proyecto

Clona este repositorio en tu máquina local:

```bash
git clone git@github.com:AlexLoLar/castor_exam.git
cd castor_exam
```

Instala las dependencias:

```bash
flutter pub get
```

## 🛠️ Compilar y Ejecutar

### ▶️ Android

```bash
flutter run -d android
```

### ▶️ IOS

```bash
flutter run -d ios

# Si es la primera vez que compilas para iOS:

open ios/Runner.xcworkspace
```

## 🧪 Compilación para Producción

### Android (APK):

```bash
flutter build apk --release
```

El archivo generado estará en:

```
build/app/outputs/flutter-apk/app-release.apk
```

### iOS:

```bash
flutter build ios --release
```

Este comando genera un proyecto listo para compilar con Xcode. Luego de ejecutar el comando, abre el proyecto en Xcode:

```
open ios/Runner.xcworkspace
```

Desde allí, selecciona tu dispositivo o simulador, y presiona **Run** o genera el archivo `.ipa` desde el menú Product → Archive.

> ⚠️ Requiere una Mac con Xcode instalado 

---

## 📁 Estructura del Proyecto

```bash
├───lib
│   ├───config                  # Configuración general como temas, colores, rutas
│   ├───core                    # Clases base, utilidades y helpers comunes
│   └───features                # Módulos o funcionalidades del aplicativo
│       ├───nombre_feature/     # Cada feature sigue la arquitectura limpia
│   │
│   ├── injection_container.dart # Configuración de la inyección de dependencias
│   └── main.dart                # Punto de entrada principal del proyecto
```

---

## ✅ Buenas Prácticas

- Sigue la estructura recomendada por **Clean Architecture**
- Usa el patrón de gestión de estado **BLoC**
- Manténer el código modular y reutilizable
---
