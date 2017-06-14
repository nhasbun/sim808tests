%% enviar: funcion que envia comando a stream serial

function enviar(mensaje)
  global stream
  fprintf(stream, [mensaje,'\n']); % Enviamos comando AT, para revisar si el modulo
  disp(mensaje);
  leer();
