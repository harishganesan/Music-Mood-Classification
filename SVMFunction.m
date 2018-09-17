total = 0;
count=zeros(100,1);
temp = zeros(4,1);
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

     
    class_acc = zeros(4,1);
    for x = 1:4
        for y=1:4
            if x == y
                class_acc(x) = confMat(x,y) / sum(confMat(x,:),2);
            end
       end
    end
    temp = temp + class_acc;
    disp('Class wise accuracy');
    disp(class_acc * 100);

    total_acc = mean(class_acc) ;
    disp('the total accuracy for this iteration is:');
    disp(total_acc *100);

    count(i) = total_acc*100;    
end

disp('The mean accuracy upon 100 iterations is:');
disp(mean(count));
    
    



    
    
