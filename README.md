# drug_groups

Author: Charles C Barnes

Institution: State of Tennessee - Department of Disability and Aging (DDA)

Role: Volunteer Data Specialist

## Summary
This repo is of an R shiny app for grouping drug names into categories.

## Motivation
The therapeutic services team for the Department of Disability and Aging (DDA) in the East region of TN keeps track of drugs that make people vulnerable to [choking](https://xavier.org.au/resources/news/2022/april/236/medications_associated_with_swallowing_and_choking_risks). Whenever there is a reportable event, a team member will scan a list of drugs and a person's prescribed medicines to identify risky drugs for the report. To save time and effort of the team members, I developed this app to output sorted drug names from a comma-separated input.

The team will find newer drugs that match risk descriptions and then add these drugs to a group in the list. I made a drug bank in Google Sheets so the team can modify the list and the app will pull the drug bank from google sheets each time the app is opened.

## Requirements
In addition to having R and R Stuido installed, you will need:
1. A drug bank in google sheets with drug name and its group.
2. A secret token (steps in `gdrive_project_init.R`).

## Contact
If you have questions about the repo, contact me (Charles) at barnes225@gmail.com
