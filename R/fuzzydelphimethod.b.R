
# This file is a generated template, your changes will not be overwritten

FuzzyDelphiMethodClass <- if (requireNamespace('jmvcore', quietly=TRUE)) R6::R6Class(
    "FuzzyDelphiMethodClass",
    inherit = FuzzyDelphiMethodBase,
    private = list(
        .run = function() {
          # Function to match Likert scale responses to m values          
          #fuzzy set of likert 5
          likert5_data <- data.frame(
            r = c(1, 2, 3, 4, 5),
            m1 = c(0, 0, 0.2, 0.4, 0.6),
            m2 = c(0, 0.2, 0.4, 0.6, 0.8),
            m3 = c(0.2, 0.4, 0.6, 0.8, 1)
          )

          #fuzzy set of likert 7
          likert7_data <- data.frame(
            r = c(1, 2, 3, 4, 5, 6, 7),
            m1 = c(0, 0, 0, 0.2, 0.4, 0.6, 0.8),
            m2 = c(0, 0.2, 0.4, 0.6, 0.8, 1, 1),
            m3 = c(0.2, 0.4, 0.6, 0.8, 1, 1, 1)
          )
          
          # Function to match Likert5 scale responses to m values
          likert5_to_m <- function(response){
            index <- match(response, likert5_data$r)
            if (!is.na(index)) {
              return(likert5_data[index, c("m1", "m2", "m3")])
            } else {
              return(NA)
            }
          }

          # Function to match Likert7 scale responses to m values
          likert7_to_m <- function(response){
            index <- match(response, likert7_data$r)
            if (!is.na(index)) {
              return(likert7_data[index, c("m1", "m2", "m3")])
            } else {
              return(NA)
            }
          }
          
          preformatted <- self$results$get('pre')
          preformatted$content <- ''
          
         # if (is.null(self$options$dependent) ||
          #    is.null(self$options$grouping))
           # return()
          
          data <- self$data
        #  data[[self$options$dependent]] <-
        #  jmvcore::toNumeric(data[[self$options$dependent]])
        likertVar <- self$options$likertVar
        if(likertVar == "Likert5"){
          likertToM <- likert5_to_m
        }else{
          likertToM <- likert7_to_m
        }
          
          # Get the column names
          column_names <- names(data)
          # Initialize an empty list to store the results
          matched_values_list <- list()
          
          # Apply the function to each column
          for (col_name in column_names) {
            matched_values <- lapply(data[[col_name]], likertToM)
            matched_values_list[[col_name]] <- do.call(rbind, matched_values)
          }
          
          # Combine the results into a data frame
          result_df <- as.data.frame(matched_values_list)
          
          # Print the result
         # print(result_df)
        #  self$results$text$setContent(result_df)
          
          #Calculate the fuzzy Scale
          fuzzyScale <- function (m1, m2, m3, colMeanM1, colMeanM2, colMean3){
            d <- (((colMeanM1-m1)^2)+((colMeanM2-m2)^2)+((colMean3-m3)^2))
            d <- (1/3)*d
            d <- sqrt(d)
            return(d)
          }
          

          
          # Number of items
          num_items <- ncol(result_df) / 3  # Assuming each item has three columns (m1, m2, m3)
          
          # Initialize an empty list to store the results
          result_list <- list()
          
          # Loop through each item
          for (item_num in 1:num_items) {
            # Create column names dynamically
            item_col_names <- paste("Item", item_num, sep = "")
            #print(item_col_names)
            
            # Subset the data frame for the current item
            subset_df <- result_df[, grep(item_col_names, names(result_df))]
            #print(subset_df)
            #self$results$text$setContent(subset_df)
            # Calculate the column means for the current item
            col_means <- colMeans(subset_df, na.rm = TRUE)
            #print(col_means)
            
            # Apply the fuzzyScale function to each row of subset_df
            result <- apply(subset_df, 1, function(row) {
              fuzzyScale(row[paste(item_col_names, "m1",sep=".")],
                         row[paste(item_col_names, "m2",sep=".")],
                         row[paste(item_col_names, "m3",sep=".")],
                         col_means[1], col_means[2], col_means[3])
            })
            #print(result)
            
            # Create a new data frame with the result and set column name dynamically
            result_df_item <- data.frame(Value = result)
            
            # Rename the column to the dynamically created name
            names(result_df_item)[1] <- item_col_names
            
            # Append the result to the list
            result_list[[item_num]] <- result_df_item
          }
          
          # Combine the results into a single data frame
          final_result_df <- do.call(cbind, result_list)
          
          rounded_dataframe <- round(final_result_df,1)
          
          # Print the rounded result data frame
         # print(rounded_dataframe)
        # self$results$text$setContent(rounded_dataframe)
       
        # table$setRow(rowNo=15, resultList)

          
          #column Means of each fuzzy scale
          colMeansFuzzyScale <- colMeans(final_result_df)
          colMeansFuzzyScale <- round(colMeansFuzzyScale,2)
          #print(colMeansFuzzyScale)
          #self$results$text$setContent(colMeansFuzzyScale)
          
          
          # Calculate the mean of total
          dConstruct <- mean(colMeansFuzzyScale, na.rm = TRUE)
          
          # Print the mean of total
          print("Mean of Total Fuzzy Scale:")
          dCounstruct <- round(dConstruct,2)
          print(dConstruct)
          
          calculate_consensus_percentage <- function(data_frame) {
            num_rows <- nrow(data_frame)
            consensus_threshold <- 0.2
            
            # Initialize an empty list to store the results
            result_list <- list()
            
            # Loop through each column
            for (col_num in 1:ncol(data_frame)) {
              # Calculate the percentage of values < 0.2
              below_threshold <- sum(data_frame[, col_num] <= consensus_threshold)
              percentage_consensus <- sprintf("%.2f%%", (below_threshold / num_rows) * 100)
              
              # Create a data frame with the percentage and column name
              result_df_item <- data.frame(Percentage = percentage_consensus)
              
              # Rename the column to the dynamically created name
              names(result_df_item)[1] <- names(data_frame)[col_num]
              
              # Append the result to the list
              result_list[[col_num]] <- result_df_item
            }
            
            # Combine the results into a single data frame
            final_df <- do.call(cbind, result_list)
            
            return(final_df)
          }
          
          # Example usage with your 'final_result_df' data frame
          result_percentage <- calculate_consensus_percentage(final_result_df)
          
          # Print the result
          print(result_percentage)
          
          # Modified defuzzificationCell function
          defuzzificationCell <- function(m1, m2, m3){
            sumM <- m1 + m2 + m3
            if (is.finite(sumM)) {
              aMax <- (1/3) * sumM
              return(aMax)
            } else {
              # Return a placeholder value (e.g., NA) if there's an issue with input
              return(NA)
            }
          }
          
          # 1. Calculate column sums:
          sumM <- colSums(result_df)
          
          # 2. Create a data frame with the sums:
          sumM_df <- data.frame(t(sumM))  # Transpose to have sums as columns
          
          # 3. Set column names from the original data frame:
          colnames(sumM_df) <- colnames(result_df)
          
          # 4. Print the updated data frame:
          #print(sumM_df)
          
          col_names <- colnames(sumM_df)
          #print(ncol(sumM_df))
          
          
          # Initialize an empty list to store the results
          result_deflist <- list()
          
          # Loop through each set of three columns
          for (start_col in seq(1, ncol(sumM_df), by = 3)) {
            end_col <- min(start_col + 2, ncol(sumM_df))
            
            # Extract the current set of three columns
            current_columns <- sumM_df[, start_col:end_col]
            #print(current_columns)
            
            # Apply the defuzzificationCell function to each row of the current set of columns
            result <- apply(current_columns, 1, function(row) {
              defuzzificationCell(row[1], row[2], row[3])
            })
            
            # Check if result is not NULL
            if (!is.null(result)) {
              # Assign result directly to the specific index based on loop iteration
              result_deflist[[length(result_deflist) + 1]] <- result
            }
          }
          
          result_def <- data.frame(result_deflist)
          colnames(result_def) <- paste("Item", seq_along(result_deflist), sep = "")
          
          # Print the result data frame
          print(result_def)
          
          # Assuming result_df is your dataframe
          # Extract numeric values from the dataframe
          numeric_values <- as.numeric(unlist(result_def))
          
          # Remove NA values if any
          numeric_values <- numeric_values[!is.na(numeric_values)]
          
          # Rank the numeric values in ascending order
          ranked_values <- rank(-numeric_values, na.last = "keep")
          
          # Create a dataframe with numeric values and their corresponding ranking
          ranked_df <- data.frame(NumericValue = numeric_values, Rank = ranked_values)
          
          # Print the resulting dataframe
          print(ranked_df)
         # self$results$text$setContent(ranked_df)
          
          

        })
)
