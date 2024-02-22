
# This file is a generated template, your changes will not be overwritten

FuzzyDelphiMethodClass <- if (requireNamespace('jmvcore', quietly=TRUE)) R6::R6Class(
    "FuzzyDelphiMethodClass",
    inherit = FuzzyDelphiMethodBase,
    private = list(
        .init = function() {
            table1 <- self$results$scoreTable
            for (name in self$options$deps) {
              table1$addColumn(name, title=name)
            }
            
            table3 <- self$results$compTable
            for (name in self$options$deps) {
              table3$addColumn(name, title=name)
            }
            
          },
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
          
          rounded_dataframe <- round(final_result_df,2)

         # self$results$text$setContent(rounded_dataframe)
          

          
          #column Means of each fuzzy scale
          colMeansFuzzyScale <- colMeans(final_result_df, na.rm = TRUE)
          colMeansFuzzyScale <- round(colMeansFuzzyScale,2)

          
          # Calculate the mean of total
          dConstruct <- mean(colMeansFuzzyScale, na.rm = TRUE)

          calculate_consensus_percentage <- function(data_frame) {
            num_rows <- nrow(data_frame)
            consensus_threshold <- 0.2
            
            # Initialize an empty list to store the results
            result_list <- list()
            
            # Loop through each column
            for (col_num in 1:ncol(data_frame)) {
              # Calculate the percentage of values < 0.2
              below_threshold <- sum(data_frame[, col_num] <= consensus_threshold)
              percentage_consensus <- as.numeric((below_threshold / num_rows) * 100)
              
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
          
          perCentageDCon <- rowMeans(result_percentage, na.rm = TRUE)
          
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
          
          
            avgM <- colMeans(result_df)
            avgM_df <- data.frame(t(avgM))  # Transpose to have sums as columns
            colnames(avgM_df) <- colnames(result_df)
            col_names <- colnames(avgM_df)

            # Initialize an empty list to store the results
              result_deflist <- list()

              # Loop through each set of three columns
              for (start_col in seq(1, ncol(avgM_df), by = 3)) {
                end_col <- min(start_col + 2, ncol(avgM_df))

                # Extract the current set of three columns
                current_columns <- avgM_df[, start_col:end_col]
                #print(current_columns)

                # Apply the defuzzificationCell function to each row of the current set of columns
                resultD <- apply(current_columns, 1, function(row) {
                  defuzzificationCell(row[1], row[2], row[3])
                })

              # Check if result is not NULL
              if (!is.null(result)) {
                # Assign result directly to the specific index based on loop iteration
                result_deflist[[length(result_deflist) + 1]] <- resultD
              }
              }

              result_def <- data.frame(result_deflist)
              colnames(result_def) <- paste("Item", seq_along(result_deflist), sep = "")

          
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
              #print(ranked_df)
            # self$results$text$setContent(ranked_df)

              # transpose data frame
              new_ranked_df <- data.frame(t(ranked_df))

              # redefine row and column names
              rownames(new_ranked_df) <- colnames(ranked_df)
              colnames(new_ranked_df) <- rownames(ranked_df)

              # remove row names
              row.names(new_ranked_df) <- NULL

              # rename column names
              colnames(new_ranked_df) <- paste("Item", 1:ncol(new_ranked_df), sep = "")
              # Remove the first row from the dataframe
              new_ranked_df <- new_ranked_df[-1, ]

      
              
              #output FUzzy Score into scoreTable = table1
              table1 <- self$results$scoreTable
              for (rowNom in seq_len(nrow(rounded_dataframe))) {
                if (rowNom > table1$rowCount)
                  break()
                values <- as.list(rounded_dataframe[rowNom,])
                table1$setRow(rowNo=rowNom, values)
                table1$setRow(rowNo=rowNom, list(var=paste("Expert ", rowNom)))
              }
              
              for (rowNom in seq_along(colMeansFuzzyScale)) {
                values <- as.list(colMeansFuzzyScale[rowNom])
                table1$setRow(rowNo=18, values)
              }
              table1$setRow(rowNo=18, list(var="Value d of each item"))
              
              for (rowNom in seq_along(result_percentage)) {
                values <- as.list(result_percentage[rowNom])
                table1$setRow(rowNo=19, values)
              }
              table1$setRow(rowNo=19, list(var="% of expert consensus for each item"))
              
              for (rowNom in seq_along(result_def)) {
                values <- as.list(result_def[rowNom])
                table1$setRow(rowNo=20, values)
              }
              table1$setRow(rowNo=20, list(var="Defuzzification"))
        
              for (rowNom in seq_along(new_ranked_df)){
                # format(round(new_ranked_df[rowNom], digits=1), nsmall=1)
                # values <- as.list(format(round(new_ranked_df[rowNom], digits=1), nsmall=1))
                values <- as.list(new_ranked_df[rowNom])
                table1$setRow(rowNo=21, values)
              }
              table1$setRow(rowNo=21, list(var="Item ranking"))
              
             # self$results$text$setContent(colMeansFuzzyScale)
              
              table3 <- self$results$compTable
              for (rowNom in seq_along(colMeansFuzzyScale)) {
                values <- as.list(colMeansFuzzyScale[rowNom])
                table3$setRow(rowNo=1, values)
              }
              table3$setRow(rowNo=1, list(var="Value d of each item"))

              for (rowNom in seq_along(result_percentage)) {
                values <- as.list(result_percentage[rowNom])
                table3$setRow(rowNo=2, values)
              }
              table3$setRow(rowNo=2, list(var="% of expert consensus for each item"))
              
              for (rowNom in seq_along(result_def)) {
                values <- as.list(result_def[rowNom])
                table3$setRow(rowNo=3, values)
              }
              table3$setRow(rowNo=3, list(var="Defuzzificationt"))
              
              for (rowNom in seq_along(new_ranked_df)){
               # format(round(new_ranked_df[rowNom], digits=1), nsmall=1)
               # values <- as.list(format(round(new_ranked_df[rowNom], digits=1), nsmall=1))
                values <- as.list(new_ranked_df[rowNom])
                table3$setRow(rowNo=4, values)
              }
              table3$setRow(rowNo=4, list(var="Item ranking"))
              
              
            #output the calculated Info into dcTable = table2            
              table2 <- self$results$dcTable
              #row1 = value d construct
              table2$setRow(rowNo=1, values=list(
                var = "Value d construct",
                varDconstruct = format(round(dConstruct,digits = 2), nsmall = 2)
              ))
              #row2 = result percentage
              table2$setRow(rowNo=2, values=list(
                var = "%o f expert consesnsus for construct",
                varDconstruct = format(round(perCentageDCon,digits = 2), nsmall=2)
              ))

        })
)
