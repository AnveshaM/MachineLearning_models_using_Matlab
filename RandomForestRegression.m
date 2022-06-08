%% 
clc;
clear all;
close all;
warning off;
%% 
%Loading the data into a table
garment =readtable("garmentproductivityfinal.csv");
summary(garment);
%Converting the datatype for team variable
garment.team = char(garment.team);

%% 
%Separating only the numeric features in a table
garment_num=garment(:,[6:15]);
%Plotting the correlation matrix
fig =corrplot(garment_num);
h=heatmap(fig);
h.Colormap=winter;

%%
%Partitioning the dataset
X=garment(:,[2:15]); %Selecting all features except date
cvp = cvpartition(size(X,1),'Holdout',0.3);
idxTrn = training(cvp);
idxTest = test(cvp);
dataTrain2=X(idxTrn,:);
dataTest2=X(idxTest,:)

%%
%Setting the Maximum value of Minium Leaf Size 
tic
maxMinLS = 20;
%Optimising leaf size
minLS = optimizableVariable('minLS',[1,maxMinLS],'Type','integer');
%Optimising number of predictors
numPTS = optimizableVariable('numPTS',[1,size(X,2)-1],'Type','integer');
%Creating a 2x1 array of optimizable variable objects
hyperparametersRF = [minLS; numPTS];

%Hyperparameter Optimisation using Bayesopt 
results = bayesopt(@(params)oobErrRF(params,dataTrain2),hyperparametersRF,...
    'AcquisitionFunctionName','expected-improvement-plus','Verbose',0);
bestOOBErr = results.MinObjective
bestHyperparameters = results.XAtMinObjective
toc
%%
%Creating a model using Training Data  
tic
Mdl = TreeBagger(300,dataTrain2,'actual_productivity','Method','regression',...
    'MinLeafSize',bestHyperparameters.minLS,'Surrogate','on','NumPredictorstoSample',bestHyperparameters.numPTS,'PredictorSelection', ...
    'interaction-curvature','OOBPredictorImportance','on');
toc 
%%
%Performing the predictor interaction curvature test
imp = Mdl.OOBPermutedPredictorDeltaError;

figure;
bar(imp);
title('Interaction Curvature Test');
ylabel('Predictor importance estimates');
xlabel('Predictors');
h = gca;
h.XTickLabel = Mdl.PredictorNames;
h.XTickLabelRotation = 45;
h.TickLabelInterpreter = 'none';

%%
%Calculating R-squared and RMSE(Training)
yHat = oobPredict(Mdl);
R2 = corr(Mdl.Y,yHat)^2


errs2 = Mdl.Y-yHat;
sq_errs2=(errs2.^2);
mse2=mean(sq_errs2);
rmse_training=sqrt(mse2);
disp(rmse_training);


%%
%Estimating the number of learners
testset=dataTest2(:,1:13);
response=dataTest2(:,14);
err = quantileError(Mdl,testset,response,'Quantile',[0.25 0.5 0.75],'Mode','cumulative');
figure;
plot(err);
legend('0.25 quantile error','0.5 quantile error','0.75 quantile error');
ylabel('Quantile error');
xlabel('Tree index');
title('Cumulative Quantile Regression Error')
view(Mdl.Trees{1},"Mode","graph")

%%
%Calculating RMSE(Validation)
yHat2 = predict(Mdl,testset);
P=table2array(response);
errs3 = P-yHat2;
sq_errs3=(errs3.^2);
mse3=mean(sq_errs3);
rmse_validation=sqrt(mse3);
disp(rmse_validation);

%%
%Optimising Function on Training data to tune the hyperparameters
function oobErr = oobErrRF(params,dataTrain2)
%oobErrRF Trains random forest and estimates out-of-bag quantile error
%   oobErr trains a random forest of 300 regression trees using the
%   predictor data in X and the parameter specification in params, and then
%   returns the out-of-bag quantile error based on the median. X is a table
%   and params is an array of OptimizableVariable objects corresponding to
%   the minimum leaf size and number of predictors to sample at each node.
randomForest = TreeBagger(300,dataTrain2,'actual_productivity','Method','regression',...
    'OOBPrediction','on','MinLeafSize',params.minLS,...
    'NumPredictorstoSample',params.numPTS);
oobErr = oobQuantileError(randomForest);
end
