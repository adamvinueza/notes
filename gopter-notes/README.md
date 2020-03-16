# Notes on property-based testing in Go with Gopter

## Property-based testing, and why I wrote this document

I'm new to property-based testing, and frankly had no idea what it was until I
read some blog posts by Jessica Kerr, in particular [this
one](https://blog.jessitron.com/2014/09/04/tdd-is-dead-long-live-tdd/). (She
also has an excellent talk about property-based testing
[here](https://www.youtube.com/watch?v=shngiiBfD80).)

The idea behind property-based testing is that you test a system not based on
whether it meets very specific criteria given ahead of the test in the form of
examples--this is example-based testing, which makes up most of what we consider
to be unit testing--but instead based on whether it satisfies specific
properties, properties that don't have to be precise at all. This kind of
testing is useful when you want to make sure your system works well under a
range of scenarios, for instance.

(**Don't worry, I'll get to Gopter soon! Hang in there for a few more
paragraphs!**)

As it happens, it also works really, really well when you want to test whether a
finite-state automaton accepts a language. This is because you can specify the
language using a property, and the property generates a whole bunch of arbitrary
data you can use to build your confidence that the automaton accepts all and
only sentences in the language. You can't exhaustively test an automaton for all
the sentences of most interesting languages, because most interesting languages
are infinite, and the set of sentences not accepted by an automaton are also
typically infinite. But it's still a good idea to have a lot of (random)
sentences in your language for testing, because then the automaton is working
with real data instead of the toy examples programmers usually think up when
hand-writing tests.

I mention finite-state automata because I decided a few weeks ago [to implement
finite-state automata in Go](https://github.com/adamvinueza/fsa), and to do so
using TDD principles--that is, I decided I'd write the tests _before_ writing
the critical code. Initially, I wrote vanilla example-based tests: make an
automaton that accepts only an even number of `a`'s, for example, then create
tests that say it should accept `aa` and `aaaaaa`, but not `aaa` or
`aaaaaaaaaaa`. How many tests do I need to be confident that my automaton works
as it should? Who knows? Just think up a bunch of edge cases and then throw in a
few robust examples for good measure.

After reading Jessica Kerr, however, I realized what I really wanted was to do
generate a bunch of random sentences, knowing ahead of time how to divide them
into the "automaton should accept" and "automaton should not accept" categories.
That way, the edge cases should come about fairly naturally, and I could easily
build confidence that the code works as it should by throwing a large volume of
generated sentences at it.

The most surprising thing about this was that when I converted my tests to using
a property-based framework, some of my converted tests _failed_, because my code
was in fact broken! That is, switching to property-based testing revealed bugs
in my code I probably wouldn't have discovered otherwise.

## Gopter: the Go property-based testing framework

I'll get to it shortly! For now I want to get this into the repository.

