FROM renra/elm:0.19.1-node14.15

ENV DIR /usr/src/app
RUN mkdir -p ${DIR}
WORKDIR ${DIR}

COPY elm.json elm.json

# A trick to satisfy the elm compiler with a minimal file
#  so that we can call `elm make` which downloads dependencies
RUN app=SimpleFrontendProject && \
  file=src/elm/${app}.elm && \
  mkdir -p src/elm && \
  echo "module ${app} exposing(..)" > ${file} && \
  echo 'greet = "Hi"' >> ${file} && \
  elm make ${file}

# Any change in the src folder invalidates the cache of this step
#  but the dependencies are still cached
COPY src src
