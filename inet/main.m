%%%
% Descripcion,
% Prueba de conexion TCPIP para el modulo SIM808
%
% El stream de datos de entrada por puerto serial funciona con una lista de
% queue.
% -----------------------------------------------------------------------------
% Author : Nicolas Hasbun, nhasbun@gmail.com
% File   : main.m
% Create : 2017-06-13 16:23:11
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
global stream
stream = serial('COM7');
set(stream, 'BaudRate', 9600);
set(stream, 'Timeout', 2); % Tiempo de espera en el buffer de entrada
set(stream, 'InputBufferSize', 512*10); % Default is 512
fopen(stream);

%% Lista de Comandos
enviar AT; % OK
enviar AT+CPIN?;     % +CPIN: READY % Indica Sim desbloqueada lista
enviar AT+CSTT?;     % +CSTT: "CMNET", "", "" % Indica datos del APN actual
enviar('AT+CSTT="bam.entelpcs.cl","entelpcs","entelpcs"');
% Setea el APN, address, username y password
enviar AT+CIICR; % Bring up Wireless Connection for GPRS or CSD
enviar AT+CIFSR; % Get IP Address

command = 'AT+CIPSTART="TCP","nhasbun.duckdns.org","80"';
% Abrir conexion TCP, servidor y puerto

fprintf(stream, [command,'\n']);
out = fgetl(stream); disp(out);
out = fgetl(stream); disp(out);
out = fgetl(stream); disp(out);
out = fgetl(stream); disp(out);

command = 'AT+CIPSEND';
fprintf(stream, [command,'\n']);
disp(fgetl(stream));

%% Entrada serial sin terminacion
entrada = fread(stream,2);
disp([char(1), char(2)]);

fprintf(stream, 'GET\n'); % se pide la pagina principal index.html
fprintf(stream, char(26)); % Se termina el pediod con caracter 0x1A

disp('Pidiendo Pagina HTTP... esperar...');
pause(15);
% Hay que dejar un tiempo grande para que se cargue la pag completa


%% Pagina recibida
while(stream.BytesAvailable > 0)
  out = fgetl(stream);
  disp(out);
  % pause(0.1);
end


cerrarStream(stream);