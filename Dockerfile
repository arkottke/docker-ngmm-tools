# https://jupyter-docker-stacks.readthedocs.io/en/latest/using/selecting.html
# Include Jupyter with support for Python and R

FROM jupyter/r-notebook:latest

USER root

# System dependencies
# ffmpeg for matplotlib anim & dvipng+cm-super for latex labels
RUN apt-get update --yes && \
	apt-get install --yes --no-install-recommends \
        ffmpeg dvipng cm-super vim && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

USER ${NB_UID}

# Install dependencies

# sp, rgdal, fields, viridisLite, stringr, assertthat, pracma, INLA, inlabru, posterior, ggplot2, maps
# Version of R limited to be less than 4.2 for INLA to work.
# pystan 3.4.is only supported from pip. Install version 2 from conda forge for testing purposes
RUN mamba install --quiet --yes \
        'gcc_linux-64' \
        'gxx_linux-64' \
        'arviz' \
        'joblib' \
        'matplotlib' \
        'numpy' \
        'nest-asyncio' \
        'pandas' \
        'scipy' \
        'r-essentials' \
        'r-base<4.2' \
        'r-rgeos' \
        'r-rgdal' \
        && \
    mamba clean --all -f -y && \
    conda run -n root pip install --no-cache-dir gdown pystan && \
    fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${NB_USER}"

# Install R dependencies
COPY scripts/install_R_dependencies.R "/home/${NB_USER}/"
RUN Rscript install_R_dependencies.R && rm install_R_dependencies.R

ADD https://api.github.com/repos/NHR3-UCLA/ngmm_tools/git/refs/heads/master /tmp/version.json
RUN cd /home/${NB_USER} && \
    git clone https://github.com/NHR3-UCLA/ngmm_tools ngmm_tools

# Import matplotlib the first time to build the font cache.
ENV XDG_CACHE_HOME="/home/${NB_USER}/.cache/"

RUN MPLBACKEND=Agg python -c "import matplotlib.pyplot" && \
    fix-permissions "/home/${NB_USER}"
