# lists, S3, data frames, small look at primitives and vectors

# a list in R is an object which contains elements of different types, such as strings, numbers, vectors, other lists.

vector_ <- c(1,2,3)
character_vector <- c("Hadoop", "Spark", "Flink", "Mahout")
logical_vector <- c(TRUE, FALSE, TRUE, FALSE)
out_list <- list(vector_, character_vector, logical_vector)
out_list

list_data <- list("Red", "White", c(1,2,3), TRUE, 22.4)
print(list_data)

data_list <- list(c("Jan", "Feb", "Mar"), matrix(c(1,2,3,4,-1,9), nrow = 2), list("Red", 12.3))

#names works to get or set names to an object. Lists are objects.
names(data_list) <- c("Monat", "Matrix", "Misc")
print(data_list)
data_list$Monat
data_list$Misc
data_list$Misc[1]
data_list$Misc[2]
print(data_list[1])
print(data_list[3])
print(data_list$Matrix)


list.list_data <- list(c("Feb","Mar","Apr"), matrix(c(3,9,5,1,-2,8), nrow = 2), list("green",12.3))
names(list.list_data) <- c("Months", "Matrix", "Miscellaneous")
print(list.list_data)
length(list.list_data)
list.list_data[4] <- NULL
print(list.list_data[4])
list.list_data[4] <- "updated element"
print(list.list_data)
list.list_data[5] <- NULL
print(list.list_data)
length(list.list_data)

numeric_list <- list(1,2,3,4,5)
days_list <- list("Monday","Tuesday","Wednesday")
merged_list <- c(numeric_list, days_list)
merged_list


integer_list <- list(1:5)
print(integer_list)
integer_list2 <- list(10:14)
print(integer_list2)

vector_1 <- unlist(integer_list)
vector_2 <- unlist(integer_list2)
print(vector_1)
print(vector_2)
