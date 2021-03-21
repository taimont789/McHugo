# This script builds a PDF version of your CV and publication and experience
# pages compatible with Hugo Academic from the same file (optimized for the
# McHugo build)
#
# McHugo without the builder: https://github.com/evanjo/mchugo
# Original CV building script and inspiration: https://github.com/nstrayer/cv
#
# See readme for details

# You may need to run this if your googlesheets is private. A browser prompt
# should arise. You should only need to do this once every so often.
gs4_deauth()
gs4_auth()

# Change to where your googlesheets is
data_location = "https://docs.google.com/spreadsheets/d/11pLgd0LQSYeRmBUZkM2lLCJ3qii_kj7dr2Lf-71pLSM"

# Knit the PDF version to temporary html location
tmp_html_cv_loc <- fs::file_temp(ext = ".html")
rmarkdown::render("build/cv.rmd",
                  params = list(pdf_mode = TRUE,data_location = data_location),
                  output_file = tmp_html_cv_loc)

# Convert to PDF using Pagedown. Change output location below if necessary.
pagedown::chrome_print(input = tmp_html_cv_loc,
                       output = "static/files/John_Doe_CV.pdf")

# Output Hugo Publication and Experience pages. Note this will overwrite any
# files that are there.
source("build/build_hugo.R")
