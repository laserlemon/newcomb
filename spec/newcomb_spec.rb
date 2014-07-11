describe Newcomb do
  describe ".random_number" do
    let(:sample_size) { 1_000_000 }

    def assert_benford(&block)
      distribution = build_distribution(&block)

      expect(distribution.keys).to match_array([1, 2, 3, 4, 5, 6, 7, 8, 9])

      distribution.sort.each do |i, count|
        expect(distribution[i]).to be_within(tolerance(i)).of(expected_count(i))
      end
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

    # TODO: Update to assert adherence to within one standard deviation
    def tolerance(digit)
      (expected_count(digit) * 0.01).round
    end

    def expected_count(digit)
      (((Math.log(digit + 1) - Math.log(digit)) / Math.log(10)) * sample_size).round
    end

    context "when given no arguments" do
      it "falls between zero (inclusive) and one (exclusive)" do
        sample = build_sample { Newcomb.random_number }

        expect(sample.map(&:class).uniq).to eq([Float])
        expect(sample.map(&:floor).uniq).to eq([0])
      end

      it "is distributed according to Benford's law" do
        assert_benford do
          (Newcomb.random_number * 9).floor + 1
        end
      end
    end

    context "when given an argument" do
      it "falls between zero (inclusive) and the given number (exclusive)" do
        sample = sample_size.times.map { Newcomb.random_number(13) }

        expect(sample.map(&:class).uniq).to eq([Fixnum])
        floors = sample.map(&:floor)
        expect(floors.min).to be >= 0
        expect(floors.max).to be < 13
      end

      it "is distributed according to Benford's law" do
        assert_benford do
          Newcomb.random_number(9) + 1
        end
      end
    end
  end
end
