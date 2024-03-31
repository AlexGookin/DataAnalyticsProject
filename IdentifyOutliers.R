install.packages('tidyverse');
install.packages("GGally");

library(GGally)
library(ggplot2)
library(tidyr)
library(gridExtra)
library(grid)

# Read the data from a CSV file
dataset <- read.csv('student-spending-dataset-cleaned.csv')

#normalized data. Uses z-scoring
dataset_normalized <- as.data.frame(scale(select_if(dataset, is.numeric)))

#Convert dataframes into long format
dataset_long <- pivot_longer(dataset, cols = c(monthly_income, financial_aid, tuition, housing, food, transportation, books_supplies, entertainment, personal_care, technology, health_wellness, miscellaneous), names_to = "Variable", values_to = "Value")
normalized_long <- pivot_longer(dataset_normalized, c(monthly_income, financial_aid, tuition, housing, food, transportation, books_supplies, entertainment, personal_care, technology, health_wellness, miscellaneous), names_to = "Variable", values_to = "Value")

# Create boxplots
unnormalized_boxplots <- ggplot(dataset_long, aes(x = Variable, y = Value)) +
  geom_boxplot() +
  facet_wrap(~ Variable, scales = "free") + # Use 'scales = "free_y"' if you want separate y-axis scales
  theme(plot.title = element_text(hjust=0.5)) +
  ggtitle("Not Normalized")

normalized_boxplots <- ggplot(normalized_long, aes(x = Variable, y = Value)) +
  geom_boxplot() +
  facet_wrap(~ Variable, scales = "free") + # Use 'scales = "free_y"' if you want separate y-axis scales
  theme(plot.title = element_text(hjust=0.5)) +
  ggtitle("Normalized")


# Display the plots
grid.arrange(normalized_boxplots, unnormalized_boxplots, ncol = 2)

