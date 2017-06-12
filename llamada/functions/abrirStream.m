function stream = abrirStream(puerto, estadoText);

%% Limpiamos puertos seriales que hayan quedado abiertos
puertosSeriales = instrfind;
nPuertos = length(puertosSeriales);
for i=1:nPuertos
  fclose(puertosSeriales(i));
  delete(puertosSeriales(i));
end

%% Declaracion de puerto serial, baudrate y se abre un stream
stream = serial(puerto);
set(stream, 'BaudRate', 9600);
set(stream, 'Timeout', 0.1); % Tiempo de espera en el buffer de entrada
fopen(stream);

%% Prueba de Comando inicial
funcionando = false; % estado inicial sin funcionamiento del modulo
fprintf(stream, 'AT\n'); % Enviamos comando AT, para revisar si el modulo
% esta funcional
out = leerStream(stream, 2); % Leer segunda linea del stream
if(strcmp('OK', out))
  disp('OK recibido');
  funcionando = true;
end

if(funcionando)
  set(estadoText, 'String', 'Conectado');
else
  set(estadoText, 'String', 'Error');
end