# 🚀 Plantilla de Aplicación Flutter con CI/CD para Android 🚀

¡Bienvenido a tu nueva plantilla de proyecto Flutter! 🎉

Esta plantilla te permite iniciar rápidamente una aplicación Flutter y automatizar la creación de tus archivos `.apk` para Android usando GitHub Actions. ¡Olvídate de las configuraciones complejas en tu dispositivo! ✨

## 🌟 Características Principales

-   **Aplicación Flutter Base:** Un proyecto Flutter funcional con el clásico contador. 📱
-   **GitHub Actions Integrado:** Configuración de CI/CD lista para usar. ⚙️
-   **Construcción Automática de APKs:** Genera automáticamente APKs para Android en la nube. ☁️
-   **APKs Divididos por ABI:** Produce APKs más pequeños y optimizados para diferentes arquitecturas de CPU. 🤏
-   **Nombre e Icono Personalizables:** Fácil configuración del nombre y el icono de tu app. 🎨

## 🛠️ ¿Cómo Usar Esta Plantilla? (¡Paso a Paso!) 🛠️

Sigue estos sencillos pasos para crear tu nueva aplicación:

### 1. 🆕 Crear un Nuevo Repositorio desde la Plantilla

   1.  Ve a la página principal de esta plantilla en GitHub: [https://github.com/billybat5/mi_app_flutter](https://github.com/billybat5/mi_app_flutter)
   2.  Haz clic en el botón verde **"Use this template"** (Usar esta plantilla) y selecciona **"Create a new repository"** (Crear un nuevo repositorio). ➕
   3.  Dale un nombre a tu nueva aplicación (por ejemplo, `mi_super_app`) y haz clic en "Create repository". ¡Ya tienes tu nuevo proyecto! 🎉

### 2. 💻 Clonar tu Nuevo Repositorio

   1.  Abre tu terminal (en Termux, Linux, Windows, etc.).
   2.  Clona el **nuevo repositorio** que acabas de crear (¡no la plantilla original!):
       ```bash
       git clone git@github.com:tu-usuario/tu_nueva_app.git
       cd tu_nueva_app
       ```
       *(Reemplaza `tu-usuario` y `tu_nueva_app` con los datos correctos de tu nuevo repositorio).* 📥

### 3. ✍️ Desarrollar tu Aplicación

   1.  Abre el proyecto en tu editor de código favorito (VS Code, Android Studio, etc.).
   2.  El código principal de tu aplicación está en `lib/main.dart`. ¡Empieza a crear tu magia! ✨
   3.  Puedes ejecutar la aplicación localmente para probarla (si tienes Flutter SDK configurado en tu entorno) o simplemente editar el código y confiar en GitHub Actions. 🧪

### 4. ⬆️ Subir tus Cambios a GitHub

   1.  Cuando estés listo para construir tu APK, guarda tus cambios.
   2.  Añade los cambios a Git:
       ```bash
       git add .
       ```
   3.  Haz un commit:
       ```bash
       git commit -m "feat: Mi primera característica"
       ```
   4.  Sube tus cambios a GitHub:
       ```bash
       git push origin main
       ```
       *(Si es la primera vez que subes a este nuevo repositorio, quizás necesites `git push -u origin main`)*. 🚀

### 5. 📦 Descargar tu APK Compilado

   1.  Después de hacer `git push`, ve a tu **nuevo repositorio** en GitHub.
   2.  Haz clic en la pestaña **"Actions"**. ⚙️
   3.  Verás una nueva ejecución del workflow. Espera a que termine (el ícono se pondrá verde ✅).
   4.  Haz clic en el título de la ejecución exitosa.
   5.  En la página de resumen, busca la sección **"Artifacts"** (Artefactos) y haz clic en **`release-apk`** para descargar un archivo `.zip`. 📥
   6.  Descomprime el `.zip`. Dentro encontrarás tus APKs divididos por arquitectura (ej: `app-arm64-v8a-release.apk`). ¡Instálalos en tu dispositivo! 🥳

## 🎨 Personalizar el Nombre y el Icono de tu App 🎨

Para cambiar el nombre y el icono de tu aplicación, sigue estos pasos:

### 1. 🖼️ Cambiar el Icono

   1.  **Prepara tu Icono:** Consigue una imagen cuadrada de alta resolución para tu icono (se recomienda PNG, al menos 512x512 píxeles). Puedes encontrar iconos gratuitos en sitios como [Google Fonts Icons](https://fonts.google.com/icons) (¡recuerda revisar las licencias!).
   2.  **Reemplaza `assets/icon.png`:** En tu proyecto, reemplaza el archivo `assets/icon.png` con tu nuevo icono. Asegúrate de que se llame exactamente `icon.png`. 🖼️
   3.  **Actualiza `pubspec.yaml` (si es necesario):** Si cambiaste la ruta o el nombre del archivo del icono, edita la sección `flutter_launcher_icons` en `pubspec.yaml` para que apunte a la ruta correcta.

### 2. 📝 Cambiar el Nombre de la Aplicación

   1.  Edita el archivo `pubspec.yaml`.
   2.  Busca la sección `flutter_rename_app:` (o `rename:` si lo configuraste así) y modifica el valor de `android:` con el nuevo nombre que deseas para tu aplicación. Por ejemplo:
       ```yaml
       flutter_rename_app:
         android: "Mi Nueva App Genial"
       ```
       *(Nota: Si el paquete `rename` está configurado con el comando `setAppName --value`, entonces el nombre se cambia directamente en el workflow de GitHub Actions, no en `pubspec.yaml`)*. ✏️

### 3. 🚀 Subir los Cambios

   1.  Añade, haz commit y sube tus cambios a GitHub como lo harías normalmente.
   2.  El workflow de GitHub Actions se encargará de aplicar el nuevo icono y nombre a tu APK. ¡Listo! 🎉

--- 

¡Feliz desarrollo con Flutter y GitHub Actions! Si tienes alguna duda, consulta la documentación oficial de Flutter y GitHub Actions. 📚