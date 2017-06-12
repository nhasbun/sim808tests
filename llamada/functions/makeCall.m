%% makeCall: Realiza una llamada con numero, ocupando el canal de stream

function res = makeCall(stream, numero)
  comando = ['ATD', numero, ';\n'];
  disp(comando);
  % Comando que realiza la llamada
  fprintf(stream, comando); 
  out = leerStream(stream, 2);
  disp(out);
end

