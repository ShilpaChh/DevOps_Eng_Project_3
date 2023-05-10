# Continuous Deployment (CD) to Amazon Web Services (AWS) using GitLab CI/CD 

So far, you have successfully created a Continuous Integration (CI) job on your GitLab CI/CD workflow, great job!
Now, every time your main branch is updated, a new build will be triggered and some checks will be run automatically and you will be able to see the outcome
of your new additions to your codebase on the Actions tab of your repository. How convenient!

Now, there are some things we need to work on in order to set up a CD job to deploy our application to an EC2 instance on AWS.

However, before we dive into CD itself, let's diagram!

:pencil2: In your groups, diagram the desired flow starting from your GitLab repository (once some new code is merged against main) up to be deployed on AWS.
Make sure to include some keywords describing what each of the following services is responsible for: GitLab CI/CD, AWS S3 Bucket, AWS CodeDeploy, AWS EC2.

Now that we have a general idea of what we are trying to do and how, let's get hands-on!

## Create S3 Bucket

Now we need a place to store our application revisions just before they are deployed into an EC2 instance. The AWS S3 Bucket is a great option for that.

From the AWS Console, navigate to S3 and then click Create bucket. Give it a good identifier as a name and block all public access, this bucket will only be used
for internal purposes to keep the revisions.

## Create an EC2 instance

Now we are going to spin up a new EC2 instance to be able to deploy our application and see it live!

Navigate to `EC2` on the AWS Console and click on `Launch Instance`, then mark the `Free Tier` checkbox as checked and select this one: `Amazon Linux 2 AMI (HVM), SSD Volume Type`
Select the Free Tier Eligible type and proceed to `Configure Instance Details`.

Now, the most important field in this section is `IAM Role`, this should be the instance role identifier provided by your coach, select that value.

At the end of the page, we will paste this code in the text area (User data):
```
#!/bin/bash
yum -y update
yum install -y ruby
yum install -y aws-cli
aws s3 cp s3://aws-codedeploy-eu-west-2/latest/install . --region eu-west-2
chmod +x ./install
./install auto
```

This is the script our EC2 instance will run at launch time.

Discuss with your group what you think this script is doing.

In the `Tags` section, discuss and come up with a descriptive key-value pair that identifies your instance, you will need to use this pair later on.

Finally, before launching the instance, a pop up will prompt asking you to create a new key pair or select an existing one. 
Read through the instructions and once you are done, create a new key pair. 
Hopefully after doing some research around the EC2 dashboard, and making use of your `.pem` file, you can securily `ssh` into your EC2 instance from your Mac.

## Set up CodeDeploy

Finally, let's set up the missing piece in the middle that connects the S3 bucket revision with the EC2 instance.

However, before setting up CodeDeploy, let's make sure we have the CodeDeploy agent up and running on our EC2 instance. SSH into your EC2 instance and run `sudo service codedeploy-agent status`.

What is the output that you are getting telling you?

After we are sure the CodeDeploy agent is running on our EC2 instance, it's time to configure CodeDeploy on AWS.
On the AWS Console, navigate to `CodeDeploy` -> `Applications`, then:

1. `Create Application`: give it a descriptive name including your group name and application name and select `EC2/On-premises`

Note: you will need to use the app name identifier later on when working on your deployment settings on the CD workflow for GitHub Actions.

[//]: # (TODO: Double check whether the above is true for GitLab)

2. Click on the application you just created and `Create deployment group` and choose a descriptive name, for example `production`

Think of a Deployment Group as the instance(s) where we'd like to target and deploy our code

3. In the `Service Role` section, select the role that was facilitated by your coach for the CodeDeploy service, similarly as you did before for the EC2 profile instance role

4. In `Deployment Type` select `In place` for the purpose of this project

5. In `Environment Configuration` select `Amazon EC2 instances` and use the key-value pair tag that you created when launching your instance,
as mentioned in the previous section, this is when you need it! 

Basically, CodeDeploy needs to identify where to deploy your code into when you start a deployment from GitLab CI/CD later on.

6. Finally, deselect the Load Balancer and create the deployment group


## Set up a GitLab CI/CD User on AWS

We need to set a special user to do all the hard work for us.
This user will take our application code through a journey and with interact with AWS to ultimately bring it live on the web!

On the AWS console, go to `Services` -> `Identity and Access Management (IAM)`. 
You will then need to create a new User with programmatic access and some policies (permissions).

In order to determine which policies this user needs, according to the diagram you just worked on with your group,
what service(s) do GitLab CI/CD need to interact with?

<details>
  <summary markdown="span"> :star: <b>Thought about it? Click me for the answer!</b></summary>
  
  The answer is two of them. The user for GitLab CI/CD is in charge of pushing the application revision we want to    deploy to an S3 Bucket, and then it will trigger the deployment of such revision to be handled by CodeDeploy.

The policies we need to add to the user are: `AmazonS3FullAccess` and `AWSCodeDeployFullAccess`.

:rotating_light: IMPORTANT: once you create the user, remember to save the credentials that appear with the confirmation message in a safe place, you will need them later.
</details>

## GitLab project repository

We are almost at the end of this walkthrough. So far, you managed to get your AWS environment fully set up,
and now you will need to work on your GitLab repository to make sure it is properly hooked and integrated with your AWS services.

You have a main task to do now: **Setting the CD job in the existing workflow**.

Think about which steps are needed as per the diagram you created and what you know now after following this tutorial.
- What should happen after the CI job passes with a green tick?
- Where will the application revision be stored?
- Which service will deploy it to the EC2 instance and where will it find it?

Some of the resources listed on this file may be useful!

Finally, remember that when you created the user on AWS for GitLab CI/CD, you were given some credentials.
You'll have to somehow make them available to your GitLab CI/CD pipeline so that it's allowed to connect with AWS.
Can you remember how?
It might help to refer back to last week's project!

## Resources

- [Connect to your EC2 instance](https://docs.aws.amazon.com/quickstarts/latest/vmlaunch/step-2-connect-to-instance.html#sshclient)
- [Get Started with GitLab CI/CD](https://docs.gitlab.com/ee/ci/quick_start/)
- [Cloud Deployment with GitLab](https://docs.gitlab.com/ee/ci/cloud_deployment/)
