function varargout = GUI2(varargin)
% GUI1 MATLAB code for GUI1.fig
%      GUI1, by itself, creates a new GUI1 or raises the existing
%      singleton*.
%
%      H = GUI1 returns the handle to a new GUI1 or the handle to
%      the existing singleton*.
%
%      GUI1('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI1.M with the given input arguments.
%
%      GUI1('Property','Value',...) creates a new GUI1 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI1_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI1_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI1

% Last Modified by GUIDE v2.5 11-Mar-2016 05:48:24

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI1_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI1_OutputFcn, ...
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


% --- Executes just before GUI1 is made visible.
function GUI1_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI1 (see VARARGIN)

% Choose default command line output for GUI1
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUI1 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUI1_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

set(handles.pushbutton21,'visible','off');
set(handles.play,'visible','off');
set(handles.pause,'visible','off');
set(handles.browse,'visible','off');
set(handles.edit3,'visible','off');
set(handles.training,'visible','off');
set(handles.accu,'visible','off');
set(handles.cm,'visible','off');
set(handles.iter,'visible','off');
set(handles.extrct,'visible','off');
set(handles.ontrn,'visible','off');
set(handles.edit6,'visible','off');
set(handles.uitable3,'visible','off');
guidata(hObject,handles);
clc


        

function Offline_Callback(hObject, eventdata, handles)
% hObject    handle to Offline (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Offline
set(handles.Offline,'value',1);
set(handles.radiobutton2,'value',0);
set(handles.browse,'visible','off');
set(handles.edit3,'visible','off');
set(handles.extrct,'visible','off');
set(handles.ontrn,'visible','off');
set(handles.edit6,'visible','off');
set(handles.play,'visible','off');
set(handles.pause,'visible','off');
set(handles.uitable3,'visible','off');
NewDataset = dataset('xlsfile', 'NewDataset.xlsx');
  
    data = double(NewDataset(:,3:12));
    label = double(NewDataset(:,2));
    c = cvpartition(label,'holdout',.2);
    
    train_data = data(training(c,1),:);
    train_label =label(training(c,1));

    test_data = data(test(c,1),:);
    test_label =label(test(c,1),:);

    assignin('base','train_data',train_data);
assignin('base','train_label',train_label);
handles.train_data=train_data;
handles.train_label=train_label;

assignin('base','NewDataset',NewDataset);
    assignin('base','data',data);
    assignin('base','label',label);
    assignin('base','c',c);
    handles.label=label;
    handles.c=c;
    handles.data=data;
assignin('base','test_data',test_data);
assignin('base','test_label',test_label);
handles.test_data=test_data;
handles.test_label=test_label;
set(handles.screen,'visible','on');
set(handles.screen,'string','Offline Mode selected');
pause(3);
set(handles.training,'visible','on');
set(handles.iter,'visible','on');

guidata(hObject,handles)

%assignin('base','p',p);

   


% --- Executes on button press in radiobutton2.
function radiobutton2_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton2
set(handles.Offline,'value',0);
set(handles.radiobutton2,'value',1);
set(handles.training,'visible','off');
set(handles.accu,'visible','off');
set(handles.cm,'visible','off');
set(handles.iter,'visible','off');
set(handles.uitable3,'visible','off');
set(handles.screen,'visible','on');
set(handles.screen,'string','Online Mode selected');
pause(1);
set(handles.browse,'visible','on');
pause(4);
set(handles.edit3,'visible','on');
set(handles.extrct,'visible','on');
pause(1);
set(handles.play,'visible','on');
set(handles.pause,'visible','on');
set(handles.ontrn,'visible','on');
guidata(hObject,handles);



% --- Executes on selection change in classifier.
function classifier_Callback(hObject, eventdata, handles)
% hObject    handle to classifier (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns classifier contents as cell array
%        contents{get(hObject,'Value')} returns selected item from classifier

items = get(hObject,'String');
inds = get(hObject,'Value');
item_selected = items{inds};
d=(['You Selected the Classifier :',item_selected]);
set(handles.screen,'string',d);
handles.ins=inds;
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function classifier_CreateFcn(hObject, eventdata, handles)
% hObject    handle to classifier (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

set(hObject,'String',{'SVM';'Linear Discreminant Analysis';'Decision Tree';'Naive Bayes'});


% --- Executes on button press in cm.
function cm_Callback(hObject, eventdata, handles)
% hObject    handle to cm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
h = handles.ins;

switch h
    case 1
         disp('confusion matrix:');
    disp(handles.confmat1);
    set(handles.uitable3,'visible','on');
    set(handles.uitable3,'Data',handles.confmat1);
guidata(hObject,handles);
        
    case 2
    
        disp('confusion matrix:');
    disp(handles.confmat2);
    set(handles.uitable3,'visible','on');
    set(handles.uitable3,'Data',handles.confmat2);
guidata(hObject,handles);
        
    case 3
        
        disp('confusion matrix:');
    disp(handles.confmat3);
    set(handles.uitable3,'visible','on');
    set(handles.uitable3,'Data',handles.confmat3);
guidata(hObject,handles);
    case 4
        
        disp('confusion matrix:');
    disp(handles.confmat4);
    set(handles.uitable3,'visible','on');
    set(handles.uitable3,'Data',handles.confmat4);
guidata(hObject,handles);
end


% --- Executes on button press in browse.
function browse_Callback(hObject, eventdata, handles)
% hObject    handle to browse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global baseFileName folder;
[baseFileName, folder] = uigetfile({'*.wav';'*.mp3'},'Select Audio File');
%[fname,fpath,filter]=uigetfile({'*.wav';'*.mp3'},'Select The Music File');
ExPath=fullfile(folder, baseFileName);
set(handles.edit3,'string',ExPath);
%chfile=[fpath fname]
%handles.fp='fpath';
%handles.fnm=fname;
%guidata(hObject,handles)


function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in extrct.
function extrct_Callback(hObject, eventdata, handles)
% hObject    handle to extrct (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global baseFileName folder;
fullFileName = fullfile(folder, baseFileName)

valar=csvread('static_annotations.csv',1,0);
assignin('base','valance_arousl',valar);

[pathstr,name,ext]=fileparts(fullFileName)
t=str2double(name);
row=find(valar==t);

a = miraudio(fullFileName,'Extract',0,60,'s','Start');
t = mirtempo(a);
e = mirrms(a);
p = mirpitch(a);
k = mirkey(a);
m = mirmode(a);
pc = mirpulseclarity(a);
ed = mireventdensity(a);
ih = mirinharmonicity(a);

mars=valar(row,2);
sars=valar(row,3);
mval=valar(row,4);
sval=valar(row,5);

mirexport('Features5.txt',t,e,p,k,m,pc,ed,ih);
AB = importdata('Features5.txt');
for i = 1:8
    AB.data(i+2) = AB.data(i);
end
AB.data(1) = mars;
AB.data(2) = mval;
AA = AB.data;
assignin('base','mars',mars);
assignin('base','sars',sars);
assignin('base','mval',mval);
assignin('base','sval',sval);
assignin('base','tempo',t);
assignin('base','pitch',p);
assignin('base','energy',e);
assignin('base','key',k);
assignin('base','mode',m);
assignin('base','pulseclarity',pc);
assignin('base','inharmonocity',ih);
assignin('base','eventdensity',ed);
assignin('base','AA',AA);
handles.AA=AA;
guidata(hObject,handles);




% --- Executes on button press in training.
function training_Callback(hObject, eventdata, handles)
% hObject    handle to training (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
h=handles.ins;
x=handles.train_data;
y=handles.train_label;
u=handles.test_data;
v=handles.test_label;
set(handles.cm,'visible','on');
set(handles.accu,'visible','on');

switch h
    case 1
    
        [cre] = multisvm(x,y,u);
        % compare predicted output with actual output from test data
         confMat=myconfusionmat(v,cre);
        
    class_acc = zeros(4,1);
    for x = 1:4
        for y=1:4
            if x == y
                class_acc(x) = confMat(x,y) / sum(confMat(x,:),2);
            end
       end
    end
    
    total_acc = mean(class_acc) ;
     handles.confmat1=confMat;
    handles.accu1=total_acc;
    guidata(hObject, handles);
    
    case 2
        
         model = ClassificationDiscriminant.fit(x,y);
    cre = predict(model,u);


    % compare predicted output with actual output from test data
    confMat=myconfusionmat(v,cre);
    

     
    class_acc = zeros(4,1);
    for p = 1:4
        for q=1:4
            if p == q
                class_acc(p) = confMat(p,q) / sum(confMat(p,:),2);
            end
       end
    end

    %disp('Class wise accuracy');
    %disp(class_acc * 100);

    total_acc = mean(class_acc) ;
    %disp('the total accuracy for this iteration is:');
    %disp(total_acc *100);
    
    handles.confmat2=confMat;
    handles.accu2=total_acc;
    guidata(hObject, handles);
      
    case 3
        
        
    model = ClassificationTree.fit(x,y);
    cre = predict(model,u);
      confMat=myconfusionmat(v,cre);
    %disp('confusion matrix:');
    %disp(confMat);

     
    class_acc = zeros(4,1);
    for x = 1:4
        for y=1:4
            if x == y
                class_acc(x) = confMat(x,y) / sum(confMat(x,:),2);
            end
       end
    end

    %disp('Class wise accuracy');
    %disp(class_acc * 100);

    total_acc = mean(class_acc) ;
    %disp('the total accuracy for this iteration is:');
    %disp(total_acc *100);

    handles.confmat3=confMat;
    handles.accu3=total_acc;
    guidata(hObject, handles);
    
    case 4
        
         yu = unique(y);     % finds out the unique labels in the training data
        n_classes = length(yu);       % number of classes
        n_features = size(x,2);      % number of features
        n_test = length(v);      % test set length



        % compute class prior probability
        for i = 1:n_classes
            priors(i) = sum(double(y== yu(i)))/length(y);
        end

         % parameters estimation from training set
            for i = 1:n_classes
                xi = x((y==yu(i)),:);
                mu(i,:) = mean(xi,1);
                sigma(i,:) = std(xi,1);
            end

        % probability for test set
            for j = 1:n_test
                ccp = normpdf(ones(n_classes,1)*u(j,:),mu,sigma);       % ccp = class conditional probabilities 
                Posterior(j,:) = priors .* prod(ccp,2)';
            end 

        % get predicted output for test set
            [pv0,id] = max(Posterior,[],2);
            for i = 1:length(id)
                pv(i,1) = yu(id(i));
            end

            conf=sum(pv == v)/length(pv);
            disp(['accuracy = ',num2str(conf*100),'%'])
            %accuracies(l) = conf*100;
            confMat=myconfusionmat(v,pv);
            handles.confmat4=confMat;
            handles.accu4=conf;
           guidata(hObject,handles);
        

   
end



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in accu.
function accu_Callback(hObject, eventdata, handles)
% hObject    handle to accu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
h=handles.ins
switch h
    case 1
        
        disp('the total accuracy is :');
        disp(handles.accu1*100);
        d=(['The Total Accuracy is : ',num2str(handles.accu1*100)]);
    set(handles.uitable3,'visible','off');
    set(handles.screen,'visible','on');
    set(handles.screen,'string',d);
    pause(1);
    case 2
        
        disp('the total accuracy is:');
    disp(handles.accu2 *100);
    d=(['The Total Accuracy is : ',num2str(handles.accu2*100)]);
    set(handles.uitable3,'visible','off');
    set(handles.screen,'visible','on');
    set(handles.screen,'string',d);
    pause(1);
        
    case 3
        
        disp('the total accuracy is:');
    disp(handles.accu3*100);
    d=(['The Total Accuracy is : ',num2str(handles.accu3*100)]);
    set(handles.uitable3,'visible','off');
    set(handles.screen,'visible','on');
    set(handles.screen,'string',d);
    pause(1);
        
    case 4
       
        disp('the total accuracy is:');
    disp(handles.accu4 *100);
    d=(['The Total Accuracy is : ',num2str(handles.accu4*100)]);
    set(handles.uitable3,'visible','off');
    set(handles.screen,'visible','on');
    set(handles.screen,'string',d);
    pause(1);
end


% --- Executes on button press in iter.
function iter_Callback(hObject, eventdata, handles)
% hObject    handle to iter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
h=handles.ins
conf=zeros(4,4);
switch h
    case 1
       ca=zeros(4,1);
        
       total = 0;
        count=zeros(100,1);
        for i=1:100
    
         song = dataset('xlsfile', 'NewDataset.xlsx');
         X = double(song(:,3:12));
         Y = double(song(:,2));

        % Create a cvpartition object that defined the folds
        c = cvpartition(Y,'holdout',.2);

         % Create a training set
        x = X(training(c,1),:);
        y = Y(training(c,1));

    % test set
        u=X(test(c,1),:);
        v=Y(test(c,1),:);

        [cre] = multisvm(x,y,u);


        % compare predicted output with actual output from test data
        confMat=myconfusionmat(v,cre);
        disp('confusion matrix:');
        disp(confMat);
        
        conf=plus(conf,confMat);

        set(handles.uitable3,'visible','on');
    set(handles.uitable3,'Data',confMat);
guidata(hObject,handles); 
pause(1);
     
        class_acc = zeros(4,1);
        %ca=zeros(4,1);
        for x = 1:4
        for y=1:4
            if x == y
                class_acc(x) = confMat(x,y) / sum(confMat(x,:),2);
                ca(x)=plus(ca(x),class_acc(x));
            end
       end
    end

    disp('Class wise accuracy');
    disp(class_acc * 100);

    total_acc = mean(class_acc) ;
    disp('the total accuracy for this iteration is:');
    disp(total_acc *100);

    
     d=(['For iteration ',num2str(i),' Total Accuracy= ',num2str(total_acc*100)]);
    set(handles.uitable3,'visible','off');
    set(handles.screen,'visible','on');
    set(handles.screen,'string',d);
    pause(1);
    
    count(i) = total_acc*100;    
end

    disp('The mean accuracy upon 100 iterations is:');
    disp(mean(count));
    disp(conf)
    disp(conf/100)
    disp(ca)
    d=(['The mean of Confusion Matrix upon 100 iterations is : ']);
    set(handles.screen,'visible','on');
    set(handles.screen,'string',d);
    pause(1); 
    set(handles.uitable3,'visible','on');
        set(handles.uitable3,'Data',conf);
        guidata(hObject,handles);
        pause(1);
    d=(['The mean accuracy upon 100 iterations is : ',num2str(mean(count))]);
    set(handles.screen,'visible','on');
    set(handles.screen,'string',d);
    pause(1);     
   
    
    case 2
   ca=zeros(4,1);
        
        total = 0;
        count=zeros(100,1);
        for i=1:100
    set(handles.screen,'visible','off');
    song = dataset('xlsfile', 'NewDataset.xlsx');
    X = double(song(:,3:12));
    Y = double(song(:,2));

    % Create a cvpartition object that defined the folds
    c = cvpartition(Y,'holdout',.2);

    % Create a training set
    x = X(training(c,1),:);
    y = Y(training(c,1));

    % test set
    u=X(test(c,1),:);
    v=Y(test(c,1),:);

    model = ClassificationDiscriminant.fit(x,y);
    cre = predict(model,u);


    % compare predicted output with actual output from test data
    confMat=myconfusionmat(v,cre);
    disp('confusion matrix:');
    disp(confMat);
    conf=plus(conf,confMat);

    set(handles.uitable3,'visible','on');
    set(handles.uitable3,'Data',confMat);
guidata(hObject,handles); 
pause(1);
    class_acc = zeros(4,1);
    %ca=zeros(4,1);
    for p = 1:4
        for q=1:4
            if p == q
                class_acc(p) = confMat(p,q) / sum(confMat(p,:),2);
                ca(p)=plus(ca(p),class_acc(p));
            end
       end
    end

    disp('Class wise accuracy');
    disp(class_acc * 100);
    

    total_acc = mean(class_acc) ;
    disp('the total accuracy for this iteration is:');
    disp(total_acc *100);
    d=(['For iteration ',num2str(i),' Total Accuracy= ',num2str(total_acc*100)]);
    set(handles.uitable3,'visible','off');
    set(handles.screen,'visible','on');
    set(handles.screen,'string',d);
    pause(1);
    count(i) = total_acc*100;
    
end



    disp('The mean accuracy upon 100 iterations is:');
    disp(mean(count));
    disp(conf)
    disp(conf/100)
    disp(ca)
    d=(['The mean of Confusion Matrix upon 100 iterations is : ']);
    set(handles.screen,'visible','on');
    set(handles.screen,'string',d);
    pause(1); 
    set(handles.uitable3,'visible','on');
        set(handles.uitable3,'Data',conf);
        guidata(hObject,handles);
        pause(1);
    d=(['The mean accuracy upon 100 iterations is : ',num2str(mean(count))]);
    set(handles.screen,'visible','on');
    set(handles.screen,'string',d);
    pause(1);       
        
        
    case 3
        ca=zeros(4,1);
        
        total = 0;
count=zeros(100,1);
for i=1:100
    
    song = dataset('xlsfile', 'NewDataset.xlsx');
    X = double(song(:,3:12));
    Y = double(song(:,2));

    % Create a cvpartition object that defined the folds
    c = cvpartition(Y,'holdout',.2);

    % Create a training set
    x = X(training(c,1),:);
    y = Y(training(c,1));

    % test set
    u=X(test(c,1),:);
    v=Y(test(c,1),:);

    model = ClassificationTree.fit(x,y);
    cre = predict(model,u);


    % compare predicted output with actual output from test data
    confMat=myconfusionmat(v,cre);
    disp('confusion matrix:');
    disp(confMat);
    conf=plus(conf,confMat);

     set(handles.uitable3,'visible','on');
    set(handles.uitable3,'Data',confMat);
    guidata(hObject,handles);
    pause(1);
    class_acc = zeros(4,1);
    for x = 1:4
        for y=1:4
            if x == y
                class_acc(x) = confMat(x,y) / sum(confMat(x,:),2);
                ca(x)=plus(ca(x),class_acc(x));
            end
       end
    end

    disp('Class wise accuracy');
    disp(class_acc * 100);

    total_acc = mean(class_acc) ;
    disp('the total accuracy for this iteration is:');
    disp(total_acc *100);

d=(['For iteration ',num2str(i),' Total Accuracy= ',num2str(total_acc*100)]);
    set(handles.uitable3,'visible','off');
    set(handles.screen,'visible','on');
    set(handles.screen,'string',d);
    pause(1);
    count(i) = total_acc*100;
    
end

disp('The mean accuracy upon 100 iterations is:');
disp(mean(count));

disp(conf)
    disp(conf/100)
    disp(ca);
    d=(['The mean of Confusion Matrix upon 100 iterations is : ']);
    set(handles.screen,'visible','on');
    set(handles.screen,'string',d);
    pause(1); 
set(handles.uitable3,'visible','on');
        set(handles.uitable3,'Data',conf);
        guidata(hObject,handles);
        pause(1);
        d=(['The mean accuracy upon 100 iterations is : ',num2str(mean(count))]);
    set(handles.screen,'visible','on');
    set(handles.screen,'string',d);
    pause(1);  
    
    
    case 4
       
 ca=zeros(4,1);
        
accuracies = zeros(100,1);

for l=1:100

    % read data
    NewDataset = dataset('xlsfile', 'NewDataset.xlsx');


    data = double(NewDataset(:,3:12));
    label = double(NewDataset(:,2));


    % Create a cross validation partition object that defined the folds
    c = cvpartition(label,'holdout',.2);

    % Create a training set
    train_data = data(training(c,1),:);
    train_label = label(training(c,1));


    % test set

    test_data = data(test(c,1),:);
    test_label = label(test(c,1),:);

    yu = unique(train_label);     % finds out the unique labels in the training data
    n_classes = length(yu);       % number of classes
    n_features = size(train_data,2);      % number of features
    n_test = length(test_label);      % test set length



    % compute class prior probability
    for i = 1:n_classes
        priors(i) = sum(double(train_label== yu(i)))/length(train_label);
    end

% parameters estimation from training set
            for i = 1:n_classes
                xi = train_data((train_label==yu(i)),:);
                mu(i,:) = mean(xi,1);
                sigma(i,:) = std(xi,1);
            end

            % probability for test set
            for j = 1:n_test
                ccp = normpdf(ones(n_classes,1)*test_data(j,:),mu,sigma);       % ccp = class conditional probabilities 
                Posterior(j,:) = priors .* prod(ccp,2)';
            end 

     % get predicted output for test set
        [pv0,id] = max(Posterior,[],2);
        for i = 1:length(id)
            pv(i,1) = yu(id(i));
        end

        conf1=sum(pv == test_label)/length(pv);
        disp(['accuracy = ',num2str(conf1*100),'%'])
        accuracies(l) = conf1*100;
        confMat=myconfusionmat(test_label,pv);
        conf=plus(conf,confMat);
        
        class_acc = zeros(4,1);
        for x = 1:4
            for y=1:4
                if x == y
                    class_acc(x) = confMat(x,y) / sum(confMat(x,:),2);
                    
                end
           end
        end
        ca=ca+class_acc;
        disp('Class wise accuracy');
        disp(class_acc * 100);
        set(handles.uitable3,'visible','on');
        set(handles.uitable3,'Data',confMat);
        guidata(hObject,handles);
        pause(1);
        
         d=(['For iteration ',num2str(l),' Total Accuracy= ',num2str(conf1*100)]);
    set(handles.uitable3,'visible','off');
    set(handles.screen,'visible','on');
    set(handles.screen,'string',d);
    pause(1);

    end
disp(mean(accuracies));
d=(['The mean of Confusion Matrix upon 100 iterations is : ']);
    set(handles.screen,'visible','on');
    set(handles.screen,'string',d);
    pause(1); 
disp(conf)
    disp(conf/100)
    disp(ca)
    set(handles.uitable3,'visible','on');
        set(handles.uitable3,'Data',conf/100);
        guidata(hObject,handles);
        pause(1);
    
    d=(['The mean accuracy upon 100 iterations is : ',num2str(mean(accuracies))]);
    set(handles.uitable3,'visible','off');
    set(handles.screen,'visible','on');
    set(handles.screen,'string',d);
    pause(1); 
    
end

function screen_Callback(hObject, eventdata, handles)
% hObject    handle to screen (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of screen as text
%        str2double(get(hObject,'String')) returns contents of screen as a double


% --- Executes during object creation, after setting all properties.
function screen_CreateFcn(hObject, eventdata, handles)
% hObject    handle to screen (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in ontrn.
function ontrn_Callback(hObject, eventdata, handles)
% hObject    handle to ontrn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
h = handles.ins;
song = dataset('xlsfile','NewDataset.xlsx');
    X = double(song(:,3:12));
    Y = double(song(:,2));
    x=handles.AA;

switch h
    case 1
        [cre] = multisvm(X,Y,x);
        set(handles.edit6,'visible','on');
        d=(['Song is Classified as:',num2str(cre)]);
        set(handles.edit6,'string',d);
        guidata(hObject,handles);
    case 2
    
        model = ClassificationDiscriminant.fit(X,Y);
        cre = predict(model,x);
        set(handles.edit6,'visible','on');
        d=(['Song is Classified as:',num2str(cre)]);
        set(handles.edit6,'string',d);
        guidata(hObject,handles);
        
    case 3
        
        model = ClassificationTree.fit(X,Y);
        cre = predict(model,x);
        set(handles.edit6,'visible','on');
        d=(['Song is Classified as:',num2str(cre)]);
        set(handles.edit6,'string',d);
        guidata(hObject,handles);
        
    case 4
        
        model = NaiveBayes.fit(X,Y);
    cre = predict(model,x);
    set(handles.edit6,'visible','on');
    
        d=(['Song is Classified as:',num2str(cre)]);
        set(handles.edit6,'string',d);
        guidata(hObject,handles);

    
end



function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double


% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes when entered data in editable cell(s) in uitable3.
function uitable3_CellEditCallback(hObject, eventdata, handles)
% hObject    handle to uitable3 (see GCBO)
% eventdata  structure with the following fields (see UITABLE)
%	Indices: row and column indices of the cell(s) edited
%	PreviousData: previous data for the cell(s) edited
%	EditData: string(s) entered by the user
%	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
%	Error: error string when failed to convert EditData to appropriate value for Data
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in play.
function play_Callback(hObject, eventdata, handles)
% hObject    handle to play (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global baseFileName folder;
global player;
fullFileName = fullfile(folder, baseFileName)
[y,Fs]=audioread(fullFileName);
player=audioplayer(y,Fs);
playblocking(player)
%sound(y,Fs);


% --- Executes on button press in pause.
function pause_Callback(hObject, eventdata, handles)
% hObject    handle to pause (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global player;
pause(player);
set(handles.pause,'visible','off');
set(handles.pushbutton21,'visible','on');
guidata(hObject,handles);

% --- Executes on button press in pushbutton21.
function pushbutton21_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global player;
resume(player);
set(handles.pushbutton21,'visible','off');
set(handles.pause,'visible','on');
guidata(hObject,handles);
