# SYNOPSIS
Set up a docker image to run a shinyproxy server with a configuration set up at
runtime with environment variables to the container.


# EXAMPLES
    ## EX 1 - build and run the included basic-auth shinyproxy configuration
        #build the docker image, using the "default" configuration (currently basic auth)
        docker build . -t myshinyproxy-basicauth:latest

        # run the docker image, providing a spec for the config template to replace (this ex. uses the basic-auth config)
        vim mylocalspec.local # define what shinyapps you want to run... see github.com/openanalytics/shinyproxy-config-examples
        docker run -e REPLACE_PORT_NUMBER=8080 -e REPLACE_GUEST_PASSWORD="hello123" -e REPLACE_ADMIN_PASSWORD="my%stronger*password" -e REPLACE_SPEC_YML=$(cat mylocalspec.local) myshinyproxy-basicauth:latest


    ## EX 2 - build and run your own config
        # create a config template, then symlink, and build an image with that template
        vim ./config_templates/my-custom-config.local
        ln -s ./config_templates/my-custom-config.local ./config_templates/default.yml
        docker build . -t myshinyproxy-customconfig:latest

        # run the docker image, providing any parameters you defined in the config template
        docker run -e [...] myshinyproxy-customconfig:latest
