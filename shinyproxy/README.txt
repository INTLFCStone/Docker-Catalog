# SYNOPSIS
Set up a docker image to run a shinyproxy server with a configuration set up at
runtime with environment variables to the container.

#DESCRIPTION
Why is setting up a shinyproxy so convoluted? Here's a generic "docker image factory"
to create shinyproxy images of varying types. Need a shinyproxy with OAuth? Spin one up
using a configuration file you specifiy, all the while keeping your secrets out of
version control AND your docker images! The infinite variety of configurations available
allow for easy integration with build pipelines as well. Feel free to push out a specifically
configured proxy based on environment variables. Enjoy!


# EXAMPLES
    ## EX 1 - Easy mode. Build and run the included basic-auth shinyproxy configuration
        # Build the docker image using the "default" configuration (currently basic auth)
        docker build . -t myshinyproxy-basicauth:latest

        # Create a "spec" component of the application.yml, which defines what app(s) this proxy
        # should run... see https://github.com/openanalytics/shinyproxy-config-examples/blob/master/02-containerized-docker-engine/application.yml
        vim mylocalspec.local

        # Run the docker image, providing all vars to replace in the config template... go crazy!
        # You're free to pull credentials from keyvaults, your own local environment variables,
        # or just plaintext strings (but make sure to clear your bash history!!)... You do you.
        docker run \
            -e REPLACE_PORT_NUMBER=8080 \
            -e REPLACE_GUEST_PASSWORD="hello123" \
            -e REPLACE_ADMIN_PASSWORD=$(curl www.myinternalkeyvault.com/my-secret-key.txt) \
            -e REPLACE_SPEC_YML=$(cat mylocalspec.local) \
            -t myshinyproxy-basicauth:latest


    ## EX 2 - Intermediate. Build and run your own config using BASH variable replacement
        # Create a config template, including ${MY_VAR?Variable is Required!} syntax for
        # substitutions. The "?" are not required, but ensure all your variables are defined
        # at runtime... the message after that symbol is the message displayed if not defined.
        vim ./config_templates/my-custom-config.local

        # symlink the config you created to "default.yml" - the configuration used by
        # the Dockerfile
        ln -s ./config_templates/my-custom-config.local ./config_templates/default.yml

        # build your custom image using the config you created
        docker build . -t myshinyproxy-customconfig:latest

        # instantiate the image, providing any parameters you defined in the config template
        docker run -e [...] myshinyproxy-customconfig:latest
