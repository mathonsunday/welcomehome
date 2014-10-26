require 'spec_helper'

describe Home do
  let (:home) { Home.new }

  describe '#rated?' do
    let (:unrated_home) { Home.new }
    let (:rated_home)   { Homenew(upvote: 1) }

    specify { expect(rated_home.rated?).to be_truthy }
    specify { expect(unrated_home.rated?).to be_falsey }
  end

  describe '#rating_percentage' do
    context 'it returns the rating percentage' do
      it 'should return 0 when there are no votes' do
        expect(home.rating_percentage).to eq 0
      end

      it "should return zero if there are no upvotes" do
        expect(Home.new(upvote: 0, downvote: 1).rating_percentage).to eq 0
      end

      it "should return 50% if upvotes equal downvotes" do
        expect(Home.new(upvote: 1, downvote: 1).rating_percentage).to eq 50
      end

      it "should return 100% if there are upvotes and no downvotes" do
        expect(Home.new(upvote: 1, downvote: 0).rating_percentage).to eq 100
      end
    end
  end

  describe '#unisex?' do
    it { expect(Home.new.unisex?).to be false }
    it { expect(Home.new(unisex: true).unisex?).to be true }
  end

  describe '#accessible?' do
    it { expect(Home.new.accessible?).to be false }
    it { expect(Home.new(accessible: true).accessible?).to be true }
  end
end
