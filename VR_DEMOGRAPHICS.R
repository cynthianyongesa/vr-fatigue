# Load necessary libraries
library(Gmisc)
library(dplyr)
library(kableExtra)
library(magick)
library(readr)
library(writexl)
library(webshot2)

# Set working directory (update to your path)
setwd("/Users/cynthianyongesa/Desktop/Desktop - Cynthia's Macbook Pro/DATA/6_VR_FATIGUE/")

# Read the data
data <- read.csv('demographics_participant_scores_symptoms_NEW.csv')

# Check available columns
print(colnames(data))

# Factorize categorical variables based on user's preferred order
data$ref_assigned_group <- factor(data$ref_assigned_group, 
                                  levels = c(3, 2, 1),
                                  labels = c("Bike only", "VR Only", "VR + C"))

data$sex <- factor(data$sex, levels = c(0, 1), labels = c("Male", "Female"))

data$ref_pt_status <- factor(data$ref_pt_status, 
                             levels = c(3, 2, 1, 4),  # Custom order provided
                             labels = c("Completed 16 weeks of Training sessions", 
                                        "Currently completing Acclimation or Training sessions", 
                                        "Completed Baseline, pending acclimation",
                                        "Dropped out"))

data$telephonescreen_race_v2 <- factor(data$telephonescreen_race_v2, 
                                       levels = c(1, 2, 3, 4, 5, 7),
                                       labels = c("White", "Black or African American", 
                                                  "American Indian or Alaska Native", 
                                                  "Asian", "Native Hawaiian or Other Pacific Islander", "Other"))

data$telephonescreen_ethnicity_v2 <- factor(data$telephonescreen_ethnicity_v2, 
                                            levels = c(1, 2),
                                            labels = c("Hispanic or Latino", "Not Hispanic or Latino"))

# Select relevant columns (excluding NASA, SCC, and RPE)
demographics_data <- data %>% 
  select(ref_assigned_group, ref_pt_age_target_hr, sex, ref_pt_status, 
         telephonescreen_race_v2, telephonescreen_ethnicity_v2, 
         cri_years_education, cri_result_quant_score, mca_total)

# Function to get descriptive stats and p-values
getT1Stat <- function(varname, digits = 1){
  getDescriptionStatsBy(demographics_data[[varname]], 
                        demographics_data$ref_assigned_group, 
                        add_total_col = TRUE,
                        show_all_values = TRUE, 
                        statistics = TRUE, 
                        html = FALSE, 
                        digits = digits)
}

# Create descriptive statistics table
table_data <- list(
  "Age" = getT1Stat("ref_pt_age_target_hr"),
  "Gender (%)" = getT1Stat("sex"),
  "Participant Status (%)" = getT1Stat("ref_pt_status"),
  "Race (%)" = getT1Stat("telephonescreen_race_v2"),
  "Ethnicity (%)" = getT1Stat("telephonescreen_ethnicity_v2"),
  "Years of Education" = getT1Stat("cri_years_education"),
  "Quantitative Score" = getT1Stat("cri_result_quant_score"),
  "MCA Total" = getT1Stat("mca_total")
)

# Convert table data to a matrix for HTML table rendering
rgroup <- names(table_data)
n.rgroup <- sapply(table_data, nrow)
output_data <- do.call(rbind, table_data)

# Fix formatting issues, replacing symbols
output_data <- apply(output_data, 2, function(x) gsub("\\$\\\\pm\\$", " ± ", x))
output_data <- apply(output_data, 2, function(x) gsub("\\$", "", x))
# Fix formatting issues: replacing LaTeX-style symbols
output_data <- apply(output_data, 2, function(x) gsub("\\\\pm", "±", x))  # Replace \pm with ±
output_data <- apply(output_data, 2, function(x) gsub("\\\\%", "%", x))   # Replace \% with %


# Define column groups
cgroup <- c("", "Assigned Group")
n.cgroup <- c(2, 3)

# Generate and style HTML table with black text
styled_html <- htmlTable(output_data, 
                         align="rrrr",
                         rgroup=rgroup, 
                         n.rgroup=n.rgroup, 
                         rowlabel="",
                         cgroup=cgroup, 
                         n.cgroup=n.cgroup,
                         escape.html = TRUE,  # Prevent LaTeX rendering
                         caption="Table 1: Participant Demographics and Scores",
                         tfoot="Values are presented as mean ± SD or N (%) where applicable. P-values calculated using ANOVA or chi-square tests as appropriate.",
                         ctable=TRUE)

# Save as HTML with styling
html_file <- "Cleaned_Demographics_Table.html"
writeLines(
  paste0(
    "<html><head><style>body { color: black; font-family: Arial, sans-serif; font-size: 12px; }</style></head><body>", 
    styled_html, 
    "</body></html>"
  ),
  con = html_file
)

# Convert to high-DPI image
webshot2::webshot(html_file, 
                  file = "Demographics_Table_HighDPI.png", 
                  zoom = 6)  # Increase zoom for higher resolution

print("Demographics table saved as high-DPI image and HTML.")

# Save as CSV file
write_csv(as.data.frame(output_data), "Demographics_Table.csv")

# Save as Excel file
write_xlsx(as.data.frame(output_data), "Demographics_Table.xlsx")

print("Demographics table saved as CSV and Excel files.")