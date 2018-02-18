# A-Simple-Perceptron
Implement the Perceptron Learning Algorithm (PLA) for binary classification

Problem Description:
Use 20 data points for training (10 for each class) and 5 for testing. Generate training and test data.

Notes
1. The training data points are linearly separable.

For the project, using R, random numbers are generated for two variables, pay and debt.
The binary decision for + or – is
pay – debt > 2.5 = “+” ; otherwise “-”
The idea was to keep the problem really simple with a binary output. 20 data points is ideal to understand how the algorithm learns the decision boundary.

2. The test points are linearly separable:

The test data also is generated using runif, random number generator in R. The data is generated range-bound, so as to have linearly separable data. In the test data, the first 5 records will never be satisfying the condition
pay – debt > 2.5 = “+” since max(pay) = 9 and min(debt) = 7

3. Initial choice of the weights are set to zero


4. The final solution equation of the line (decision boundary) varies with each run of the program, since the training data points and the test data points are not static.

5. The total number of weight vector updates that the algorithm makes varies, along with the changing values for data points. Each iteration of the algorithm updates the weight vector more than once (since the weight vector stars with all zeros). So the actual number of updates will be much higher than the iterations (iterations are counted in the program run, not individual updates)

6. The total number of iterations made over the training set again varies based on the data points (for both training and test)

7. the final misclassification error, if any, on the training data and also on the test data:

Training data misclassification error = none
Test data misclassification error = varies

8. The initial choice of the weights

Setting the weight vector to all 0.1 or higher (instead of all zeros) makes the program iterate for more number of times than when the weight vector is set to 0 for all values. No decision rule was found in one of the program runs.
Setting the value to 1 resulted in more iterations for decision rule, and setting it to 5 completely threw off the test runs, with inaccurate predictions.

9. The initial choice of the step size constant (c)

The weight vector was updated as a whole by a 1/100th fraction. When this was changed to 0.5, the decision boundary was not accurately predicting the test runs.

10. the order in which the program considers the points in the training set.

The data points in the training set are generated randomly. The order does not have any effect on training/testing.
This could be different if a fixed training and testing data set had been used.
