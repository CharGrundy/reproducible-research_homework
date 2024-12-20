# Reproducible research: version control and R

## Instructions

The homework for this Computer skills practical is divided into 5 questions for a total of 100 points. First, fork this repo and make sure your fork is made **Public** for marking. Answers should be added to the # INSERT ANSWERS HERE # section above in the **README.md** file of your forked repository.

Questions 1, 2 and 3 should be answered in the **README.md** file of the `logistic_growth` repo that you forked during the practical. To answer those questions here, simply include a link to your logistic_growth repo.

https://github.com/CharGrundy/logistic_growth

**Submission**: Please submit a single **PDF** file with your candidate number (and no other identifying information), and a link to your fork of the `reproducible-research_homework` repo with the completed answers (also make sure that your username has been anonymised). All answers should be on the `main` branch.

## Assignment questions 

https://github.com/CharGrundy/logistic_growth


   a) A script for simulating a random_walk is provided in the `question-4-code` folder of this repo. Execute the code to produce the paths of two random walks. What do you observe? (10 points) \

When I run the code, I can observe two separate plots. Both plots have the exact same characteristics. Both plots produce random walks which begin at t=0 and end at t=500. The time of each walk is indicated by a colour gradient begining at a navy blue and ending in a lighter shade of blue. Each walk is made up of equally distanced 'steps' that have completely random directions for each step. Walks appear to meander around the starting point which is x=0 and y=0. How much they deviate from the starting point is down to random chance. Each time the code is ran the plots are completely different and move to different coordinates in the plots. One plot may move into more negative coordinates the other may not. 

   b) Investigate the term **random seeds**. What is a random seed and how does it work? (5 points) \

Random seeds in R are used to initialise a random number generator. A random number generator will produce a set of random numbers. A random number genrator is still deterministic though due to the algorithms used. These numbers that are used by the seed produce a 'random' plot. If you have two seeds with the same number, they will be identical. Essentially, the seed is the ID/barcode of that specific plot and allows for the reproduction of that plot. 


   c) Edit the script to make a reproducible simulation of Brownian motion. Commit the file and push it to your forked `reproducible-research_homework` repo. (10 points) \
   d) Go to your commit history and click on the latest commit. Show the edit you made to the code in the comparison view (add this image to the **README.md** of the fork). (5 points) 
 <img width="1470" alt="Screenshot 2024-12-20 at 17 14 47" src="https://github.com/user-attachments/assets/e665f868-523d-43a0-b145-e0fbc88d9c53" />



6) (**30 points**) In 2014, Cui, Schlub and Holmes published an article in the *Journal of Virology* (doi: https://doi.org/10.1128/jvi.00362-14) showing that the size of viral particles, more specifically their volume, could be predicted from their genome size (length). They found that this relationship can be modelled using an allometric equation of the form **$`V = \alpha L^{\beta}`$**, where $`V`$ is the virion volume in nm<sup>3</sup> and $`L`$ is the genome length in nucleotides.

   a) Import the data for double-stranded DNA (dsDNA) viruses taken from the Supplementary Materials of the original paper into Posit Cloud (the csv file is in the `question-5-data` folder). How many rows and columns does the table have? (3 points)\

97 rows and 13 columns. However my code actually has 96 rows instead as i had to clean/delete the origninal columns of the file due to a formatting error.

   b) What transformation can you use to fit a linear model to the data? Apply the transformation. (3 points) \

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
   
   c) Find the exponent ($\beta$) and scaling factor ($\alpha$) of the allometric law for dsDNA viruses and write the p-values from the model you obtained, are they statistically significant? Compare the values you found to those shown in **Table 2** of the paper, did you find the same values? (10 points) \

Statistical significance
The exponent β and scaling factor α share a p value of 2e-16. This means that both are statistically significant. Therefore genome length is a reliable predicotr of virion volume. 

Exponent (β)-
The model that I created, when summarised, has an exponent (B) of 1.45339. this value is slightly lower than the dsDNA in the figure, which was 1.52. However, the result is still within the 95% confidence interval (1.16-1.87) and is quite close to the actual result.

Scaling Factor (α)-
Similarly, the scaling factor was also within the confidence interval for the figure. my model had a scaling fator of e7.57533 which is approximately 1943.6. The figure has a result of 6760 adn a 95% CI of (602–75,960).
Both results are within the range. Therefore my model is robust.

   d) Write the code to reproduce the figure shown below. (10 points) 

  <p align="center">
     <img src="https://github.com/josegabrielnb/reproducible-research_homework/blob/main/question-5-data/allometric_scaling.png" width="600" height="500">
  </p>

  ggplot(data_virus, aes(x = log_Genome_length_kb, y = log_Virion_volume)) +
  geom_point() +
  xlim(c(2, 8)) + 
  ylim(c(9, 20)) +
  geom_smooth(method = "lm", aes(group = 1), color = "blue", size = 0.7) +
  xlab("log [Genome length(kb)]") +
  ylab("log [Virion volume (nm3)]") +
  theme_bw()

  e) What is the estimated volume of a 300 kb dsDNA virus? (4 points) 

  log(V)=7.57533+1.45339×5.70378≈15.891

   𝑉=e15.891≈7965193 nm3
