#run this script exactly ONCE to initialize the project with google drive
#more info at this link
#https://gargle.r-lib.org/articles/non-interactive-auth.html#sidebar-1-deployment

library(googledrive)

#create subdirectory for secrets
dir.create(file.path("drug_groups", ".secrets"))

# designate project-specific cache
options(gargle_oauth_cache = ".secrets")

# trigger auth on purpose --> store a token in the specified cache
drive_auth()
