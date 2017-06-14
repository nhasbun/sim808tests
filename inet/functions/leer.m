%% leer: funcion que lee entrada de stream serial
function leer()
  global stream
  out = leerStream(stream, 2); % Leer segunda linea del stream
  disp(out);
