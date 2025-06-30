<h1>
  <picture>
    <source media="(prefers-color-scheme: light)" srcset="https://github.com/user-attachments/assets/15369987-a098-48d2-a9ca-301127a77e86">
    <source media="(prefers-color-scheme: dark)" srcset="https://github.com/user-attachments/assets/1be2dd40-8060-49ef-810c-576b4a1cefa7">
    <img alt="Newcomb" src="https://github.com/user-attachments/assets/15369987-a098-48d2-a9ca-301127a77e86" style="height:2em">
  </picture>
</h1>

Generate random numbers that adhere to [Benford's Law](http://en.wikipedia.org/wiki/Benford's_law)

[![Made by laserlemon](https://img.shields.io/badge/laser-lemon-fc0?style=flat-square)](https://github.com/laserlemon)
[![Gem version](https://img.shields.io/gem/v/newcomb?style=flat-square)](https://rubygems.org/gems/newcomb)
[![Build status](https://img.shields.io/github/actions/workflow/status/laserlemon/newcomb/test.yml?style=flat-square)](https://github.com/laserlemon/newcomb/actions/workflows/test.yml)

## Usage

Newcomb works very much like `Kernel.rand` or `SecureRandom.random_number`. In
order to fetch a random float between 0 (inclusive) and 1 (exclusive):

```ruby
Newcomb.random_number # => 0.49552091973604767
```

To fetch a random positive integer, provide the upper (exclusive) limit:

```ruby
Newcomb.random_number(100) # => 16
```

To fetch a random positive float, provide the upper (exclusive) limit as a float:

```ruby
Newcomb.random_number(100.0) # => 21.895884449446473
```

To fetch a random integer within a range, provide a range with integer endpoints:

```ruby
Newcomb.random_number(100..1000) # => 141
```

To fetch a random float within a range, provide a range with float (or mixed) endpoints:

```ruby
Newcomb.random_number(100.0..1000.0) # => 203.90587157406662
Newcomb.random_number(100..1000.0) # => 424.9768102233391
Newcomb.random_number(100.0..1000) # => 628.7978615329862
```

Over a sufficiently large sample size, the distribution of Newcomb's random
numbers will demonstrate Benford's Law.

## History

While Benford's Law is named after American scientist [Frank Benford](http://en.wikipedia.org/wiki/Frank_Benford),
the principle was original discovered by [Simon Newcomb](http://en.wikipedia.org/wiki/Simon_Newcomb)
over fifty years earlier. In addition to his numerous accomplishments in
mathematics and astronomy, Newcomb had a fantastic beard.

![Exhibit A](http://upload.wikimedia.org/wikipedia/commons/thumb/9/92/Simon_Newcomb_01.jpg/640px-Simon_Newcomb_01.jpg)
