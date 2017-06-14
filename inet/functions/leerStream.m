%% Funcion leerStream
% Se encarga de recibir los datos y leer la linea N
% además limpia el buffer de entrada

% el buffer de entrada funciona con un queue list para los datos de entrada

function out = leerStream(stream, n)
  for i=1:n
    out = fscanf(stream);
  end
  out = out(1:end-2); % eliminamos el \n entrante
  
  if(stream.BytesAvailable > 0)
    fread(stream, stream.BytesAvailable); % Truco para limpiar el input buffer
  end
end
