# Guía de Supervivencia: Git de Cero a Héroe

Esta guía está diseñada para entender Git paso a paso, desde lo más básico hasta cómo colaborar en un equipo sin romper nada. Ideal para una presentación rápida.

---

## 1. Introducción

### ¿Qué resuelve Git?
*   **La Máquina del tiempo:** Si rompes algo, puedes volver a una versión anterior.
*   **Trabajo en equipo:** Permite que múltiples personas trabajen en el mismo código al mismo tiempo sin sobrescribir el trabajo del compañero.
*   **Trazabilidad:** Saber quién hizo qué cambio, cuándo y por qué.

### Git vs GitHub
*   **Git:** Es el programa de consola que instalas en tu ordenador. Funciona de manera local.
*   **GitHub/GitLab/Bitbucket:** Son servicios en la nube que alojan tus repositorios Git para que otros puedan verlos y colaborar.

---

## 2. Primeros Pasos

### Configuración inicial
Antes de hacer nada, Git necesita saber quién eres para firmar tus cambios.
```bash
git config --global user.name "Tu Nombre"
git config --global user.email "tu@email.com"
```
(Solo se hace una vez)

### Iniciar un proyecto
*   **Empezar un proyecto localmente:**
    ```bash
    git init
    ```
*   **Descargar un proyecto existente desde la nube:**
    ```bash
    git clone https://github.com/usuario/repo.git
    ```

---

## 3. El Flujo Básico Local

1.  **¿En qué estado estoy?**
    ```bash
    git status
    ```
    *Te dice qué archivos has modificado, cuáles son nuevos y cuáles están añadidos.*

2.  **Staging Area / Añadido:**
    Añade los archivos que quieres incluir en el proximo commit.
    ```bash
    git add archivo.txt   # Añade un archivo específico
    git add -A             # Añade TODOS los cambios del directorio actual
    ```

3.  **Commit:**
    Guarda los cambios preparados con un mensaje descriptivo y claro.
    ```bash
    git commit -m "Añade la página de inicio al proyecto"
    ```

4.  **Ver el historial de commits:**
    ```bash
    git log
    git log --oneline
    ```

---

## 4. Pequeñas Correcciones (¡Me equivoqué!)

*   **Me equivoqué al hacer `git add`:** (Sacar un archivo de la zona de preparación).
    ```bash
    git restore --staged archivo.txt
    ```
*   **Me equivoqué en el mensaje del último commit o me faltó un archivo:**
    Haz tus cambios, haz `git add`, y luego ejecuta:
    ```bash
    git commit --amend -m "Nuevo mensaje corregido"
    ```
    *(Ojo: nunca hagas esto si ya has subido el commit a internet).*

---

## 5. Ignorar Archivos: `.gitignore`

No queremos guardar todo en Git (ej. contraseñas, logs, variables de entorno, archivos compilados...).
Para evitarlo, crea un archivo llamado `.gitignore` en la raíz del proyecto:
```text
# Ignorar variables de entorno/secretos
.env
# Ignorar archivos compilados
a.out
```

---

## 6. Ramas (Branches)

Las ramas son como líneas temporales paralelas. Te permiten trabajar en nuevas ideas sin miedo a romper la rama principal (generalmente llamada `main`).
La regla es: Una funcionalidad == una rama
*   **Ver ramas existentes:**
    ```bash
    git branch
    ```
*   **Descargar ramas remotas:**
    ```bash
    git branch -r
    ```
*   **Crear una rama nueva:**
    ```bash
    git branch mi-nueva-funcionalidad
    ```
*   **Moverte a una rama:**
    ```bash
    git switch mi-nueva-funcionalidad
    ```
*   **Atajo (Crear y moverte a la vez):**
    ```bash
    git switch -c mi-nueva-funcionalidad
    ```

---

## 7. Sincronización (Remoto)

*   **Subir tus cambios a la nube:**
    ```bash
    git push origin nombre-de-tu-rama
    ```
*   **Traer cambios de la nube a tu ordenador:**
    ```bash
    git pull origin main
    ```
*   **El guardado temporal (Stash):**
    Imagina que estás a medias con un código, pero necesitas hacer un `pull` o cambiar de rama. Si haces un commit, guardarás código roto. Usa el "cajón" temporal:
    ```bash
    git stash        # Guarda tus cambios sucios temporalmente
    # ... haz tu pull o cambia de rama, haz lo que necesites ...
    git stash pop    # Saca tus cambios del cajón y aplícalos donde estés
    ```

---

## 8. Integración de Cambios

Cuando tu rama está lista, hay que juntarla de vuelta con la rama principal.

### Merge (Fusión)
Junta la historia de ambas ramas creando un commit especial de unión. Es el método más común y seguro para principiantes.
```bash
git switch main
git merge mi-nueva-funcionalidad
```

### Rebase
Toma tus commits y los "despega" para volver a pegarlos *encima* de los últimos cambios de main. Deja un historial en línea recta y limpio, pero puede reescribir la historia.
*(Regla de oro: Nunca hagas rebase de ramas que ya estén compartidas con otras personas).*

---

## 9. Deshaciendo la Historia

### Reset (El viaje destructivo)
Retrocede tu rama hacia atrás en el tiempo. Útil solo para cambios locales no subidos.
*   **Soft:** Deshace el commit, pero te deja los cambios listos en el *staging* para volver a comitear.
    ```bash
    git reset --soft HEAD~1
    ```
*   **mixed:** Borra el commit y conserva los cambios en el código.
    ```bash
    git reset --mixed HEAD~1
    ```
*   **Hard:** Borra el commit y **DESTRUYE** los cambios en el código.
    ```bash
    git reset --hard HEAD~1
    ```

### Revert
Si tu error ya está subido a GitHub usa `revert`.
Esto crea un *nuevo* commit que hace exactamente lo contrario al commit del error. No se pierde historia y el código se arregla.
```bash
git revert <hash-del-commit-malo>
```

---

## 10. Colaboración en Equipo

*   **Pull Requests (PR) / Merge Requests:**
    En un entorno real, casi nunca haces `git merge` tú mismo. Trabajas en tu rama, haces `push`, y vas a GitHub para abrir un "Pull Request". Es una petición visual donde tus compañeros pueden revisar tu código línea por línea, comentar, y si está bien, darle al botón verde de "Merge".
*   **Reglas de ramas (Branch Protection):**
    Para evitar desastres, los equipos configuran GitHub para bloquear la rama `main`. Se impide hacer push directo; todo cambio debe llegar a través de un PR aprobado por al menos otra persona.

---

## 11. Para el dia a dia

### `.gitignore` Global
Igual que hay un `.gitignore` por proyecto, puedes decirle a Git que ignore ciertos archivos en **todos** tus proyectos automáticamente.
```bash
git config --global core.excludesfile ~/.gitignore_global
```

### Alias / Funciones de terminal
Puedes crear alias/funciones en terminal para comandos que uses siempre, aqui dejo mis favoritos:
(Estas funciones y alias se declaran en el archivo ~/.zshrc)

```bash
alias ls='ls --color=auto'

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

alias gs='git status'
alias ga='git add .'
alias gc='git commit -m'
alias gp='git push'
alias gl='git log --oneline --graph --decorate'
```
_normi_ limpia la consola y pasa norminette.
```bash
normi() {
        clear && norminette
}
```
_c_ limpia la consola, compila con flags, ejecuta y borra el ejecutable
```bash
c() {
        clear && cc -Wall -Wextra -Werror -fsanitize=address -g3 "$@" && ./a.out && rm a.out
}
```

_m_ misma logica que el anterior pero para makefile
```bash
m() {
        clear\
        && make\
        && cc -Wall -Wextra -Werror -fsanitize=address -g3 "$@"\
        && clear\
        && ./a.out\
        && make fclean > /dev/null\
        && rm a.out
}
```

### Herramientas Visuales: GitKraken
Aunque usar la terminal es fundamental para entender qué pasa, el historial de ramas se entiende infinitamente mejor de forma visual.
Herramientas como **GitKraken** (o GitLense en VSCode, Fork, Sourcetree) te muestran un mapa visual del repositorio, hacen que resolver conflictos sea muy sencillo e intuitivo. ¡Muy recomendadas para el trabajo diario!
