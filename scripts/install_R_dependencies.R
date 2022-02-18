#-------------------------------------------------
# This script installs the necessary packages to
# run the non-ergodic GMM regression with INLA
#-------------------------------------------------

#install other packages
install.packages(c(
                   'sp',
                   'fields',
                   'viridisLite',
                   'stringr',
                   'assertthat',
                   'pracma',
                   'inlabru',
                   'posterior',
                   'ggplot2',
                   'maps'
                   ),
                 repos='https://cran.us.r-project.org'
)

#install INLA
options(timeout=800)
install.packages(
     "INLA", repos=c(getOption("repos"), INLA="https://inla.r-inla-download.org/R/stable"), dep=TRUE)

