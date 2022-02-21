#-------------------------------------------------
# This script installs the necessary packages to
# run the non-ergodic GMM regression with INLA
#-------------------------------------------------

repos = getOption('repos')
repos['CRAN'] <- 'https://cran.us.r-project.org'
repos['INLA'] <- 'https://inla.r-inla-download.org/R/stable'
options(repos=repos, timeout=800)

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
                   'maps',
                   'INLA'
                   ),
                 dependencies=TRUE
)
