Setup Node Service
=========

A role created to help learners to set up a service on Amazon Linux, specifically focused on using NodeJS

Requirements
------------

Node will need to be installed. You will probably wish to copy your project onto the target before running this role, as it will attempt to start the service

Role Variables
--------------

service_name - The name of the service in systemd
service_description - The description of the service in systemd
app_location - The location your executable has been deployed to (e.g. bin/www in your repo)
working_directory - The working directory for your service
mongodb_url - The URL to use to connect to MongoDB (This will be in the service's environment variables as MONGODB_URL)



Author Information
------------------

Alex Addison, Makers Academy
