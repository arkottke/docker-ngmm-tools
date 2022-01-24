# https://jupyter-docker-stacks.readthedocs.io/en/latest/using/selecting.html
# Include Jupyter with support for Python and R

FROM jupyter/r-notebook:latest

USER root

# System dependencies
# ffmpeg for matplotlib anim & dvipng+cm-super for latex labels
RUN apt-get update --yes && \
	apt-get install --yes --no-install-recommends \
        ffmpeg dvipng cm-super && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

USER ${NB_UID}

# Install dependencies

# sp, rgdal, fields, viridisLite, stringr, assertthat, pracma, INLA, inlabru, posterior, ggplot2, maps
RUN mamba install --quiet --yes \
        'arviz' \
        'joblib' \
        'matplotlib' \
        'numpy' \
        'pandas' \
        'pystan' \
        'scipy' \
        'r-inlabru' \
        'r-viridisLite' \
        'r-fields' \
        'r-stringr' \
        'r-assertthat' \
        'r-pracma' \
        'r-posterior' \
        'r-ggplot2' \
        && \
    mamba clean --all -f -y && \
    fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${NB_USER}"

# Install R dependencies

# Import matplotlib the first time to build the font cache.
ENV XDG_CACHE_HOME="/home/${NB_USER}/.cache/"

RUN MPLBACKEND=Agg python -c "import matplotlib.pyplot" && \
    fix-permissions "/home/${NB_USER}"

COPY NonErgModeling "/home/${NB_USER}/NonErgModeling"
