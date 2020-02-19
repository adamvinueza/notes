# Adam's notes on TDD

## Why this document

Maybe it would be nice to see people relatively new to TDD talk about how they
are thinking about it?

## TDD resources

[Robert C. Martin's famous TDD evangelism
post](http://butunclebob.com/ArticleS.UncleBob.TheThreeRulesOfTdd)
[James Shore's chapter on
TDD](https://www.jamesshore.com/Agile-Book/test_driven_development.html)
[Ian Cooper's clarifying TDD presentation](https://dave.cheney.net/2018/10/15/internets-of-interest-7-ian-cooper-on-test-driven-development)
[Michael Feather's talk on the nature of
testing](https://www.youtube.com/watch?v=gmasnR_Cml0)
[Jessica Kerr's post echoing Cooper's points](https://blog.jessitron.com/2014/09/04/tdd-is-dead-long-live-tdd/)

## My experiences with TDD

Since starting to work at Applied, I've done a few small independent projects 
(e.g., implementation of a finite-state machine, partial implementation of an
interpreter) and done some refactoring in the data analytics service using TDD
principles. There's a lot to like about TDD, but my experiences are a mixed bag.

### TDD evangelism is a bit much

I have complicated feelings about Robert ("Uncle Bob") Martin. He's a brilliant
programmer and an insightful writer, but he often comes off as overbearing and
hectoring in his writing and public speaking. (He's far from the only famous
person in the TDD world to come off that way--I'm looking at you, Martin
Fowler.)

The last thing an engineer under myriad pressures needs is some Famous Authority
Figure making her feel inadequate because she's not repeatedly writing functions
in teeny weeny bites between a bunch of tests, like a locust chewing through a
cornfield. The evangelism would benefit from a more nuanced view of how
engineers actually work and the actual pressures they're working under.

As a senior engineer, I ignore the hectoring and just take what I need from the
evangelists as I see the need to take it. So what I'd suggest to someone just
starting with TDD is: start small and modestly, and think of it as if you're
just fooling around. (Now that I'm thinking about it, writing code as if you're
just fooling around could be done a whole lot more in general.)

### Testing below the level of an API is cumbersome

Trying to write a test for every function, or every class, is a pain. I often
didn't know what I wanted my code to look like, and designing it via testing
felt absurd a lot of the time. Sometimes it's OK to just write a simple
function, or a simple class!

The rule to write no production code without a failing test doesn't adequately
specify how you're supposed to work, I think. If you have a complex piece of
code with a lot of moving parts, having to write tests for every bit of it seems
absurd; what matters is that the public-facing parts of the code work as
intended. So I'd change the rule to something like this:
```
Write no production public API function without a failing test.
```
This is one of the key points in Ian Cooper's and Jessica Kerr's remarks.

### The (API-level) test should read a lot like a specification

Engineers are notorious for not reading documentation. They tend to feel it's a
waste of time, and read only enough to get them started. Engineers generally
prefer to learn how an application works by reading its code. And usually the
first question the engineer asks about a function or class or API is: what is it
supposed to do?

The tests of a function, if it's written well, should set out clearly and simply
what the function is supposed to do. So if you read the tests (and the tests
_should be readable_), you will come to know how the function is supposed to
behave. This knowledge makes it much easier for you to debug the function, to
write more tests against it, to extend it, and to maintain it.

### Writing test code is a way of coming to understand your API

Good tests cover what's reasonable to expect from a bit of code. Sussing that
out can be difficult, but at bottom it's indistinguishable from thinking deeply
about what your code is supposed to do. And if you write those tests first,
you're essentially designing the API from an engineer's perspective.

### The real value of TDD is confidence in your code

If I had to explain what causes a bad codebase to be bad to a non-technical
person, I'd say this: a codebase becomes bad from a long period of engineers
feeding it code in which they have little or no confidence.

We've all seen this scenario play out more than once. First, a function or class
or module is added without proper testing; it gets eyeballed and judged to be
fine. This happens a lot over the course of several months or years, and the
problems that arise are fixed through hastily written and half-thought-through
patches that are again eyeballed and judged to be fine.  Eventually you have a
code base that hardly anyone understands. This means that it takes forever to
figure out how to debug it, or change it, or test it. This leads to a situation
in which the engineers simply stop caring whether the code works properly--they
see their job as simply keeping the application alive, and the thought of making
the code better is utterly dispiriting.

There are lots of good ways of avoiding this situation--we're talking about an
organizational problem, not an individual one. But I've found that a big benefit
of writing tests at the API level _before_ implementing the API functions is
that when I'm done with the functions, I have very, very strong confidence that
the code works. Moreover, anyone working with my code after that should be able
to build strong confidence that it works, because they can read the tests!

A team of engineers building an application while writing code the engineers
have confidence in will build an application they're confident works. An
organization with teams of engineers building application they're confident in
will trust the engineers to build applications, and to take greater risks.
