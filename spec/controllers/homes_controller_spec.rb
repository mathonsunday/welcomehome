require 'spec_helper'

describe HomesController do
  it "should get index" do
    get :index
    expect(response).to be_success
  end

  context "voting" do
    let(:home) { FactoryGirl.create(:home) }

    it "should downvote" do
      expect {
        post :update, id: home.id, home: { downvote: true }
      }.to change { home.reload.downvote }.by 1
    end

    it "should upvote" do
      expect {
        post :update, id: home.id, home: { upvote: true }
      }.to change { home.reload.upvote }.by 1
    end
  end
end
