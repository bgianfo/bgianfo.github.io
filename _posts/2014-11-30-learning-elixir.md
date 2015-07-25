---
layout: post
title: "Learning Elixir"
excerpt: "We attempt to start learning the  elixir language."
tags: ["software", "elixir", "programming languages"]
comments: true
---

<!-- The Sources -->
[home]: http://elixir-lang.org
[list-docs]: http://elixir-lang.org/getting_started/2.html#2.6-(linked)-lists
[enumerable-docs]: http://elixir-lang.org/getting_started/10.html
[beam-docs]: http://www.erlang.org/faq/implementations.html#idp32748048
[wiki-source]: https://en.wikipedia.org/wiki/Elixir_(programming_language)
[ex-inst]: http://elixir-lang.org/install.htm-lang.org
[pjeu]: https://projecteuler.net
[getting-started]: http://elixir-lang.org/getting_started/1.html
[30-days]: https://github.com/seven1m/30-days-of-elixir
[learnx]: http://learnxinyminutes.com/docs/elixir/
[cheatsheet]: http://media.pragprog.com/titles/elixir/ElixirCheat.pdf
[howistart]: https://howistart.org/posts/elixir/1

##Intro##
Elixir has been on my radar for about a year now, however despite my best effort I haven't had a chance to take a thorough look yet.
I decided I've been waiting long enough, I just need to sit down and try to hack out some code.
If you haven't looked into the language yet it appears [very cool on paper][wiki-source]:

> Elixir is a functional, concurrent, general-purpose programming language built atop the
> [Erlang Virtual Machine][beam-docs] (BEAM). Elixir builds on top of Erlang to provide distributed,
> fault-tolerant, soft real-time, non-stop applications but also extends it to support 
> metaprogramming with macros and polymorphism via protocols.

Installation was super easy, just head over to the [install][ex-inst] page on [http://elixir-lang.org](http://elixir-lang.org).
The windows web installer will download and install everything you need, a totally seamless experience.

I have a little bit of familiarity with Erlang, but besides that this is the first time
I've actually looked into the Elixir syntax. So the rest of this post will be entirely,
unfiltered stream of consciousness.

##Trying Out Some Code##
Lets see if we can use Elixir to solve the first problem on the [Project Euler][pjeu] site.

> **Multiples of 3 and 5**:
> If we list all the natural numbers below 10 that are multiples of 3 or 5, we get 3, 5, 6 and 9. The sum of these multiples is 23.
> Find the sum of all the multiples of 3 or 5 below 1000.

First lets try to fire up the REPL, I think I remember front page mentioning it was called **iex**.

{% highlight tcsh tabsize=4 %}
$ iex
Interactive Elixir (1.0.2) - press Ctrl+C to exit (type h() ENTER for help)
iex(1)>
{% endhighlight %}

Great, so lets try to start working on the problem.
Seems like we can naively solve this by traversing a list,
lets see if we can figure out the syntax for that.
Maybe it's like Haskell? [1..10.]

{% highlight tcsh tabsize=4 %}
iex(1)> [1...1000]
** (SyntaxError) iex:2: syntax error before: '...'
{% endhighlight %}

Hrmm... that didn't work.
Maybe lets try dropping the brackets?
I think i vaguely remember Erlang only using two dots in the notation?

{% highlight tcsh tabsize=4 %}
iex(1)> 1 .. 1000
1..1000
{% endhighlight %}

That looks like it could be a representation of a list!
I wonder how we could take the head it?

Lets try just a function?
{% highlight tcsh tabsize=4 %}
iex(2)> head(1 .. 1000)
** (RuntimeError) undefined function: head/1
{% endhighlight %}

Maybe it's prolog/erlang style, using the symbolic syntax?
{% highlight tcsh tabsize=4 %}
iex(3)> x = 1 .. 1000
1..1000
iex(4)> x
1..1000
iex(5)> [y|z] = x
** (MatchError) no match of right hand side value: 1..1000
{% endhighlight %}

Looks like that's not right... something seems off I thought that would work...
It seems like the language is probably erlang with some syntax.
I vaguely remember the head function in erlang being hd/1,
let's try that on our list.

{% highlight tcsh tabsize=4 %}
iex(5)> hd
** (RuntimeError) undefined function: hd/0

iex(5)> hd(x)
** (ArgumentError) argument error
    :erlang.hd(1..1000)
iex(5)> [x]
[1..1000]

iex(6)> head([x])
** (RuntimeError) undefined function: head/1

iex(6)> hd([x])
1..1000

iex(7)> hd([1 .. 2])
1..2
{% endhighlight %}

Hrm... it seems like the 1..1000 syntax doesn't create a list, maybe it's a symbol?
Time to go read the docs ...

So after reading the [docs][list-docs] for lists it seems like, the
bracket syntax is correct. hd/1 is head as we thought and tl/1b is tail.
However they don't seem to cover the range syntax on that page. Need to
dig in to the docs a little bit more I guess, maybe there is no range syntax?

Ahha! It looks like on [this page][enumerable-docs] that we were actually kind of 
correct. 1..1000 seems to represent a lazy range, not a list. So we need to use functions
to operate on top of the lazy range.

Looks like there is a Stream package for lazy sequences, which has map/filter:
{% highlight tcsh tabsize=4 %}
iex(8)> 1..1000 |> Stream.filter
** (UndefinedFunctionError) undefined function: Stream.filter/1
    (elixir) Stream.filter(1..1000)
{% endhighlight %}

Need to figure out how to write a lambda, lets try to filter out odd numbers..
one of the map examples in the docs page uses this syntax:

{% highlight elixir tabsize=4 %}
    fn x -> x*2 end
{% endhighlight %}

Seems to make sense, lets try it out.

{% highlight tcsh tabsize=4 %}
iex(8)> 1..1000 |> Stream.filter(fn x -> rem(x,2 == 0) end)
** (ArithmeticError) bad argument in arithmetic expression
             :erlang.rem(1, false)
    (elixir) lib/enum.ex:666: anonymous fn/3 in Enum.filter/2
    (elixir) lib/range.ex:77: Enumerable.Range.reduce/6
    (elixir) lib/enum.ex:666: Enum.filter/2
{% endhighlight %}

I would have thought that would have worked... wait the parenthesis don't look right.
I forgot to properly close the rem(..)!

{% highlight tcsh tabsize=4 %}
iex(8)> 1..1000 |> Stream.filter(fn x -> rem(x,2) == 0 end)
[2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42,
 44, 46, 48, 50, 52, 54, 56, 58, 60, 62, 64, 66, 68, 70, 72, 74, 76, 78, 80, 82,
 84, 86, 88, 90, 92, 94, 96, 98, 100, ...]
{% endhighlight %}

cool.

I think I saw a Enum.sum function as well, putting all the pieces of the question together
we get a nice one liner.

{% highlight tcsh tabsize=4 %}
iex(12)> multiples = fn x -> rem(x,3) == 0 || rem(x,5) == 0 end
#Function<6.90072148/1 in :erl_eval.expr/5>
iex(13)> 1..999 |> Stream.filter(multiples) |> Enum.sum
<redacted-from-article>
{% endhighlight %}

That wasn't so bad, I like the pipelining syntax. It seems similar to the syntax used in ML based language, like F#/OCaml.

## Resources ##
If you are on board with Elixir and want to continue on your own Elixir journey there are a couple of really great resources
to continue exploring the language.

- [How I Start: Elixir][howistart]
- Elixir-Lang Getting Started [Tutorial][getting-started]
- The 30 Days of Elixir [Repository][30-days]
- Learning X in Y Minutes: [Where X = Elixir][learnx] 
- The [Elixir Cheat Sheet][cheatsheet]

