require 'spec_helper'

describe 'Homes API' do
  it 'sends a list of homes order by date descending' do
    FactoryGirl.create_list(:home, 15)

    get '/api/v1/homes'
    expect(response).to be_success

    json = JSON.parse(response.body)
    previous_record = nil
    json.each do |rest_json|
      home = Home.find(rest_json['id'])
      expect(home.valid?).to be true
      if previous_record.present?
        expect(home.created_at).to be >= previous_record.created_at
      end
    end
  end

  it 'paginates list of homes by 10 results' do
    FactoryGirl.create_list(:home, 15)

    get '/api/v1/homes'
    expect(response).to be_success

    json = JSON.parse(response.body)
    expect(json.length).to eq(10)

    expect(response.header['X-Per-Page']).to eq('10')
    expect(response.header['X-Page']).to eq('1')
    expect(response.header['X-Total-Pages']).to eq('2')
    expect(response.header['X-Total']).to eq('15')
  end

  context 'filters' do
    before :each do
      FactoryGirl.create_list(:home, 5)
      FactoryGirl.create_list(:family_home, 5)
      FactoryGirl.create_list(:long_term_home, 5)
      FactoryGirl.create_list(:family_and_long_term_home, 5)
    end

    let(:json) { JSON.parse(response.body) }

    context 'a list of family homes' do
      before :each do
        get '/api/v1/homes', { family: true }
      end

      it "is successful" do
        expect(response).to be_success
      end

      it "returns family restrooms" do
        expect(json.select { |home| home["family"] }.count).to eq 10
      end

      it "does not return non-family  homes" do
        expect(json.reject { |home| home["family"] }.count).to eq 0
      end
    end

    context 'a list of long term homes' do
      before :each do
        get '/api/v1/homes', { long_term: true }
      end

      it "is successful" do
        expect(response).to be_success
      end

      it "returns long term homes" do
        expect(json.select { |home| home["long_term"] }.count).to eq 10
      end

      it "does not return short term homes" do
        expect(json.reject { |home| home["long_term"] }.count).to eq 0
      end
    end
  end

  it 'full-text searches a list of homes' do
    FactoryGirl.create(:home)
    FactoryGirl.create(:home, name: 'Frankie\'s Coffee Shop')
    FactoryGirl.create(:home, name: 'Hipster Coffee Shop')
    FactoryGirl.create(:home, name: 'Organic Co. Coffee', comment: 'Pretty tile.')

    get '/api/v1/homes/search', { query: 'Coffee Shop' }
    json = JSON.parse(response.body)
    expect(json.length).to eq(2)
    json.each do |home|
      expect(json[0]['name']).to match(/Coffee Shop/)
    end

    # Tests the full-text unaccent extensions
    get '/api/v1/homes/search', { query: 'Cafe' }
    json = JSON.parse(response.body)
    expect(json.length).to eq(1)
    expect(json[0]['name']).to eq('Moonlight Café')

    # Tests the full-text searching capability of multiple string attributes
    get '/api/v1/homes/search', { query: 'Organic pretty tile' }
    json = JSON.parse(response.body)
    expect(json.length).to eq(1)
    expect(json[0]['name']).to eq('Organic Co. Coffee')
  end

  it 'paginates full-text searches a list of homes by 10 results' do
    FactoryGirl.create_list(:home, 15)

    get '/api/v1/homes/search', { query: 'San Francisco' }
    expect(response).to be_success

    json = JSON.parse(response.body)
    expect(json.length).to eq(10)

    expect(response.header['X-Per-Page']).to eq('10')
    expect(response.header['X-Page']).to eq('1')
    expect(response.header['X-Total-Pages']).to eq('2')
    expect(response.header['X-Total']).to eq('15')
  end

  context "queries" do
    before :each do
      FactoryGirl.create(:home)
      FactoryGirl.create(:long_term_home, name: 'Frankie\'s Coffee Shop')
      FactoryGirl.create(:family_home, name: 'Hipster Coffee Shop')
      FactoryGirl.create(:family_and_long_term_home, name: 'Organic Co. Coffee', comment: 'Pretty tile.')
    end

    let(:json) { JSON.parse(response.body) }

    context 'filters a full-text searched list of homes by length of stay' do
      before :each do
        get '/api/v1/homes/search', { query: 'Coffee', long_term: true }
      end

      it "is successful" do
        expect(response).to be_success
      end

      it "finds two coffeeshops with long term homes" do
        expect(json.length).to eq(2)
      end

      it "returns long term homes" do
        expect(json.select { |home| home["long_term"] }.count).to eq 2
      end

      it "does not return short term homes" do
        expect(json.reject { |home| home["long_term"] }.count).to eq 0
      end
    end

    context 'filters a full-text searched list of family homes' do
      before :each do
        get '/api/v1/homes/search', { query: 'Coffee', family: true }
      end

      it "is successful" do
        expect(response).to be_success
      end

      it "finds two family homes" do
        expect(json.length).to eq(2)
      end

      it "returns family homes" do
        expect(json.select { |home| home["family"] }.count).to eq 2
      end

      it "does not return individual homes" do
        expect(json.reject { |home| home["family"] }.count).to eq 0
      end
    end
  end
end
