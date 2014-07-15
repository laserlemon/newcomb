# Newcomb

Generate random numbers that adhere to [Benford's Law](http://en.wikipedia.org/wiki/Benford's_law)

[![Gem Version](https://img.shields.io/gem/v/newcomb.svg?style=flat)](http://rubygems.org/gems/newcomb)
[![Build Status](https://img.shields.io/travis/laserlemon/newcomb/master.svg?style=flat)](https://travis-ci.org/laserlemon/newcomb)
[![Code Climate](https://img.shields.io/codeclimate/github/laserlemon/newcomb.svg?style=flat)](https://codeclimate.com/github/laserlemon/newcomb)
[![Code Coverage](http://img.shields.io/codeclimate/coverage/github/laserlemon/newcomb.svg?style=flat)](https://codeclimate.com/github/laserlemon/newcomb)
[![Dependency Status](https://img.shields.io/gemnasium/laserlemon/newcomb.svg?style=flat)](https://gemnasium.com/laserlemon/newcomb)

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

Over a sufficiently large sample size, the distribution of Newcomb's random
numbers will demonstrate Benford's Law.

## History

While Benford's Law is named after American scientist [Frank Benford](http://en.wikipedia.org/wiki/Frank_Benford),
the principle was original discovered by [Simon Newcomb](http://en.wikipedia.org/wiki/Simon_Newcomb)
over fifty years earlier. In addition to his numerous accomplishments in
mathematics and astronomy, Newcomb had a fantastic beard.

![Exhibit A](http://upload.wikimedia.org/wikipedia/commons/thumb/9/92/Simon_Newcomb_01.jpg/640px-Simon_Newcomb_01.jpg)
