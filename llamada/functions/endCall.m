%% endCall: Termina una llamada el canal de stream

function res = endCall(stream)
  comando = 'ATH\n';
  disp(comando);
  % Comando que realiza la llamada
  fprintf(stream, comando);
  out = leerStream(stream, 2);
  disp(out);
end