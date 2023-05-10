# CI-CD Overview

## Learning Objectives
- Explain what CI (Continuous Integration) is
- Explain what CD (Continuous Delivery/Deployment) is
- Understand and get familiar with some real-world problems CI-CD solves
- Describe a CI-CD pipeline using a diagram

## What is CI?

### Practice: common CI steps in a real-world scenarios

You surely remember Albus, our new product owner. Together with Severus (our Tech Lead), they have collected some evidence based on feedback from different teams and departments in the company.

```
Sometimes, developers forget to run the tests for the application before shipping (deploying) a new release.
And we only realise once it's too late and the app is in production
```

```
When new developers are onboarding, they usually find it a bit difficult to navigate our codebase
for different reasons: different spacing in different Java classes,
unclear naming in some functions, not having a clear standard when writing code,
lines of code that are too long and, most worringly, leaving API keys commented out in some files
```

```
At the moment, there is no way to know when code is good to be merged against
the main branch on GitHub apart from manual code reviews from peers.
Could this be improved?
```

```
The cybersecurity team has raised a couple of times now that sometimes we use dependencies
that have vulnerabilities (ranging from low to extreme) in our codebase.
How do we spot these without asking devs to check each of them one by one?
```

In pairs, your task will be to come up with possible solutions that you would include as part of your CI job within your pipeline.
Create a [flowchart diagram](https://playground.diagram.codes/d/flowchart) to illustrate:

- what tasks your CI pipeline would perform,
- what would trigger these tasks to be run,
- in what order the tasks should run,
- what would happen when a check fails.

## What is CD?

### Practice: common CD steps in a real-world scenarios

Minerva, one of our business analysts has had some thoughts on some improvements that may be useful for the team and that right now make her daily job a bit hard. Could they be achieved?

```
Trying to allocate metrics to specific application versions
because she needs to match the metrics dates
and check when the different revisions of the application were deployed.
```

```
Sometimes she would like to have a play around with the application
before it's deployed in production, without impacting real customers.
How could this be done and how could CD be helpful?
```

## What is CI-CD?

### Practice: how would CI-CD help in these real-world scenarios?

```
A user has reported a bug which prevents a subset of users from completing tasks on your application.
You need to fix this fast otherwise you'll lose customers.
```

```
A competitor has just released a new version of their app.
Some of the new features are impressive and will likely cause users to switch from your app to theirs.
Luckily there are some tickets in your backlog for some similar features.
```

```
Your stakeholders have changed their mind about a specific feature and the dev team to change it right now.
```

### Core CI-CD concepts

There are entire companies that are devoted to building CI-CD tools and perfecting the process. So, needless to say, we could spend a long time thinking about this in quite some detail.

The most important thing right now is that you build a high level understanding of CI-CD. With that in mind, take a moment to distill what you've learned today into some core concepts.

### Resources
- [Continuous integration and continuous delivery](https://about.gitlab.com/topics/ci-cd/)
- [What is CI/CD?](https://www.redhat.com/en/topics/devops/what-is-ci-cd)
