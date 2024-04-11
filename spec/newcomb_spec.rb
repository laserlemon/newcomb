# frozen_string_literal: true

require "bigdecimal"

RSpec.describe Newcomb do
  describe ".random_number" do
    let(:sample_size) { 1_000_000 }

    # As predicted by Benford's law, and calculated as follows:
    #
    #   (Math.log(n + 1) - Math.log(n)) / Math.log(10)
    #
    let(:expected_distribution) do
      {
        1 => BigDecimal("0.301030"),
        2 => BigDecimal("0.176091"),
        3 => BigDecimal("0.124939"),
        4 => BigDecimal("0.096910"),
        5 => BigDecimal("0.079181"),
        6 => BigDecimal("0.066947"),
        7 => BigDecimal("0.057992"),
        8 => BigDecimal("0.051153"),
        9 => BigDecimal("0.045757"),
      }.transform_values { |p| (p * sample_size).round }
    end

    # Using a chi-squared goodness of fit test with nine categories (𝑘)
    # corresponding to the nine digits above (1-9), we have eight degrees of
    # freedom (𝑑𝑓 = 𝑘 - 1). Using a slightly conservative value for our
    # signficance level (α) of 0.01 (in order to reduce the number of false
    # positive test failures), we can use a chi-squared critical value table
    # to determine the appropriate critical value below.
    let(:critical_value) { BigDecimal("20.090235") }

    # To assert whether a distribution adheres to Benford's law, we build a
    # sufficiently large sample and perform a chi-squared test to determine
    # whether the observed distribution of first digits matches the expected
    # distribution to a statistically significant degree.
    def assert_benford(&block)
      distribution = build_distribution(&block)

      expect(distribution.keys).to match_array(expected_distribution.keys)

      chi_squared = distribution.sum do |digit, observed|
        expected = expected_distribution.fetch(digit)
        BigDecimal((observed - expected) ** 2) / expected
      end

      expect(chi_squared).to be < critical_value
    end

    def build_distribution(&block)
      sample_size.times.with_object({}) do |_, memo|
        digit = block.call
        memo[digit] ||= 0
        memo[digit] += 1
      end
    end

    def build_sample(&block)
      sample_size.times.map(&block)
    end

    context "when given no arguments" do
      it "falls between zero (inclusive) and one (exclusive)" do
        sample = build_sample { described_class.random_number }

        expect(sample.map(&:class).uniq).to eq([Float])
        expect(sample.map(&:floor).uniq).to eq([0])
      end

      it "is distributed according to Benford's law" do
        assert_benford do
          (described_class.random_number * 9).floor + 1
        end
      end
    end

    context "when given an integer argument" do
      it "falls between zero (inclusive) and the given number (exclusive)" do
        sample = build_sample { described_class.random_number(13) }

        expect(sample.map(&:class).uniq).to eq([Integer])
        expect(sample.min).to be >= 0
        expect(sample.max).to be < 13
      end

      it "is distributed according to Benford's law" do
        assert_benford do
          described_class.random_number(9) + 1
        end
      end
    end

    context "when given a float argument" do
      it "falls between zero (inclusive) and the given number (exclusive)" do
        sample = build_sample { described_class.random_number(13.4) }

        expect(sample.map(&:class).uniq).to eq([Float])
        expect(sample.min).to be >= 0.0
        expect(sample.max).to be < 13.4
      end

      it "is distributed according to Benford's law" do
        assert_benford do
          described_class.random_number(9.0).floor + 1
        end
      end
    end

    context "when given an integer range argument" do
      it "falls between the range minimum (inclusive) and its maximum (exclusive)" do
        sample = build_sample { described_class.random_number(13..26) }

        expect(sample.map(&:class).uniq).to eq([Integer])
        expect(sample.min).to be >= 13
        expect(sample.max).to be < 26
      end

      it "is distributed according to Benford's law" do
        assert_benford do
          described_class.random_number(10..19) - 9
        end
      end
    end

    context "when given a float range argument" do
      it "falls between the range minimum (inclusive) and its maximum (exclusive)" do
        sample = build_sample { described_class.random_number(13.4..26.7) }

        expect(sample.map(&:class).uniq).to eq([Float])
        expect(sample.min).to be >= 13.4
        expect(sample.max).to be < 26.7
      end

      it "is distributed according to Benford's law" do
        assert_benford do
          described_class.random_number(10.0..19.0).floor - 9
        end
      end
    end

    context "when given a mixed integer/float range argument" do
      it "falls between a float minimum and an integer maximum" do
        sample = build_sample { described_class.random_number(13.4..26) }

        expect(sample.map(&:class).uniq).to eq([Float])
        expect(sample.min).to be >= 13.4
        expect(sample.max).to be < 26
      end

      it "falls between an integer minimum and a float maximum" do
        sample = build_sample { described_class.random_number(13..26.7) }

        expect(sample.map(&:class).uniq).to eq([Float])
        expect(sample.min).to be >= 13
        expect(sample.max).to be < 26.7
      end

      it "is distributed according to Benford's law" do
        assert_benford do
          described_class.random_number(10.0..19).floor - 9
        end
      end
    end

    context "when given an invalid argument" do
      it "fails with an argument error when the argument is nonsensical" do
        invalid_arguments = ["a", "a".."z", /[a-z]/]

        invalid_arguments.each do |arg|
          expect { described_class.random_number(arg) }.to raise_error(ArgumentError)
          expect { SecureRandom.random_number(arg) }.to raise_error(ArgumentError)
        end
      end

      it "defaults to returning a float between 0 and 1 when the argument is semisensical" do
        almost_valid_arguments = [0, -1, -1.0, 2..0, 0.0..-2.0]

        almost_valid_arguments.each do |arg|
          expect(described_class.random_number(arg)).to be_between(0, 1)
          expect(SecureRandom.random_number(arg)).to be_between(0, 1)
        end
      end
    end
  end
end
