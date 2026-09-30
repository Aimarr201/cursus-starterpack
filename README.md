# Cursus starterpack

## Entorno Docker 42

Este proyecto incluye una imagen basada en Debian para trabajar con código de 42 de forma persistente.

### Compatibilidad

Funciona en Linux y Windows con Docker Desktop. En Windows, es más cómodo ejecutar los comandos desde WSL2 o Git Bash, porque el montaje del directorio cambia según la shell.

### Incluye

- `cc` y `make` mediante `build-essential`
- `git` y `vim`
- `python3`, `pip` y `venv`
- `norminette`, `mypy` y `flake8` dentro de un entorno virtual
- locale `es_ES.UTF-8`

### Construir la imagen

```bash
docker build -f docker/Dockerfile.42 -t cursus-42 .
```

### Ejecutar el contenedor con persistencia

Montar el directorio del proyecto en `/42` hace que los cambios se conserven en el host:

Si ya tienes configurado Git en tu sistema, puedes pasar esas credenciales al contenedor para que `git commit` use tu nombre y correo automáticamente.

#### Linux, WSL2 o Git Bash

```bash
docker run -it --rm \
	-e GIT_AUTHOR_NAME="$(git config --global user.name)" \
	-e GIT_AUTHOR_EMAIL="$(git config --global user.email)" \
	-e GIT_COMMITTER_NAME="$(git config --global user.name)" \
	-e GIT_COMMITTER_EMAIL="$(git config --global user.email)" \
	-e USER=tuLogin42 \
	-e MAIL=tuLogin42@student.42.fr \
	-v "$PWD":/42 \
	-w /42 \
	cursus-42
```

#### PowerShell

```powershell
docker run -it --rm `
	-e GIT_AUTHOR_NAME="$(git config --global user.name)" `
	-e GIT_AUTHOR_EMAIL="$(git config --global user.email)" `
	-e GIT_COMMITTER_NAME="$(git config --global user.name)" `
	-e GIT_COMMITTER_EMAIL="$(git config --global user.email)" `
	-e USER=tuLogin42 `
	-e MAIL=tuLogin42@student.42.fr `
	-v "${PWD}:/42" `
	-w /42 `
	cursus-42
```

#### Símbolo del sistema de Windows

```bat
docker run -it --rm ^
	-e GIT_AUTHOR_NAME="%GIT_AUTHOR_NAME%" ^
	-e GIT_AUTHOR_EMAIL="%GIT_AUTHOR_EMAIL%" ^
	-e GIT_COMMITTER_NAME="%GIT_COMMITTER_NAME%" ^
	-e GIT_COMMITTER_EMAIL="%GIT_COMMITTER_EMAIL%" ^
	-e USER=tuLogin42 ^
	-e MAIL=tuLogin42@student.42.fr ^
	-v "%cd%:/42" ^
	-w /42 ^
	cursus-42
```

### Git dentro del contenedor

Al arrancar el contenedor, el entrypoint toma `GIT_AUTHOR_NAME`, `GIT_AUTHOR_EMAIL`, `GIT_COMMITTER_NAME` y `GIT_COMMITTER_EMAIL` si existen, y los aplica a `git config --global`.

Si esos valores no están definidos, usa `USER42` y `MAIL42` como respaldo.

Además, el entrypoint configura `/42` como un directorio seguro (`safe.directory`) en Git para evitar errores de permisos al trabajar con el directorio montado desde el host.

### Header de 42 en Vim

Dentro del contenedor, `:Stdheader` funciona con el plugin de 42header y usa los valores de `USER42` y `MAIL42`.

Si cambias esos valores, el header se generará con tu login y tu correo de 42.

### Uso

Dentro del contenedor puedes compilar, ejecutar Python y lanzar las comprobaciones habituales:

- `git`
- `cc`
- `make`
- `norminette`
- `mypy`
- `flake8`

Los archivos que crees o modifiques dentro de `/42` quedarán guardados en tu máquina mientras trabajes sobre el montaje del host.
