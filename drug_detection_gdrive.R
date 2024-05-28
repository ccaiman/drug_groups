library(tidyverse)
library(reshape2)

##added ability to pull drugbank info from a google sheet in drive 
##this was for user ability to add drugs of interest to the shared google sheet
library(googledrive)
library(xlsx)


# Access table from google drive ------------------------

#non-interactive google drive authentication for only
#ONE secret present in the .secrets folder
options(
  # whenever there is one account token found, use the cached token
  gargle_oauth_email = TRUE,
  # specify auth tokens should be stored in a hidden directory ".secrets"
  gargle_oauth_cache = ".secrets/"
)

drive_find(n_max = 5)

#path to the table to retrieve info (e.g.)
drive_download("~/drug_groups/drug_bank_choking.xlsx",
               overwrite = TRUE)

drug_bank_choking <- read.xlsx("drug_bank_choking.xlsx",
          sheetIndex = 1)

# drug detection algorithm -------------------------------

group_drugs <- function(x){
  
  if (length(expr(!!x)) == 1) {
    drugs <- str_split(expr(!!x), ", ", simplify = TRUE)
  } else {
    drugs <- expr(!!x)
  }
  
  ##detect if supplied drugs are in the drug bank
  drug_detect <- list()
  
  for (i in 1:length(drugs)) {
    drug_detect[[i]] <- head(drug_bank_choking[str_detect(drug_bank_choking$drug, regex(drugs[i], ignore_case = TRUE)),], 1) %>%
      mutate(input = as.character(drugs[i]))
  }
  
  
  drug_detect_tb <- melt(drug_detect)
  
  drug_detect_tb_g1 <- drug_detect_tb %>%
    filter(group == "1")
  
  if (nrow(drug_detect_tb_g1) < 1) {
    g1_name <- NA
  } else {
    drug_detect_tb_g1_name <- dcast(drug_detect_tb_g1, group~drug)
    
    drug_detect_tb_g1_name2 <- names(drug_detect_tb_g1_name)[-1]
    
    g1_name <- paste(noquote(drug_detect_tb_g1_name2), collapse = ", ")
  }
  
  
  
  drug_detect_tb_g2 <- drug_detect_tb %>%
    filter(group == "2")
  
  if (nrow(drug_detect_tb_g2) < 1) {
    g2_name <- NA
  } else {
    drug_detect_tb_g2_name <- dcast(drug_detect_tb_g2, group~drug)
    
    drug_detect_tb_g2_name2 <- as.vector(names(drug_detect_tb_g2_name)[-1])
    
    g2_name <- paste(noquote(drug_detect_tb_g2_name2), collapse = ", ")
  }
  
  
  drug_detect_tb_g3 <- drug_detect_tb %>%
    filter(group == "3")
  
  if (nrow(drug_detect_tb_g3) < 1) {
    g3_name <- NA
  } else {
    drug_detect_tb_g3_name <- dcast(drug_detect_tb_g3, group~drug)
    
    drug_detect_tb_g3_name2 <- as.vector(names(drug_detect_tb_g3_name)[-1])
    
    g3_name <- paste(noquote(drug_detect_tb_g3_name2), collapse = ", ")
  }
  
  
  drug_detect_tb_g4 <- drug_detect_tb %>%
    filter(group == "4")
  
  if (nrow(drug_detect_tb_g4) < 1) {
    g4_name <- NA
  } else {
    drug_detect_tb_g4_name <- dcast(drug_detect_tb_g4, group~drug)
    
    drug_detect_tb_g4_name2 <- as.vector(names(drug_detect_tb_g4_name)[-1])
    
    g4_name <- paste(noquote(drug_detect_tb_g4_name2), collapse = ", ")
  }
  
  
  
  drug_detect_tb_g5 <- drug_detect_tb %>%
    filter(group == "5")
  
  if (nrow(drug_detect_tb_g5) < 1) {
    g5_name <- NA
  } else {
    drug_detect_tb_g5_name <- dcast(drug_detect_tb_g5, group~drug)
    
    drug_detect_tb_g5_name2 <- as.vector(names(drug_detect_tb_g5_name)[-1])
    
    g5_name <- paste(noquote(drug_detect_tb_g5_name2), collapse = ", ")
    
  }
  
  
  dname <<- tribble(
    ~Group1, ~Group2, ~Group3, ~Group4, ~Group5,
    g1_name, g2_name, g3_name, g4_name, g5_name
  )
  
}


##this function works with wide (with commas) or long text list format
#group_drugs(dcn2)
#group_drugs(drugs$drug)

##the input style of the R Shiny app UI requires a csv (comma-separated) string of text

##detect if supplied drugs are in the drug bank
#str_detect(drug_bank_choking$drug, regex(drugs$drug[1], ignore_case = TRUE))

##use the logical to select for detected drugs
#drug_bank_choking[str_detect(drug_bank_choking$drug, regex(drugs$drug[4], ignore_case = TRUE)),]

##we really only want one item per drug entered
#head(drug_bank_choking[str_detect(drug_bank_choking$drug, regex(drugs$drug[4], ignore_case = TRUE)),], 1) 

##and we also only want to output the name of the input drug,
##because each input can be detected more than once and the detected name may be a derivative of
##actual one a person is taking. 
##we do this by including the input name and then casting along the input (the dcast() step)

#head(drug_bank_choking[str_detect(drug_bank_choking$drug, regex(drugs$drug[4], ignore_case = TRUE)),], 1) %>%
#mutate(input = as.character(drugs[i]))



