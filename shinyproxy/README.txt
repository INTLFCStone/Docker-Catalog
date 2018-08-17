# SYNOPSIS
Set up a docker image to run a shinyproxy server with a provided configuration.


# EXAMPLE CONFIGURATION

#build the docker image, using the (current) default of basic authentication
docker build . -t myshinyproxy-basicauth:latest

# OR -- build your own config, then symlink, and build an image with that config file
vim ./config_templates/my-custom-config.local
ln -s ./config_templates/my-custom-config.local ./config_templates/default.yml
docker build . -t myshinyproxy-customconfig:latest

# run the docker image, providing a spec for the config template to replace (this ex. uses the basic-auth config)
docker run -e REPLACE_PORT_NUMBER=8080 -e REPLACE_GUEST_PASSWORD="hello123" -e REPLACE_ADMIN_PASSWORD="my%stronger*password" -e REPLACE_SPEC_YML=$(cat mylocalspec.local) myshinyproxy-basicauth:latest
