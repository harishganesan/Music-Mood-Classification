
function [result] = multisvm(train_data,train_label,test_data)
u=unique(train_label);
numClasses=length(u);
result = zeros(length(test_data(:,1)),1);

%build models
for k=1:numClasses

    %Vectorized statement that binarizes Group
    %where 1 is the current class and 0 is all other classes

    G1vAll=(train_label==u(k));
    models(k) = svmtrain(train_data,G1vAll);
end

%classify test cases
for j=1:size(test_data,1)
    for k=1:numClasses
        if(svmclassify(models(k),test_data(j,:))) 
            break;
        end
    end
    result(j) = k;
end