require 'spec_helper'

describe HomesController do
  it "should get index" do
    get :index
    expect(response).to be_success
  end
end
