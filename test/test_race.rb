require "minitest/autorun"
require_relative "../lib/race.rb"

describe Race do
  MAX = 4
  before do
    @race = Race.new(MAX)
  end

  describe "when number of laps is less than #{MAX}" do
    it "is not finished yet`" do
      @race.update_grid(3)
      assert_equal false, @race.finished?
    end
  end
end
