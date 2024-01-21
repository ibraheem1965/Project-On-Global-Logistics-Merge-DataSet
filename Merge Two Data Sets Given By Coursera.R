# Load required libraries
library(dplyr)
library(fuzzyjoin)
library(tidytext)

# Define folder path
folder_path <- "C:/Users/coded/Desktop/R Demo Projects/Merge Two Data Sets Given By Coursera/"

# Read the first CSV file
file1 <- paste0(folder_path, "Global Logistics Association.csv")
data1 <- read.csv(file1)

# Read the second CSV file
file2 <- paste0(folder_path, "International Logistics Association Memberships.csv")
data2 <- read.csv(file2)

# Convert Member ID to character in both data frames
data1$Member.ID <- as.character(data1$Member.ID)
data2$Member.ID <- as.character(data2$Member.ID)

# Perform a fuzzy join based on Jaccard similarity
merged_data <- data1 %>%
  fuzzyjoin::stringdist_left_join(data2, by = "Member.ID", method = "jaccard", max_dist = 0.2)

# Clean data, remove redundancy, and reduce redundancy
cleaned_data <- merged_data %>%
  select(-matches("Address"), -matches("Address\\d+")) %>%
  distinct()

# Export the final merged and cleaned data to CSV
output_file <- paste0(folder_path, "Final_Merged_Data.csv")
write.csv(cleaned_data, output_file, row.names = FALSE)

# Print a summary or any additional checks if needed
summary(cleaned_data)
