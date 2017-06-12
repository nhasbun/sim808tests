%% ringWatcher: funcion que cada cierto tiempo
% revisa la entrada serial en busca de una alerta de RING desde el
% modulo SIM808

function ringWatcher(stream, hObject)

while(1)
  pause(0.5); % pausa de un segundo para revisar llamados
  botonPresionado = get(hObject,'Value');
  if(botonPresionado == 0) break; end

  if(stream.BytesAvailable > 0)
    entrada = leerStream(stream, 2); % Linea en blanco y luego RING
    disp(entrada);
    llamadaEntrante = strcmp('RING', entrada);
    if(llamadaEntrante)
      fprintf(stream, 'ATA\n');
      fgetl(stream)
      fgetl(stream)
      break;
    end
  end
end


