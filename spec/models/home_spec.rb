require 'spec_helper'

describe Home do
  let (:home) { Home.new }

  describe '#long_term?' do
    it { expect(Home.new.long_term?).to be false }
    it { expect(Home.new(long_term: true).long_term?).to be true }
  end

  describe '#family?' do
    it { expect(Home.new.family?).to be false }
    it { expect(Home.new(family: true).accessible?).to be true }
  end
end
