Code Book for the project of the Getting and cleanning Data course
========================================================

## Dataset Source
The original dataset can be downloaded from [http://archive.ics.uci.edu/ml/machine-learning-databases/00240/](http://archive.ics.uci.edu/ml/machine-learning-databases/00240/ )

## Dataset brief description
The dataset contains data used in the experiment "Human Activity Recognition Using Smartphones Data Set". 
It is made of data from a Samsung Galaxy II accelerometer and gyroscope.

For each record in the dataset it is provided: 
- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration. 
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

As a machine learning experiment, the dataset is already split in training and test data

## Transformation

As required by the project, the original dataset has been transformed following the following steps.

- Merging the train and data sets
- Subsetting the dataset in order to get only the features related to means and std calculations
- Adding  the text description of each activity to the dataset. (In the original train and test data there  is only         activity IDs)
- In the orignal dataset, observations for every subject and the activity they were performing are provided in separate files. This ID information has been added to the dataset.
- As a result of the processing a summarized dataset is generated: The original data is made of several observations for the same subject and the same activity. The generated dataset will have, as observations, the mean of every observation of the same subject and activity in the original data set.

So, the resulting dataset is made of:
* An observation (a row) for every subject of the experiment and every activity observed
* A variable (col) for every variable realated with means and std´s previously filtered

## Variables

The variables in the generated dataset are:
* Subject: ID of the observed subject (Numeric)
* Activity: Activity performed by the subject (Categorical: WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING)
* Means of the original variables related to means and std´s

### Variable naming, selection and transformation

The variable names have been transformed from the original dataset.

Examples of original variable names are:  fBodyAccMag-mean(),  tBodyAcc-mean()-Y, fBodyBodyGyroJerkMag-kurtosis(), fBodyBodyGyroMag-std()

From those variables:

* Only names containing the string "-mean()" or "-std()" have been selected.
* The R function *make.names* has been applied. As a result, names like "tBodyAcc-mean()-Y" changes to "tBodyAcc.mean...Y"
* Groups of two consecutives dots have been removed. In doing so now,  "tBodyAcc.mean...Y" becomes "tBodyAcc.mean.Y"


































