# Training Resources for Software Engineers in Test/QA Engineers

This is an heavily opinionated guide to what I personally think is important for new
SDETs/QA Engineers to learn and know. I have spent 17 years in the software
industry, and have experience in nearly all areas of software engineering,
including a large number of years as a 'pure' developer, several years
experience as an exploratory tester, several years experience in devops, and
experience managing testing teams and defining test strategies.

I have seen a huge amount of change in the area of QA, and read up on and
considered a lot of the different arguments of what QA engineers should do,
including the 'testers shouldn't code', 'developers shouldn't test' movement,
the devops movement, waterfall testing, the Agile movement, the BDD and TDD
movements, shift-left testing, the rise and then fall of the SDET role, and
its resurgence in demand today.

This is not to say that this guide would not be controversial to how a lot of
people see the skillsets required, including many 'industry experts'. There is
rarely 100% agreement on ANY topic in the software engineering world.

However, when looking at the current (June 2022) job descriptions for 'QA Engineers',
this guide is meant to help address the skillset gap in what the majority of employers
want in this role.

This is not meant to be 'gate-keeping' or scare people away, at all.
I want as many competent QA Engineers in the industry as possible. It's just a
summary of the skills you will have to learn if you want to do well in the
current market. It IS possible to learn a lot of these skills on the job,
and some employers will offer training, or at least leeway and space to get
your head around some of these things. Some will definitely not, however.

With that said..

## Rationale

I firmly believe that new QA engineers are going to have to learn how to code,
and code very well. Gone are the days where they can just be business
analysts/QA analysts/exploratory testers. Although they will need that skillset
too. It is a very harsh market out there and there are lots to learn.

I think the ideal starting QA Engineer will know at least a bit about:

* Fundamental computing skills and software engineering skills
* Exploratory testing
* Test design and planning and documentation
* Software development (to as equal standard to a 'normal' software engineer as possible!!)
* DevOps - scripting/virtualisation and containers/CI/automation/developer environment customisation
* Communication, soft skills and teamworking skills

This is a LOT of information to learn I know, but is why QA Engineers skilled in these areas are
commanding higher market values than 'standard' software engineers right now. I
would argue that QA Engineers require a MORE varied and technical skillset than
starting software engineers, whereas before they were seen as 'not as technical
as software engineers'. This change from the way things were in the past is difficult
to get your head around, I'm sure, but that's the way I see it.

The closer you can get to knowing these skillsets, the better off you are in
today's demanding market. This document is a collection of resources and advice
to help you grow in these areas.

## Study Skills and Learning to Learn

This guide is assuming that you are coming from a graduate perspective, ideally from a
computing subject, ideally from a good university. In your technical career, your success
will be defined by the speed you can teach yourself new technical concepts.

A computing degree from a demanding university DOES teach you to learn technical
information fast. It also teaches you good study skills. If you are NOT coming
from a graduate perspective, it really is worth investing some time in
developing your study skills, your reading speed and comprehension, your ability to filter
a lot of the useless information on the internet and locate the good stuff, and
the experience and confidence to do this fast and as a routine part of your day.

Everyone learns differently. It is important to find out the style of learning
that personally works best for you. For me, having come from an academic background
and a fan of books, technical books are the best and cheapest way I have found
of learning new concepts. Combined with taking good notes, creating side-projects
and actually implementing what you learn, this is the system that works best for
me.

But it might not for you. So take some time to figure out what type of learning
method works for you. For some people, online text based courses really help.
For others, YouTube videos. Some people simply don't really learn very well on
their own and should seek a mentor to pair program with. It is very important to
learn how you learn best, because although the information you need to know
won't change, the style you best absorb it is completely individual to you.

# Resources for the Skills Required of a QA Engineer

## Fundamental Computing Skill and Software Engineering skills

### Prior Training

There are things that a computing degree will teach you that you can definitely
learn yourself, in your own time. But you are going to have to learn them one
way or another. Things like basic programming, how computers work, concurrency,
how databases work, how the web works, technical communication skills including
writing and presenting information, the basics of complexity theory etc etc.

Some people will swear that you don't need those skills to get into computing.
Well, you may well find roles that will allow you to start without knowing these
things. But as you progress in your technical career then you will find yourself
learning these things, on the job, via trial and error. And that is not always a
fun situation to be in.

So if you have a choice, and not everyone does of course, then I really recommend
you go through some kind of prior training. If you cannot take a full computing
course, then some bootcamps are good at teaching the basics you need to know.
There are more free options than ever with MOOCs being very popular. You just
need time and discipline to go through them.

But of course, any degree, course or bootcamp will not teach you everything. Never
assume that. You're going to have to learn a LOT more than that.

### MIT's "The Missing Semester" Course

Once you have done your prior training from a course or bootcamp, I really
recommend this following course. MIT might be a scary name for some, but this
course really is excellent, and contains a LOT of information I really wished I
had learned earlier in my career. Take it at your own pace.

There are no time constraints to this course so you can take it in the evenings
while working, but there are so many essential skills here that you will have
to learn sooner or later, so it might as well be sooner.

https://missing.csail.mit.edu/

### ISTQB 'Fundementals' Course

Although the true usefulness of ISTQB's Fundementals testing course has been debated
for a long while, it is worth getting on your CV simply because a lot of job
descriptions of QA roles require it.

The syllabus changes all the time, but when I took the course in 2019, it seemed
to be a good introduction to a lot of the more traditional QA/exploratory testing
skills, with some useful information on communication and soft skills.

However it did not cover many software development technical subjects at all,
which I think has become increasingly important for any QA Engineer to know.
There are seperate specialist 'test automation' ISTQB courses but I haven't been
on any of those so cannot comment.

Often employers will consider sending you on this course for professional
development, so definitely push for it and go for it if they do, if only for the
value of it on your CV/resume.

# Exploratory testing

Exploratory testing remains a hugely important skill for any QA engineer. The
more exploratory testing you do, the better your attention to detail will
become, and the better your understanding of where bugs and problems in software
development arise from, and how to get a sense of where bugs might be hiding.

I would argue that you shouldn't see exploratory testing as just
something that you do on the graphical user interface to a product. You should
look at the product through any interface that the user of the product uses. So
for example, if the product is a C++ compiler, then you should exploratory test
using the command line C++ interface.

Software teams are only human, so often you will find that bugs come from
problems in communication in the software development process, for example,
misunderstood or miscommunicated requirements. Also you will find that the
pressure modern software teams are under to release software as fast as possible
contributes to cutting corners, and you should highlight this whenever it happens
(and it WILL happen). You will also see new, untrained or experienced but overloaded
software engineers being given too high expectations and be forced to work on
risky areas they really shouldn't be working on, and not being given enough
time to do a good job.  You will learn to expect bugs when these process problems
occur and know where to focus your testing for maximising quality.

You will learn to prioritise areas of the product which offer the highest
potential risk to the organisation if bugs were found there. This is called
risk-based testing. For example, if you only have a limited amount of time to
test a feature, and it includes changes to the payment system which the
organisation gets most of its revenue from, and also some UI layout changes, then
where should you focus your efforts on? The payment system of course. This is a
trivial example, but there will be much more complex situations you will be in
too. You are usually given much-less-than-ideal time frames to conduct your
exploratory testing, so the general skill of prioritisation is very important.

Part of exploratory testing is the skill in writing up the bugs to contain as
much useful information as possible to get them prioritised and fixed. This
includes being able to replicate them exactly on the different test environments
and having a basic understanding of how the code you are testing gets pulled into
each release that gets used by the users of your product. Without that
understanding you may not produce useful bug reports. The more information you
can give the developers to fix bugs quicker, the happier they will be.

The more time you spend exploratory testing and finding bugs, the greater your
understanding of the products you work on, becomes. As a QA engineer, you are
often expected to be the subject matter expert on the product from a users
perspective. The more exploratory testing and hands-on experience interacting
with the product you can do, the more that will be the case. And when you have
learned numerous products like this, the faster learning new products will become.

You will find it incredibly difficult trying to design effective automated tests
without the knowledge of the product, and without the insight into testing that
working in exploratory testing will give you. So there is no way to skip this
fundamental skill.
