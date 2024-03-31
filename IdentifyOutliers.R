install.packages('tidyverse');
install.packages("GGally")

library(GGally)
library(ggplot2)
library(dplyr)
library(tidyr)

# Read the data from a CSV file
dataset <- read.csv('student-spending-dataset-cleaned.csv')

dataset_longer <- pivot_longer(dataset, cols = c(monthly_income, financial_aid, tuition, housing, food, transportation, books_supplies, entertainment, personal_care, technology, health_wellness, miscellaneous), names_to = "Variable", values_to = "Value")

# Create boxplots
boxplots <- ggplot(dataset_longer, aes(x = Variable, y = Value)) +
  geom_boxplot() +
  facet_wrap(~ Variable, scales = "free") + # Use 'scales = "free_y"' if you want separate y-axis scales
  theme_minimal()

# Display the plot
print(boxplots)

