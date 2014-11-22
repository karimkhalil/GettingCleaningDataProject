Different variables are described in the original data set in the file (features_info.txt).

The R script run_analysis.R combines training data and test data into single data frame.

It also combines the subject ID and activity type information into a single data frame by reading multiple files and adding corresponding values.
After appropriately naming variables and activity types, a clean data set is generated in a text file (Tidy_data.txt).

Finally, the script computes the average value for each variable parametrized by subject ID and activity type. A new data frame is generated and stored in a separate text file (Tidy_data2_avgs.txt).
