A brief guide to testing (properly)

# The rationale behind testing

Testing improves quality. But why do we care about quality?

1) Reduces the number of complaints by users and clients and improves satisfaction
with the product.
2) Improves the maintainability of the system, meaning that new features are implemented faster.
3) Improves the time estimates of new features because there are fewer problems
to navigate around and bugs to discover and have to fix.
4) Reduces the number of bugs that need to be fixed down the line, freeing up
more time to work on new features.
5) Makes it less likely for the company to be sued by preventable catastrophic problems.
6) Reduces the amount of 'hot fixing' or 'fixing on live' necessary, which is
usually not tested in itself, and can cause a lot of headache and out of hours
work.
7) Makes for a more happy software development team, good engineers don't want
to work on a buggy system with lots of problems. This makes it easier to recruit
good engineers and retain them.

# Initial challenges

## Psychological barriers in learning to test properly

One of the biggest myths in the software industry is that testing is not a
skilled career. Anyone CAN test, sure, but testing well takes knowledge
and practice, and that is not learned through normal software development.

This is actually a huge problem for the industry, as software managers will
recruit entry-level people who have no experience in testing, not train them at
all, and get them clicking around on a website, and call them a 'tester'.

Software developers generally think that testing is unintelligent grunt work.
Well it is, if you do it BADLY, just like someone writing 'Hello world' can
technically 'program'.

In this document I am going to try and teach the basics of what I have learned
about testing and improving quality. Anyone can wear the 'hat' of the tester and
apply this knowledge to test better.

## Psychological barriers in testing your own work

Developers should, of course, test your own work to the degree that you think it is
working and meets acceptance requirements. That is basic development.

But that is just the start of what tests should be applied to your work.

One of the main problems is that it is YOUR work that YOU have written, and you
have certain preconceived notions about how it works and how it should work.
You may have spent days on some particularly annoying code, and you don't want
to have to rewrite it.

You may also be particularly emotionally invested in the implementation or
design choices which might cloud your judgement looking at them objectively.

Even the most experienced, skilled, ego-less, professional and ethical developer
will be more protective about their own implementation than other peoples, and
can never be fully objective, even if they think they are being so.

So when we are talking about 'developers testing' - we are really talking about
developers testing other developers work, not their own. Testing skills that you
will learn will, as a side-effect, increase the quality of your own test on your
own work, but it is always important to have a second pair of eyes.

## The testing 'mindset'

When you are testing something properly, then you need to get into the testing 'mindset'.
You need to look at something very critically, and highlight all the potential problems in
it. When you are building software you are thinking 'creatively' and positively about how to
build something, to progress something. When you are in the testing mindset, you
want to find the weaknesses, the mistakes, all the little cracks. And you need
to tease and pry apart those cracks to find the bugs.

When developing something, you are trying to build it, when testing, you're trying
to destroy it.

# Testing strategies and concepts

## The testing pyramid

This shows how testing should be applied, ideally, in a project.

On the top level we have exploratory testing. This should be a tiny fraction of
the amount of testing that should be done in a project. The reasons for this is
because exploratory testing is very expensive and takes a lot of time.

On the second level we have UI tests. These are scripted, automated, UI tests
checking the features of the application. They should constitute a small amount
of the amount of testing that should be done in a project. The reasons for this
is that UI tests are expensive to write and maintain, and also to run. Tools for
this include Cypress and Rainforest.

On the third level we have API or integration tests. These explore the integrations
between the different components of the system, such as the frontend and
backend, usually using HTTP requests. These should constitute a medium amount of
the testing that should be done in a project. They are quick to write, and quick
to run. Tools for API testing include Postman.

On the fourth level, we have unit tests. These test 'atoms' of development code.
These should constitute the MAJORITY of the testing that should be done in a
project. They are written by developers and use unit tests frameworks. There are
unit test frameworks written for every language and stack out there.

## Shift-left Testing

With the whole industry moving to a much faster release cycle than was the case
10 years ago, and also the development of ideas such as continuous integration
and continuous delivery, there is a demand for testing, often seen as the
slowest part of the development cycle, to speed up.

Shift-left testing means moving the majority of the testing effort closer to the
time when the code is actually written, instead of having testing done by
manual 'acceptance checking' at the end of the process.

Often automation is the key to shift-left testing because automated tests can
execute tests much, much faster than manual testing.

## Risk-based Testing

All testing should be risk-based. What does that mean? Well, given the limited
budget for testing in all products, and the potentially almost infinite ways to
test a product, the areas which are tested should be prioritised according to
risk.

E.g. if you have 20 minutes to test a feature, and it includes a change to the
payment provider, and also some UI changes, which do you test first? Well if
anything went wrong with the payment provider, then that is a big problem for
this business. So you concentrate on the payment provider.

That was a trivial example. Most of the risk based analysis you will be doing is
not as cut-and-dry as this but nevertheless you have to be always conscious of
risk to the business from bugs in particular areas to know where to concentrate
your limited testing resources.

## It's "Quality Assistance" not "Quality Assurance"

It is impossible for a test or QA team to catch every bug before release, just
as it is impossible for developers to not create bugs.

There should never be the expectation that just because testing has not found a
bug, it is problem with the tester. Testers are not scapegoats.

It is a problem for the whole team, and for the whole team to solve holistically,
whether the solution involves better communication between product and the developers,
better coding standards for the developers, better automated tests etc etc.

## Testing is a WHOLE team process

Just as quality should be owned by the whole development team, from product to
developer, to DevOps to tester, testing should be too. There are no strict
distinctions any more between tester and developer anymore. Everyone is a tester.

# The different types of testing

## Black box testing

This is testing the outside interface of the feature you are testing. This may
be the UI of the feature, or the command line interface - anything which doesn't
involve the technical internals, and is designed to be operated by the
non-technical customer or user.

## White box testing

This is testing through reading the code, the pull requests, the technical
documentation, the database migrations, the API documentation. If you are a
technical tester, you can highlight problems in the implementation. This can be
very valuable, but it requires good technical skills.

## Acceptance testing

This is when you test that a developed feature works according to expectations.
To do this properly you need a good understanding of what the feature should
actually do. This ideally should be captured by product in user stories in JIRA,
detailing exactly what the acceptance requirements are, so there is no ambiguity
in meeting them by the development team, and testing them, by the tester.

Ideally this information should be captured in Gherkin language, which is a way
of expressing requirements exactly and succinctly so that every member of the
software team can clearly understand them, including test and product.

Another advantage of Gherkin language is that it is very straightforward to
turn this language into automated tests. In fact, Cucumber, which is an automated
test tool, can parse the Gherkin language, and you can use it to rapidly assert
whether a feature meets the requirements.

But even without planning to automate a feature, Gherkin is very useful because
it reduces ambiguity and increases accuracy in communicating the product requirements.

The quality of the acceptance testing will depend on the quality of the
communication of the exact requirements. The number of bugs found in acceptance
testing will also be reduced if the exact requirements are communicated well.

## Regression testing

Regression testing is checking that there are no 'regressions' e.g. problems
that occurred before, reappearing. It also checks that the previous functionality
of a system is maintained.

It is a key area for automated testing using UI and integration tests, because
there are simply too many features in a typical product to manually test them
all whenever a new feature is implemented, and it can slow down the entire
release process, especially for features that touch a lot of different areas of
the system.

When manually regression testing, it helps to know what areas a new feature
might touch in terms of what areas to concentrate your manual regression testing
time on, but really with several features in a release, you will have no idea
what combinations of interactions will cause which bugs, so it is much better
than, instead of presuming, to have a comprehensive set of regressions that check
everything possible.

## Exploratory testing

Separate from acceptance testing, this is actively exploring to find bugs outside
the acceptance requirements. This is usually done as black box testing, e.g. on
the UI level.

Exploratory testing is not just 'randomly clicking' - it is spending a set amount
of time to creatively explore the features of a product, and test different
scenarios which are designed to flush out the maximum amount of bugs in that time.

Usually you have a 'test charter' - a rough idea of which areas you are going to
focus your exploratory testing on, and you creatively explore around that test
charter in areas you feel will flush out the most bugs. Exploratory testing is
also usually timeboxed as in theory the amount you could test is infinite.

Exploratory testing requires thorough knowledge of the whole product and how
different areas fit together to do effectively.

There are a bunch of areas where application UIs often cause problems,
such as negative numbers in input boxes, or unicode characters in inputs boxes.

Boundaries between different technical systems are also areas to focus your
effort e.g. if a new UI feature has been deployed, has the backend system been
updated to match ALL the new possibilities it offers?

There are a lot of different things to be aware of, too many to list here, but
there is a good exploratory testing cheat sheet here and a browser plugin which
will help test common problems.

## Smoke testing

They are called smoke tests because you quickly scan the horizon for smoke to
see if your product is on fire.

They are a small set of automated tests that are usually run automatically
on merge-in, and additionally as often as possible.

They test the bare minimum expected functionality of the product. To use the
same analogy, just because you can't see any smoke doesn't mean your product
doesn't have problems.

## Automated UI testing

These are the tests written in Cypress, Selenium or many other frontend UI test
tools.

Typically, they are overused in products, even those with extensive UIs.

Why? Because a large UI test suite results in a lot of maintenance as they can
be brittle because they are linked to UI components that often change.

Also, it is not possible to write UI tests for every new feature in the sprint,
as writing UI tests takes time.

## Automated Integration testing

In integration testing we are testing the interaction or messages between the
different components of a distributed system. Often this is HTTP requests, but
it can be any kind of data transfer.

You can even test that the application generates particular SQL queries from the
results of a particular scenario.

Assertions can be made around the validation of these messages to make sure they
are properly formed.

You can also supply test fixtures which show expected behaviour, so you can send
them to a system and assert on the responses, or the expected resultant
behaviour on the UI.

## Unit testing

Developers may be familiar with this, and not realise that they are actually testing
while writing unit tests. They are. In fact, the majority of the testing of an
application should be done with unit tests.

Unit tests should cover an individual 'atom' of work. Often this correlates
with a particular function or method. So you should write one unit test for each
function or method.

A lot of unit testing done in the real world simply isn't done properly or
comprehensively enough. There should be code coverage metrics enabled on check-in
and on your IDE so you can see how much of your code is actually tested by your
unit tests. You should always submit code with tests, with a high code coverage.

There are unit test frameworks for all code. Part of the skill of unit testing
is knowing what to mock out and what not to. Traditionally it was tricky on the
frontend but modern frameworks such as React abstract away a lot of the
trickiness and allow for much more testable frontend code.

## Testing by monitoring

You can find problems simply by going through the logs of your system and
looking for problems.

If your logs are in a database, you can write reports using SQL to pick out
unexpected chains of user behaviour.

You can write certain 'watch' cases to alert you if there is an error with a
particular transaction or customer.

This way you can guage performance of a recently implemented feature. If there
are a lot of problems, you can revert to an earlier build.

## Static code analysis, linters and coding standards

You can fix a lot of problems by having a rigorous static code analysis 'gate'
executed on all PRs before they are merged in. This is a form of testing.

Static code analysis looks for common problems or weaknesses in the code and the
code quality which may result in bugs later on.

Strict coding standards enforced by linting is another good way to pickup
potential bugs before they become a problem.

## Testing on Live - A/B testing

You can use your users to test new features by measuring exactly what they do
when confronted with a new feature. You serve a portion of your audience the
site with the new feature, and track exactly what they do.

If there are problems detected by alerts or logs, you can automatically turn off
the new feature and serve the old build of the application to the customer.

This has the risk of losing a small portion of your customers because of errors,
but is also a good way to comprehensively test a new complex feature using
potentially thousands of unwitting customers as testers.





