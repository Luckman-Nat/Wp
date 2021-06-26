function varargout = No1(varargin)
% NO1 MATLAB code for No1.fig
%      NO1, by itself, creates a new NO1 or raises the existing
%      singleton*.
%
%      H = NO1 returns the handle to a new NO1 or the handle to
%      the existing singleton*.
%
%      NO1('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in NO1.M with the given input arguments.
%
%      NO1('Property','Value',...) creates a new NO1 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before No1_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to No1_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help No1

% Last Modified by GUIDE v2.5 25-Jun-2021 19:25:10

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @No1_OpeningFcn, ...
                   'gui_OutputFcn',  @No1_OutputFcn, ...
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


% --- Executes just before No1 is made visible.
function No1_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to No1 (see VARARGIN)

% Choose default command line output for No1
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes No1 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = No1_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function range_Callback(hObject, eventdata, handles)
% hObject    handle to range (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of range as text
%        str2double(get(hObject,'String')) returns contents of range as a double


% --- Executes during object creation, after setting all properties.
function range_CreateFcn(hObject, eventdata, handles)
% hObject    handle to range (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in cari.
function cari_Callback(hObject, eventdata, handles)
% hObject    handle to cari (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA
range=get(handles.range,'String');
range=str2double(range);
filename = 'Real estate valuation data set.xlsx';
opts = detectImportOptions(filename);
opts.SelectedVariableNames = [3:5 8];%memberikan range kolom
kumpul=readmatrix(filename,opts);%membaca file secara matrix
jos=kumpul(1:range,:);%membuat batasan baris
k=[0,0,1,0];%ranking
w=[3,5,4,1];%bobot
%tahapan pertama, perbaikan bobot
[m n]=size (jos); %inisialisasi ukuran jos
w=w./sum(w); %membagi bobot per kriteria dengan jumlah total seluruh bobot

for j=1:n
    if k(j)==0, w(j)=-1*w(j);%proses mengalikan cost dengan -1
    end
end
for i=1:m
    S(i)=prod(jos(i,:).^w);%proses menghitung vektor (S) perbaris alternatif 
end

%tahapan ketiga, proses perangkingan
V = S/sum(S);

[dat no]=sort(V,'descend');%pengurutan data dari yg terbesar
hasil1= [no(1:5) ;dat(1:5);];%menata matrix untuk dimasukkan ke tabel
hasil1=transpose(hasil1);
set(handles.tabel1,'Data',hasil1);%memasukkan ke tabel
% --- Executes on button press in tampil.
function tampil_Callback(hObject, eventdata, handles)
% hObject    handle to tampil (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
range=get(handles.range,'String');%mengambil data dari textedit range
if range==""
    msgbox("Kolom Range masih kosong","Peringatan");%jika kosong akan keluar dialog
else
    range=str2double(range);
    filename = 'Real estate valuation data set.xlsx';
    opts = detectImportOptions(filename);
    opts.SelectedVariableNames = [3:5 8];%proses filter kolom yg dibutuhkan
    data=readmatrix(filename,opts);
    data=data(1:range,:);%membatasi jumlah baris yang ingin di gunakan
    set(handles.tabel,'Data',data);
end
