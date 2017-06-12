function varargout = gui(varargin)
% GUI MATLAB code for gui.fig
%      GUI, by itself, creates a new GUI or raises the existing
%      singleton*.
%
%      H = GUI returns the handle to a new GUI or the handle to
%      the existing singleton*.
%
%      GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI.M with the given input arguments.
%
%      GUI('Property','Value',...) creates a new GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui

% Last Modified by GUIDE v2.5 12-Jun-2017 18:29:15

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before gui is made visible.
function gui_OpeningFcn(hObject, eventdata, handles, varargin)
  % This function has no output args, see OutputFcn.
  % hObject    handle to figure
  % eventdata  reserved - to be defined in a future version of MATLAB
  % handles    structure with handles and user data (see GUIDATA)
  % varargin   command line arguments to gui (see VARARGIN)

  % Choose default command line output for gui
  handles.output = hObject;

  % Update handles structure
  guidata(hObject, handles);

  % UIWAIT makes gui wait for user response (see UIRESUME)
  % uiwait(handles.mainWindow);
  addpath('./functions');

  %% Limpiamos puertos seriales que hayan quedado abiertos
  puertosSeriales = instrfind;
  nPuertos = length(puertosSeriales);
  for i=1:nPuertos
    fclose(puertosSeriales(i));
    delete(puertosSeriales(i));
  end

% --- Outputs from this function are returned to the command line.
function varargout = gui_OutputFcn(hObject, eventdata, handles)
  % varargout  cell array for returning output args (see VARARGOUT);
  % hObject    handle to figure
  % eventdata  reserved - to be defined in a future version of MATLAB
  % handles    structure with handles and user data (see GUIDATA)

  % Get default command line output from handles structure
  varargout{1} = handles.output;


% --- Executes on selection change in listaPuertos.
function listaPuertos_Callback(hObject, eventdata, handles)
  % hObject    handle to listaPuertos (see GCBO)
  % eventdata  reserved - to be defined in a future version of MATLAB
  % handles    structure with handles and user data (see GUIDATA)

  % Hints: contents = cellstr(get(hObject,'String')) returns listaPuertos contents as cell array
  %        contents{get(hObject,'Value')} returns selected item from listaPuertos
  contents = cellstr(get(hObject,'String'));
  puertonum = get(hObject,'Value');
  global puerto
  puerto = contents{puertonum};
  disp(puerto);

% --- Executes during object creation, after setting all properties.
function listaPuertos_CreateFcn(hObject, eventdata, handles)
  % hObject    handle to listaPuertos (see GCBO)
  % eventdata  reserved - to be defined in a future version of MATLAB
  % handles    empty - handles not created until after all CreateFcns called

  % Hint: listbox controls usually have a white background on Windows.
  %       See ISPC and COMPUTER.
  if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
      set(hObject,'BackgroundColor','white');
  end

  puertos = portList();
  set(hObject, 'String', puertos);

% --- Executes on button press in conectarBtn.
function conectarBtn_Callback(hObject, eventdata, handles)
  % hObject    handle to conectarBtn (see GCBO)
  % eventdata  reserved - to be defined in a future version of MATLAB
  % handles    structure with handles and user data (see GUIDATA)
  estadoText = findobj('Tag', 'estadoText'); % encontrar objeto
  global stream puerto
  stream = abrirStream(puerto, estadoText);

  % --- Executes during object creation, after setting all properties.
  function mainWindow_CreateFcn(hObject, eventdata, handles)
  % hObject    handle to mainWindow (see GCBO)
  % eventdata  reserved - to be defined in a future version of MATLAB
  % handles    empty - handles not created until after all CreateFcns called
  addpath('./functions');

  %% Limpiamos puertos seriales que hayan quedado abiertos
  puertosSeriales = instrfind;
  nPuertos = length(puertosSeriales);
  for i=1:nPuertos
    fclose(puertosSeriales(i));
    delete(puertosSeriales(i));
  end

% --- Executes when user attempts to close mainWindow.
function mainWindow_CloseRequestFcn(hObject, eventdata, handles)
  % hObject    handle to mainWindow (see GCBO)
  % eventdata  reserved - to be defined in a future version of MATLAB
  % handles    structure with handles and user data (see GUIDATA)

  % Hint: delete(hObject) closes the figure
  delete(hObject);

  % Cerramos el Stream
  global stream
  if(length(stream) > 0)
    cerrarStream(stream);
  end



function phoneNumber_Callback(hObject, eventdata, handles)
  % hObject    handle to phoneNumber (see GCBO)
  % eventdata  reserved - to be defined in a future version of MATLAB
  % handles    structure with handles and user data (see GUIDATA)

  % Hints: get(hObject,'String') returns contents of phoneNumber as text
  %        str2double(get(hObject,'String')) returns contents of phoneNumber as a double
  global numero
  numero = get(hObject, 'String');

% --- Executes during object creation, after setting all properties.
function phoneNumber_CreateFcn(hObject, eventdata, handles)
  % hObject    handle to phoneNumber (see GCBO)
  % eventdata  reserved - to be defined in a future version of MATLAB
  % handles    empty - handles not created until after all CreateFcns called

  % Hint: edit controls usually have a white background on Windows.
  %       See ISPC and COMPUTER.
  if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
      set(hObject,'BackgroundColor','white');
  end


% --- Executes on button press in callBtn.
function callBtn_Callback(hObject, eventdata, handles)
  % hObject    handle to callBtn (see GCBO)
  % eventdata  reserved - to be defined in a future version of MATLAB
  % handles    structure with handles and user data (see GUIDATA)
  global numero stream
  disp(['Llamar... ', numero]);
  makeCall(stream, numero);

% --- Executes on button press in endCallBtn.
function endCallBtn_Callback(hObject, eventdata, handles)
  % hObject    handle to endCallBtn (see GCBO)
  % eventdata  reserved - to be defined in a future version of MATLAB
  % handles    structure with handles and user data (see GUIDATA)
  global stream
  disp('Colgar... ');
  endCall(stream);


% --- Executes on button press in poweroff.
function poweroff_Callback(hObject, eventdata, handles)
  % hObject    handle to poweroff (see GCBO)
  % eventdata  reserved - to be defined in a future version of MATLAB
  % handles    structure with handles and user data (see GUIDATA)
  global stream
  disp('Apagando Modulo...');
  disp('AT+CPOWD=1');
  fprintf(stream, 'AT+CPOWD=1\n'); % poweroff
  cerrarStream(stream);


% --- Executes on button press in autoAnswer.
function autoAnswer_Callback(hObject, eventdata, handles)
  % hObject    handle to autoAnswer (see GCBO)
  % eventdata  reserved - to be defined in a future version of MATLAB
  % handles    structure with handles and user data (see GUIDATA)

  % Hint: get(hObject,'Value') returns toggle state of autoAnswer
  global stream
  botonPresionado = get(hObject, 'Value');
  if(botonPresionado)
    ringWatcher(stream, hObject);
  end
