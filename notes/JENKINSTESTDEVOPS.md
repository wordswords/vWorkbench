# DevTestOps and Jenkins

There is a lot involved with automating any complex test automation on Jenkins. It might
seem easy at first, but the main problem is that, as the complexity of your
Jenkins job grows, so does the difficulty maintaining it.

There are a few tips that have helped me.

* In the organisations I work in, we generally use a Jenkins agent running on some
kind of cloud container, e.g. Google Cloud.

* Docker is used to contain the application, and if you haven't already, you want
to make sure all your user-facing products are Dockerized wherever possible.

* You have lots of options with Jenkins in writing pipelines, but I would argue
only a few scale. The first is that you should NEVER define your pipeline
scripts on Jenkins itself. Infrastructure-as-code is the whole philosophy of
DevOps, and if you're not doing that, then you will run into a lot of problems.

* With Jenkins you define your "pipelines" in a `Jenkinsfile`. These outline a
number of steps you take, for example, spinning up the different parts of your
application in Docker containers before running tests against them.

* Jenkinsfiles are written in a fairly uncommon language called Groovy. I
recommend you use as little Groovy as possible in your Jenkinsfiles. It is a
very weird language and one I have never personally got on with. The Jenkins
implementation of it is not very good either.

* The problem with Jenkinsfiles is that you often have no way of testing whether
they work until you start a run in Jenkins. Jenkins does supply a linter, which
I highly suggest you use. There are several ways to enable it, but weirdly it
sits on the Jenkins server itself and you remotely connect to it and pipe your
Jenkinsfiles through to it, and it highlights any errors.

* If you are in DevOps, you will almost definitely know Bash. Bash is a horrible
language too, but I really suggest you use it for your Jenkinsfiles. It makes it
much easier to see what is going on in your infrastructure.

* If you are going to use Bash, I also highly recommend you use Shellcheck. You
can enable Shellcheck on Github actions for each of your repositories containing
bash scripts.

* I also recommend you use as little Bash in your Jenkinsfile as possible. The
bash you put in there should merely be enough to checkout a larger library of
bash files, and run them in each step.

* The reason for this is that Jenkins does some very weird things with inline
shell scripts and quoting, and you want to stay away from putting any complex
code in Jenkinsfiles if at all possible, because of the time cost in having to run
Jenkins pipelines just to test your code.

* For each stage, you can import a bash script, and call a bash function that does
everything necessary for this stage. With this approach, you can test the bash
functions independently of Jenkins and you can even get clever and write them in
TDD style if you wish, there are unit testing frameworks for Bash. You can also
reduce a lot of duplication in your Jenkinsfile which makes it much easier to
maintain.

* This speeds up development HUGELY as your Jenkins pipeline becomes more complex.
No longer do you have to rerun the pipeline, or even replay stages, to test new
amendments to your automation. You can just test them locally.

* I also recommend you setup a Github action to test the repository where your
tests and Jenkinsfile are sitting. So, on every PR that is made to merge into
the master/main for that repository, your Jenkins pipeline should be running
your tests to make sure they all work whenever anything changes. Using your
tests to test your tests. Sounds good right?

* Another thing is, always use `set -e` on the Bash scripts you're using for
automation. I KNOW this is not perfect. I know there are some weird edgecases
where `set -e` actually causes bugs. But it's the closest thing to error
checking that Bash has, and you definitely need it for your Bash scripts in
Jenkins, where a single mistake can cause you to have to wait for another 10+
minute run to complete. Also consider other Bash error trapping options, there
are a few.

* Whenever there is an error in any Bash script in your Jenkins job, the job
should terminate. That allows for quicker feedback that something needs to be
changed before the pipeline will run.

* As parameters for your Jenkins jobs, you should always allow whoever is running
your Jenkins job to specify parameters for each branch for any repositories that
are involved in your Jenkins job.

* Whenever you change anything in a Jenkinsfile or update your tests, you should
have an alternative "development" pipeline where can you test any changes necessary
to be made on a branch, and feed that branch name as a parameter into the
Jenkins job. That makes sure you don't disturb the 'live' Jenkins job which is
probably in use.

* Ideally you should have a way of replicating the entire Jenkins job locally.
For example, if your Jenkins job spins up docker containers containing your
infrastructure, and then spins up a docker container containing Cypress, and
runs Cypress against the full infrastructure for your company, then you should
have a way of replicating this locally in a bash script.

* This makes it much easier and faster as you can develop locally. This is why
Docker containers are so useful, and why every developer in your organisation
needs a fast laptop running Linux and a good internet connection.

* Bonus points if you can combine the two together - your local bash script, and the
bash scripts that are run in your Jenkins job. Then you remove another lot of
duplication and increase reliability.

* Use replays for your Jenkins jobs wherever possible, and also use your local
bash script, where you should be able to re-run certain 'stages' separate to
the others.

* Use timers a lot in your bash script. Time every task, using the UNIX time
system. This will allow you to try and optimise slow-running tasks. I also
recommend you set a time limit target for your Jenkins jobs, so for example,
tests run on merge to master through Jenkins only take 10 minutes maximum. You
can reduce the number of tests that you run, as well as look to optimise some of
the building of your applications, to aid this. Realistically you want to keep
the average time of your jobs down as much as possible, not just for your users,
but for effective maintenance.

* Always try and keep the versions of Jenkins, your test automation tool (such as
Cypress) and any other major components at the latest stable version. This will
ensure that your tests run as quickly as possible and as reliably as possible.

If you do all the above, then your Jenkins jobs will be much more maintainable and
your time spent maintaining them much less of a headache.



