
# This file is a generated template, your changes will not be overwritten

FuzzyDelphiMethodClass <- if (requireNamespace('jmvcore', quietly=TRUE)) R6::R6Class(
    "FuzzyDelphiMethodClass",
    inherit = FuzzyDelphiMethodBase,
    private = list(
        .run = function() {
          #formula <- jmvcore::constructFormula(self$options$dep, self$options$group)
          #formula <- as.formula(formula)
          
          #results <- t.test(formula, self$data)
          
          #self$results$text$setContent(results)
          
          #fuzzy set of likert 5
          likert5_data <- data.frame(
            r = c(1, 2, 3, 4, 5),
            m1 = c(0, 0, 0.2, 0.4, 0.6),
            m2 = c(0, 0.2, 0.4, 0.6, 0.8),
            m3 = c(0.2, 0.4, 0.6, 0.8, 1)
          )
          
          # Function to match Likert scale responses to m values
          likert5_to_m <- function(response){
            index <- match(response, likert5_data$r)
            if (!is.na(index)) {
              return(likert5_data[index, c("m1", "m2", "m3")])
            } else {
              return(NA)
            }
          }
          
          # Get the column names
          column_names <- names(self$data)
          # Initialize an empty list to store the results
          matched_values_list <- list()
          
          # Apply the function to each column
          for (col_name in column_names) {
            matched_values <- lapply(data[[col_name]], likert5_to_m)
            matched_values_list[[col_name]] <- do.call(rbind, matched_values)
          }
          
          # Combine the results into a data frame
          result_df <- as.data.frame(matched_values_list)
          
          # Print the result
          print(result_df)

        })
)
