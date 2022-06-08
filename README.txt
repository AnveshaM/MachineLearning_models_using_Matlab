Student ID: 210015639
Name: ANVESHA MISHRA

INM431 Machine Learning Coursework, City University of London

Notes for running the Code Scripts.


SOFTWARE VERSIONS USED:
1. MATLAB
Version: R2021b (9.11.0.1769968)
	 64-bit (maci64)
	 September 17, 2021

2. JUPYTER NOTEBOOK
Version: 6.4.3 - Python 3.8.8 (default, Apr 13 2021, 12:59:45) 
[Clang 10.0.0 ]
Anaconda 4 (conda 4.10.3) 

3.PYTHON LIBRARIES
Sklearn,scipy,matplotlib,seaborn,numpy,math and pandas

**NOTE : Since the code scripts have been prepared in the above software versions, it is recommended to run them on the same versions for a smooth experience.


Details of files in the zip folder:
 File Name/type	— Description
1.garments_worker_productivity/csv — Original data set taken from UCI website.
2.GarmentProductivity/ipynb — Python notebook consisting of data preprocessing involving null value removal, correction of the mislabelled category names, feature scaling using MinMaxScaler and Exploratory Data Analysis. 
3.garmentproductivityfinal/csv — Final csv file imported from the Jupyter Notebook to be loaded as a table in Matlab for further analysis. 
4.RandomForestRegression/m — Matlab file containing the code for training and testing the Random Forest ML model, along with hyper parameter optimisation and unbiased predictor selection code to improve the model performance.
5.StepWiseLinearRegression/m — Matlab file containing the code for training and testing the Stepwise Linear Regression Model, visualising the outlier and Interaction effects among the predictor variables.
6.RandomForestRegressionOutput/mlx — Live Script of the file “RandomForestRegression.m”  having the Output stored inline with the code. Use this file to directly view the output without having to run the code.
7.StepwiseLinearRegressionOutput/mlx — Live Script of the file “StepWiseLinearRegression.m”  having the Output stored inline with the code.Use this file to directly view the output without having to run the code.



**NOTE for execution of Codes - To understand the smooth flow of code, it is recommended to run each section of the scripts one by one and not run the whole script in a single go.


Order of running the codes:
1.Before running the codes it is requested to keep all the files in the zip folder intact and together, till the assessment is over.

2.First please open the file "GarmentProductivity.ipynb" and run each cell of the script one by one. At the end of the script a csv file is imported. You may close this jupyter notebook.

3.Then open the file "RandomForestRegression.m" and run all the sections one by one. After the first stage of EDA is over in this script, comments in the script will indicative the end of first stage of EDA and then you may to proceed for the second stage of the EDA in python. But please keep this file opened.

4. After that open the file "StepWiseLinearRegression.m” and run each section of the script one by one till the end. Then please close this file.

5.That's it.

			****THANK YOU FOR YOUR TIME AND PATIENCE****
