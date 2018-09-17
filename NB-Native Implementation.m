clear
tic
accuracies = zeros(100,1);
temp = zeros(4,4);

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
                Posterior(j,:) = priors .* prod(ccp,2)';                        %Use of bayes theorem and iid assumption
            end 

     % get predicted output for test set
        [pv0,id] = max(Posterior,[],2);
        for i = 1:length(id)
            pv(i,1) = yu(id(i));
        end

        % compare predicted output with actual output from test data
        confMat=myconfusionmat(test_label,pv);
        disp('confusion matrix:')
        disp(confMat)

        conf=sum(pv == test_label)/length(pv);
        temp = temp + confMat;
        disp(['accuracy = ',num2str(conf*100),'%'])
        accuracies(l) = conf*100;

    end

    toc