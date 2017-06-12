%%%
% Descripcion,
% Prueba de llamada para modulo SIM808 usando 
% Matlab + parlantes y microfono
%
% El stream de datos de entrada por puerto serial funciona con una lista de 
% queue.
% -----------------------------------------------------------------------------
% Author : Nicolas Hasbun, nhasbun@gmail.com
% File   : main.m
% Create : 2017-06-10 19:39:11
% Editor : sublime text3, tab size (2)
% -----------------------------------------------------------------------------
%%%

addpath('./functions');

%% Limpiamos variables existentes
clear; close all; clc; tic;

%% Limpiamos puertos seriales que hayan quedado abiertos
puertosSeriales = instrfind;
nPuertos = length(puertosSeriales);
for i=1:nPuertos
  fclose(puertosSeriales(i));
  delete(puertosSeriales(i));
end

%% Declaracion de puerto serial, baudrate y se abre un stream
stream = serial('COM4');
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

if(funcionando == false)
  cerrarStream(stream);
  error('El modulo no funciona correctamente... OK NO RECIBIDO');
else 
  disp('Modulo funcionando...');
end

%% Se cierra el stream de datos
cerrarStream(stream);
toc;