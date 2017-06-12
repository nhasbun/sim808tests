%% portList: Lista de puertos seriales en el equipo
function res = portList()
  hwinfo = instrhwinfo('serial');
  res = hwinfo.AvailableSerialPorts;
end
