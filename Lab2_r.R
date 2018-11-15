### STAT 1261 Principles of Data Science ###
### Fall 2018 ###

### Lab 2 - Introduction continued  ###

#####################
## Plotting Basics ##
#####################

# We can plot two vectors against each other using the "plot" function:
a <- seq(from = 1,to = 10,by = 0.5)
b <- -9:9
plot(a,b)

# but as we see, the vectors must be the same length

b2 <- b[2:6]
b2
plot(a,b2)

# we can add titles to the plots

plot(a,b,xlab="X-Axis",ylab="Y-Axis",main="Plot Title")

# If we want to plot a particular function, we can define the domain as a 
# sequence/vector of points and plot the function of that vector:

x <- seq(0,2*pi,0.1)
y <- sin(x)
plot(x,y)

# if we want to see a line instead of points, points with a line, we use 
# type="l" ("l"ine) or type = "b" ("b"oth points and lines).  The default is ("p"oints)

plot(x,y,type="l")
plot(x,y,type="b")

# Putting all of this together, we have

plot(x,y,type="l",xlab = "x", ylab = "f(x) = sin(x)", main="Graph of sin(x)")


######################
# Modes of an object #
######################

# There are several "modes" (i.e. variable types) in R.  Thus far, 
# we have seen numeric, logical, and character (strings).  We can
# use the mode function in R to determine the mode of a variable

x <- 5
mode(x)

x <- TRUE
mode(x)

x <- "Lucas Mentch"
mode(x)

# Note that character type variables can be treated in the same 
# fashion as numeric type variables and vectors

x <- c(1,2,3,4,5)
mode(x)

x <- c("Lucas","K","Mentch")
x
mode(x)

# We can also use the "paste" function in place of the of the "c" (combine) function to create a vector of strings/characters

w <- "Lucas"
x <- "K"
y <- "Mentch"

z <- paste(w,x,y)
z    

# We can also specify a character to be placed between strings by
# using the "sep" option; the default is " " - a blank space

z <- paste(w,x,y,sep=".")
z

z <- paste(w,x,y,sep=",")
z

# We can force something numeric to be treated as a character and 
# vice versa using the as.character and as.numeric functions

x <- "7"
x
mode(x)
x + 5

x <- as.numeric(x)
x
mode(x)
x + 5


# If displaying numerical/character results is an issue, the
# 'format' function can be of use, but we will not go into that here


#####################
#####  Lists  #######
#####################

## Lists ##

# One type of object we have not mentioned yet are lists.
# Lists are almost the same as vectors, but can contain different types
# of objects - even dataframes (which we will see later).

newList <- list("LUCAS",x,y,z,6,7,8)
newList

# Again with lists, the [ ] brackets are used to take a subset - or 
# in this case, sub-list, so that doing this results in another list:

newList[3]
mode(newList[3])

# If we use [[ ]], we can extract elements from the list, which remain
# in their original mode

newList[[3]]
mode(newList[[3]])

# Thus, we can look at individual elements of the list elements using
# this notation:

newList[[3]][1]

# but not with the single bracket [ ] notation.  Remember, the single
# bracket notation only gives us a list, which in this case would be
# of length 1

newList[3][1]

# We can also 'flatten' a list (i.e. convert it to a vector) using
# 'unlist'.  Note that if all elements of the list are of the same 
# mode, the vector will be of that mode.  Otherwise, all elements are
# treated as characters, because all elements of a vector must be of the 
# same mode.

# We can add names to the elements of a list using 'names' and access
# the individual elements of a list using a '$'.  

names(newList) <- c("Lucas", "x","y","z","six","seven","eight")
newList$x
newList$Lucas



####################
### Data Frames ####
####################

# Although R can be termed a programming language in its own right, it 
# is most useful for statisticians because of the plethora of statistical
# functions that have been written for it and as statisticians, we will
# frequently need to analyze data.  We do this in R by creating and 
# manipulating objects called data frames.

# If the data we are interested in already exists in R (as vectors, 
# for example), we can easily create a data frame with the data.frame
# function:

height.in <- c(72,73,66,68,76,62,60)
weight.lb <- c(180,185,170,169,180,200,150)

size.dat <- data.frame("Height"=height.in,"Weight"=weight.lb)
size.dat
class(size.dat)

# Now we see that size.dat is a data frame in R.  The names of the variables
# in the data frame are "Height" and "Weight".  To access the variables, we
# use the '$' sign:

size.dat$Height

# Now size.dat$Height is a vector that we can save and manipulate as such:
height.vect <- size.dat$Height

# We can pull out one element from the vector easily.
height.vect[1]

# We can also use matrix-like notation to get at elements in the data frame:

# The first column:
size.dat[,1]

# The second row:
size.dat[2,]

# The second entry in the third row:
size.dat[3,2]

#########################
### Data Frames in R ####
#########################

# R has several built in data frames for us to play around with 
# without having to create our own.  Let's look at this now:

library(MASS) # MASS is a package. Use library() function to load a package

# now we get more information about the datasets in this library

data()

# lets get more information about the 'trees' dataset

?trees

# now lets load the dataset

data(trees)

# typing the name of the dataset will display it

trees

# sometimes however, if we have a big dataset, we may not want
# to see the whole thing, but only the first or last few entries
# to get a feel for the data.  The 'head' and 'tail' functions
# allow us to do that

head(trees) # By default, R output 6 observations.
tail(trees)

head(trees,10) # You can also change number for example to 10
tail(trees,5)

# to see the names of the variables in the dataset, we use 'names'

names(trees)

# to get the dimensions of the dataset, use 'dim'

dim(trees)

# so we see there are 31 observations and 3 variables.
# To access one of the variables in the dataframe, we use '$' as above:

trees$Girth
trees$Volume

# if we are only dealing with one dataset and there are many 
# variables, using the '$' everytime may get tedious.  To avoid
# this, we can use 'attach' to attach the dataset

attach(trees)

# Now we can access the variables using only the variable names and 
# treat them just as we would any other vector

Girth
Volume
mode(Girth)

# If we begin working with another dataset, it is usually best to
# 'detach' the other dataset, which we do using 'detach'

detach(trees)
Girth
trees$Girth


############################
###       Packages      ####
############################

# You'll also need to install some R packages. An R package is a 
# collection of functions, data, and documentation that extends the 
# capabilities of base R. Using packages is the key to the successful use of R. 
# Packages consist of functions, data sets, examples, vignettes and 
# help files and can be downloaded from CRAN or github. 
# The function install.packages() can be used to download and install packages.

# Let's first download and install a package named "NHANES"

install.packages("NHANES")

# alternatively, use the "Packages" tab in RStudio. Try install the package "babynames"

# load the NHANES package to R and see the help file

library(NHANES)
?NHANES  # A description of the package is shown in the lower-right window.

# Throughtout the semester, we will use the packages "mdsr", "mosaic" (among others).
# Installing one package may require installing other packages. 

install.packages("mdsr")
install.packages("mosaic")


############################
### Working Directories ####
############################

# Normally, we want to analyze our own dataset.  Before we talk about
# reading in data from a file, we need to pause for a second and look at
# the directory structure in R.

# When you start R, it will define a space on your computer where certain 
# types of output can be loaded from and saved.  To see the current working 
# directory, use "getwd"

getwd()

#To change the current working directory, use "setwd"

setwd("/Users/firstnamelastname/Desktop")

# If you are unfamiliar with the directory structure on your computer, you
# can select the appropriate folder via the dropdown menu in R to avoid
# having to use the setwd() function.

# Once your working directory is set, this is the location that R will look to
# to read in data and also where R will write/save data that you tell it
# to export.

############################
##### Reading in Data ######
############################

# To read in our own data, we use the 'read.table' function. There are
# many options with this function, but the most important are
# 'file', 'header', and 'sep'.  'file' is simply the name of the 
# file containing the data.  'header' can be set to TRUE or FALSE 
# depending on whether the data columns in the file contain names
# of the variables in that particular column.  'sep' tells R how 
# the data are spaced in the file.  The most common seperation
# characters are spaces, tabs, and commas (as in a .csv file).

# Lets look at an example dataset.  We can see that the name of the 
# file is RobbinData.txt, the columns are labeled with variable 
# names, and the data is seperated with commas.  Thus, the following
# code will read in this data:


getwd()
# Download RobbinData from the course webpage and save it in your work directory 
# Click the file name to open it, then right-click and choose "save as". 
# Make sure you save it in your current work directory.
RobbinData <- read.table(file="RobbinData.txt",header=TRUE,sep=",")

# You may also read it directly from the webpage.
RobbinData <- read.table(file="http://www.pitt.edu/~jub69/material/RobbinData.txt",header=TRUE,sep=",")

# Now we have the dataset read into R and we can use it as we would any
# data frame

names(RobbinData)
head(RobbinData)

# Now that we have the data read in, if we want to ultimately do
# any intelligent analysis, we need to get familiar with the data
# and a lot of times, this might not be as easy as it seems, unless
# you are extremely familiar with the study

# For example, in this case, we see that 'DayCollected' is a 
# variable name.  Is this Day of the week?  of the month?  of the
# year?

max(RobbinData$DayCollected)

# Since the max is '31', we can probably assume that this is 
# referring to day of the month.  How about 'TimeCollected'

max(RobbinData$TimeCollected)
min(RobbinData$DayCollected)

# We see this ranges from 1 to 20.5, so perhaps this is the hour
# of the day during which the observation was made.

# Remember, that when we manipulate vectors in R, we subset one based on
# values of another.  This will be of great use with data frames when
# we treat each column as a vector.  For example:

RobbinData$MonthCollected[RobbinData$YearCollected==2004]

# will produce of vector of months corresponding to the observations taken 
# during 2004.

# We can also select entire columns/variables using the [ ] subset
# notation, thereby creating a 'sub'-dataframe:

a <- RobbinData[2:3]

# We can also use just the names of the columns in this case:

x <- RobbinData[c("Latitude","Longitude")]
x

# Note that this 'sub-dataframe' is still a dataframe

class(x)
is.data.frame(x)

# Further, we can think of the dataframe as a matrix - the elements
# of the dataframe can be extracted using matrix notation, as discussed 
# earlier.

RobbinData[1:3,2:3]


