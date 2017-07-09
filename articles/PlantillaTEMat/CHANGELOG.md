## [v1.2.1] 2017-04-06
### Añadido
- Opción english (otra vez) para el paquete babel y así evitar los avisos
  en la plantilla por defecto. En un futuro se añadirá una opción en la clase
  para cargar idiomas extra.

### Corregido
- Cambiado \pmb en pdfLaTeX por el paquete bm con las opciones adecuadas.
- Plantilla actualizada para que no use directamente los comandos
  basados en el paquete standalone. Esto era una opción que presentaba
  problemas a los usuarios menos avanzados.


## [v1.2.0] 2017-03-05
### Añadido
- Añadido soporte para el paquete bm con LuaLaTeX y XeLaTeX. Definido
  el comando \bm a \pmb para pdfLaTeX.
- Personalizado el entorno enumerate.

### Corregido
- Corregido el comando \emph dentro de los teoremas y demás entornos
  matemáticos con cursiva en el cuerpo.
- Al usar LuaLaTeX y XeLaTeX, nos aseguramos de que no se parten
  palabras de la fuente monoespaciada.
- Pequeño cambio en siunitx.
- Correcciones de comandos internos.


## [v1.1.3] 2017-01-24
### Corregido
- Adaptado el parche rápido de las i sin punto para que se use solamente
  si la versión de la fuente lo necesita, tras la corrección de Michael
  Sharpe en el paquete erewhon. Afecta también a inconsolata, así que es
  lo que usamos para comprobar la versión ya que en el caso de erewhon
  no se ha actualizado el archivo sty.
- Los operadores con acentos fallaban con pdfLaTeX. La corrección
  incluye desactivar las tildes en ciertas versiones de babel-spanish
  antiguas.
- Cambiado el ajuste de los acentos matemáticos para usar comandos de
  LaTeX3 (necesita los paquetes l3regex y xparse). El código es más
  limpio que el que había antes.


## [v1.1.2] 2016-12-28
### Corregido
- Parche rápido para que las i sin punto acentuadas usen el glifo 
  correcto en texto escrito en versalitas al usar pdflatex. A la espera 
  de corrección definitiva en el paquete Erewhon.
- Los acentos matemáticos ya funcionan bien con LuaLaTeX.
- Ajustadas las posiciones de los acentos matemáticos (necesarios los 
  paquetes stackengine y scalerel) en pdfLaTeX y LuaLaTeX. Ajustes 
  especiales para versiones "viejas" (como TeX Live 2015).


## [v1.1.1] 2016-12-26
### Añadido
- Carga automática de la librería babel para tikz cuando se carga el 
  paquete tikz.

### Corregido
- Los títulos de las tesis no estaban en cursiva, como correspondería 
  según las recomendaciones habituales en lengua castellana.

### Eliminado
- Se ha desactivado la transformación de los paréntesis y corchetes a 
  redonda en los fragmentos en cursiva. Daba problemas al usar comandos 
  con parámetros opcionales.


## [v1.1.0] 2016-12-14
### Añadido
- Números de ecuaciones a la izquierda con formato sans serif(necesita 
  el paquete mathtools). Es para evitar la colisión con el cuadrado de 
  final de demostración.

### Corregido
- Corregido fallo de biblatex al usar i sin punto combinada con acentos.


## [v1.0.1] 2016-12-05
### Corregido
- Corregidas tildes en operadores matemáticos.


## [v1.0] - 2016-12-04
### Añadido
- Documentación de algorithmicx.
- Traducción para algpseudocode (necesita el paquete afterpackage).
- Etiquetas personalizadas para las figuras.

### Corregido
- Comillas, acento grave y l en las URL para LuaLaTeX.


## [v0.9-beta] - 2016-12-01
- Primera versión pública.
- Formato para la primera página de los artículos.
- Estilo de los teoremas y demás entornos matemáticos.
- Soporte para standalone.
- Ejemplos de (casi) todo.
