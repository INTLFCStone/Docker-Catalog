# thanks to openanalytics!
#
# https://github.com/openanalytics/shinyproxy-config-examples

FROM openjdk:8-jre

ENV SHINYPROXY_VER="2.0.1"
ENV SHINYPROXY_INSTALL_DIR="/opt/shinyproxy/"
ENV SHINYPROXY_DOCKER_CONFIG_FILE="${SHINYPROXY_INSTALL_DIR}application.yml"
ENV SHINYPROXY_DOCKER_CONFIG_FILE_TEMPLATE="${SHINYPROXY_INSTALL_DIR}application.yml.template"

RUN mkdir -p "${SHINYPROXY_INSTALL_DIR}"
RUN curl https://www.shinyproxy.io/downloads/shinyproxy-"${SHINYPROXY_VER}".jar -o "${SHINYPROXY_INSTALL_DIR}"/shinyproxy.jar

# set up configuration file for replacement on startup
WORKDIR "${SHINYPROXY_INSTALL_DIR}"
COPY ./config_templates/default.yml "${SHINYPROXY_DOCKER_CONFIG_FILE_TEMPLATE}"

# add our startup script
COPY ./start.sh "${SHINYPROXY_INSTALL_DIR}"

CMD ["sh", "-c", "${SHINYPROXY_INSTALL_DIR}start.sh"]
