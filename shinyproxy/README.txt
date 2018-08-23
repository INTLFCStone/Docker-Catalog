# SYNOPSIS
Create a shinyproxy image given a configuration that performs environment variable subsitution
at runtime in the application.yml file.

#DESCRIPTION
This project is a a generic "docker image factory" to create shinyproxy images of varying types.
Need a shinyproxy with OAuth? Spin one up using a configuration file you specifiy, all the while
keeping your secrets out of version control AND your docker images! The infinite variety of
configurations available allow for easy integration and reuse within build pipelines as well.

Enjoy!

# EXAMPLES
    ## EX 1 - Easy mode. Build and run the included basic-auth shinyproxy configuration
        # Build the docker image using the "default" configuration (currently basic auth)
        # NOTE: if this doesn't work, something might have murked the symlink. Try running
        #       cp ./config_templates/basic-auth.yml ./config_templates/default.yml
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
            -e REPLACE_ADMIN_PASSWORD="$(curl www.myinternalkeyvault.com/my-secret-key.txt)" \
            -e REPLACE_SPEC_YML="$(cat mylocalspec.local)" \
            myshinyproxy-basicauth:latest
            
        # congrats! You now have a working proxyserver using basic auth with `guest` and `admin` users!


    ## EX 2 - Intermediate. Build and run your own config using BASH variable replacement
        # Create a config template, including ${MY_VAR?Variable is Required!} syntax for
        # substitutions. The "?" are not required, but ensure all your variables are defined
        # at runtime...
        vim ./config_templates/my-custom-config.local

        # symlink the config you created to "default.yml" - the configuration used by
        # the Dockerfile
        # NOTE: I've had mixed results with `ln -s` -- you might have to overwrite with `cp ...`
        ln -s ./config_templates/my-custom-config.local ./config_templates/default.yml

        # build your custom image using the config you created
        docker build . -t myshinyproxy-customconfig:latest

        # instantiate the image, providing any parameters you defined in the config template
        docker run -e [...] myshinyproxy-customconfig:latest


# SPECIAL THANKS
Shout outs to OpenAnalytics for their Docker images on shinyproxy. I'd recommend checking out
their repos for a wider understanding of shinyproxy!
