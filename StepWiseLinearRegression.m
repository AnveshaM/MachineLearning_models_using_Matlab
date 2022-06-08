%%
% Dividing the data into train and test data
cv1 = cvpartition(size(X,1),'HoldOut',0.3);
idx1 = cv1.test;
dataTrain1=X(~idx1,:);
dataTest1=X(idx1,:);
testing1=dataTest1(1:end,1:end-1);


%%
% Multiple Linear Regression on all features except date 
tic
mdl_lm = stepwiselm(dataTrain1,"interactions")
toc

% Predicting responses
prediction1=predict(mdl_lm,testing1);
errs1 = prediction1 - dataTest1.actual_productivity;
sq_errs1=(errs1.^2);
mse1=mean(sq_errs1);
rmse1=sqrt(mse1);
disp(rmse1);

%%
% Few data visualisations to understand the interaction effect in the data
figure
plotEffects(mdl_lm)
plotInteraction(mdl_lm,'over_time','no_of_workers')
plotInteraction(mdl_lm,'over_time','no_of_workers','predictions')
plotResiduals(mdl_lm)

%%
%Finding the outliers as shown in the residual plot
plotDiagnostics(mdl_lm,'cookd')
out=find((mdl_lm.Diagnostics.CooksDistance)>21*mean(mdl_lm.Diagnostics.CooksDistance))
