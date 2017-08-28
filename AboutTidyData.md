### Note about Tidy Data and My Choice to use the Long Form

##### Definition of Tidy Data

* Each variable in the data set is placed in its own column
* Each observation is placed in its own row
* Each value is placed in its own cell

##### About the Long Form

Hadley Wickham, in his article "Tidy Data", states, "To tidy [the data], we need to melt, or stack it. In other words, we need to turn columns into rows… this is often described as making wide datasets long or tall." He goes on to explain that melting converts the columns containing the values into two variables: a column that contains "repeated column headings and a new variable called *value* that contains the data values from the previously separate columns."  (page 6, *Journal of Statistical Software Volume VV, Issue II*. http://vita.had.co.nz/papers/tidy-data.pdf)

In "[An Introduction to reshape2](http://seananderson.ca/2013/10/19/reshape.html)" blogger Sean C. Anderson additionally states:

> It turns out that you need wide-format data for some types of data analysis and long-format data for others. *In reality, you need long-format data much more commonly than wide-format data* (emphasis added). For example, ggplot2 requires long-format data (technically tidy data), plyr requires long-format data, and most modelling functions (such as `lm()`, `glm()`, and `gam()`) require long-format data. But people often find it easier to record their data in wide format.
