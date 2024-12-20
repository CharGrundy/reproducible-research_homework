# 97 rows and 13 columns however my code actually has 96 rows instead as i had to clean/filter the origninal columns of the file due to a formatting error.


#statistical significance
# The exponent β and scaling factor α share a p value of 2e-16. This means that both are statistically significant. Therefore genome length is a reliable predicotr of virion volume. 
#Exponent (β)-
# The model that I created, when summarised, has an exponent (B) of 1.45339. this value is slightly lower than the dsDNA in the figure, which was 1.52. However, the result is still within the 95% confidence interval (1.16-1.87) and is quite close to the actual result.
# Scaling Factor (α)-
#Similarly, the scaling factor was also within the confidence interval for the figure. my model had a scaling fator of e7.57533 which is approximately 1943.6. The figure has a result of 6760 adn a 95% CI of (602–75,960).
# Both results are within the range. Therefore my model is robust.

# Transformation for analysis

#install.packages("readxl")
#install.packages("dplyr")
library(dplyr)
library(readxl)

data <- read_excel("cleaned_virus_data.xlsx")#I cleaned up the spreasheet outside of R therefore there is no code showing this

data_virus <- data[, c('Virion volume (nm×nm×nm)', 'Genome length (kb)')]

data_virus$log_Virion_volume <- log(data_virus$'Virion volume (nm×nm×nm)')
data_virus$log_Genome_length_kb <- log(data_virus$'Genome length (kb)')

model <- lm(log_Virion_volume ~ log_Genome_length_kb, data = data_virus)

summary(model)

#replication of the plot image for Q5

ggplot(data_virus, aes(x = log_Genome_length_kb, y = log_Virion_volume)) +
  geom_point() +
  xlim(c(2, 8)) + 
  ylim(c(9, 20)) +
  geom_smooth(method = "lm", aes(group = 1), color = "blue", size = 0.7) +
  xlab("log [Genome length(kb)]") +
  ylab("log [Virion volume (nm3)]") +
  theme_bw()



