#Setting global variables, options, loading libraries etc...



# Generate training data; pay and debt. 
c1.pay.train=matrix(c(runif(10, min = 10, max = 15)),nrow=10)
c1.debt.train=matrix(c(runif(10, min = 8, max = 12)),nrow=10)
c1.train =cbind(c1.pay.train,c1.debt.train)
c1.train

c2.pay.train=matrix(c(runif(10, min = 10, max = 15)),nrow=10)
c2.debt.train=matrix(c(runif(10, min = 8, max = 12)),nrow=10)
c2.train =cbind(c2.pay.train,c2.debt.train)
c2.train
x.train =rbind(c1.train,c2.train)
x.train
# add one more column to the data set x , so that we can do matrix multiplication of Transpose of x with w
x.train = cbind(rep(1, nrow(x.train)), x.train)
x.train

# Plot the dataset, to see if the data is linearly separable. 
#Ploting shows + if pay-debt >=2.5 and - otherwise
plot(x.train[,2:3],pch=ifelse(x.train[,2]-x.train[,3]>2.5,"+","-"),xlim=c(1,20),ylim=c(1,20))
abline(0,0.8)




#Using (pay-debt=2.5;meaning customer need to have atleast 2.5K in hand to geta positive decision) 
#as a decision point, generate decision vector y
y.train = ifelse(x.train[,2]-x.train[,3]>2.5,1,-1)
y.train
#Here, the first 10 data points show negative decision, while the next 10 points are positive.
#Data was generated thus to be linearly separable.

####################################################################################
# Code for PLA
# 
# 1) Initialize the weight vector W to 0. This will classify all 20 datapoints in the 
# Train data to positive value (1 in this case)
#
# 2) Calculate decision for each customer (h(x)  h.x = sign(transpose of W * (X))
# 3) Pick any misclassified point (xn, yn)
# 4) Update the weight vector by w <- w + yn * xn
# 5) Repeat until no points are misclassified
####################################################################################
pla.func = function(x, y) {
  # mark the prediction rule to 'FALSE'. This will be set to TRUE if ideal prediction rule is found.
  decision.rule = FALSE
  
  # starts with an initial zero prediction vector w
  w = matrix(0, 1, 3)
  
  
  # Run for 10000 iterations
  for (i in 1:10000)
  {
    # Calculate y with the weight vector w and the dataset x. Assuming most of the data p
    y.hat = ifelse(w %*% t(x) > 0, 1, -1)
    # Calculate the misclassified entries. Each row represent one entry where the decision y based
    # on weight vector does not match the corresponding actual decision y.
    misclass.flag = y.hat != y
    
    
    # Check if all of the points are classified correctly, and break the iteration loop
    if (sum(misclass.flag) == 0)
    {
     
      decision.rule = TRUE
      break
    }
    else
    {
      # If learned decision rule cannot correctly classify all entries, then update 
      # the weight vector now using any one of the misclassified input (not necessary in any order)
      
      # Get all the misclassified entries, based on the flag (which will be either 1 or -1, but for 
      # this project, 10 are positive and 10 are negative. So, 10 rows from x will be returned.)
      misclass.entries.x = x[misclass.flag, , drop = FALSE]
      misclass.entries.y = y[misclass.flag]
      
      # Next step is to sample one of the miss-classified entries
      
      misclass.entry.x = misclass.entries.x[sample(dim(misclass.entries.x)[1], 1), , drop = FALSE]
      misclass.entry.y = misclass.entries.y[sample(dim(misclass.entries.x)[1], 1)]
      
      # Now update the weight vector
      w = w + misclass.entry.y %*% (misclass.entry.x/100)
      
    }
    
    # Repeat the process of updating the weight vector w
  }
  
  if (decision.rule)
  {
    cat('Decision Rule found! Iteration ', i, ' , with final weight : ', w, '\n')
  }
  else
  {
    cat('No Decision Rule!\n')
  }
  
  return(w)
}

####################################################################################

new.weight = pla.func(x.train,y.train)

# Generate test data; pay and debt. Ploting shows + if pay-debt >=2.5 and - otherwise
c1.pay.test=matrix(c(runif(5, min = 8, max = 9)),nrow=5)
c1.debt.test=matrix(c(runif(5, min = 7, max = 8)),nrow=5)
c1.test =cbind(c1.pay.test,c1.debt.test)
c1.test

c2.pay.test=matrix(c(runif(5, min = 8, max = 10)),nrow=5)
c2.debt.test=matrix(c(runif(5, min = 6, max =7)),nrow=5)
c2.test =cbind(c2.pay.test,c2.debt.test)
c2.test
x.test =rbind(c1.test,c2.test)
x.test
# Plot the dataset, to see if the data is linearly separable
plot(x.test,pch=ifelse(x.test[,1]-x.test[,2]>2.5,"+","-"),xlim=c(1,20),ylim=c(1,20))
abline(new.weight[,1],-new.weight[,2]/new.weight[,3], lwd= 2,col="green")



# add one more column to the data set x , so that we can do matrix multiplication of Transpose of x with w
x.test = cbind(rep(1, 10), x.test)
x.test


#Testing new data against the learned weight vector new.weight
y.test = ifelse(new.weight %*% t(x.test) >0,1,-1)
y.test

# Let us find out if the PLA has predicted all test data points correctly using the updated
# weight vector
df=data.frame(rbind2(ifelse(t(x.test[,2] - x.test[,3])>2.5,1,-1),y.test))
df=t(df)
colnames(df) = c("Actual","Predicted")
df
####################################################################################
