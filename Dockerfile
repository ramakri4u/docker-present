FROM node:9.5

# required packages
RUN apt-get update && apt-get -y install \
    bsdmainutils \
    tree

# docker
RUN curl -sSL https://get.docker.com | sh

# reveal.js
WORKDIR /opt/revealjs
RUN ln -s /usr/bin/nodejs /usr/bin/node
RUN git clone https://github.com/hakimel/reveal.js.git /opt/revealjs
RUN git clone https://github.com/denehyg/reveal.js-menu.git /opt/revealjs/plugin/menu
RUN npm cache clean --force && npm install

# setup
COPY present/present.py /opt/revealjs/
COPY present/css/docker.css /opt/revealjs/css/theme/
COPY present/css/docker-code.css /opt/revealjs/lib/css/
COPY present/css/sd_custom.css /opt/revealjs/css/
COPY present/css/print /opt/revealjs/css/print/
COPY present/fonts /opt/revealjs/fonts/
COPY present/images /opt/revealjs/images/
COPY present/templates /opt/revealjs/templates
COPY present/prompt.sh /bin/prompt

# default presentation repository
ADD presentations /opt/revealjs/src

ENTRYPOINT ["/bin/prompt"]
