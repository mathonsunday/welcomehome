module API
  module V1
    class Homes < Grape::API
      include Grape::Kaminari
      paginate :per_page => 10

      version 'v1'
      format :json

      resource :homes do
        desc "Get all home records ordered by date descending."
        params do
          optional :ada, type: Boolean, desc: "Only return homes that are ADA accessible."
          optional :unisex, type: Boolean, desc: "Only return homes that are unisex."
        end
        get do
          r = Home
          r = r.accessible if params[:ada].present?
          r = r.unisex if params[:unisex].present?

          paginate(r.order(created_at: :desc))
        end

        desc "Perform full-text search of home records."
        params do
          optional :ada, type: Boolean, desc: "Only return homes that are ADA accessible."
          optional :unisex, type: Boolean, desc: "Only return homes that are unisex."
          requires :query, type: String, desc: "Your search query."
        end
        get :search do
          r = Home
          r = r.accessible if params[:ada].present?
          r = r.unisex if params[:unisex].present?

          paginate(r.text_search(params[:query]))
        end

        desc "Search by location."
        params do
          optional :ada, type: Boolean, desc: "Only return homes that are ADA accessible."
          optional :unisex, type: Boolean, desc: "Only return homes that are unisex."
          requires :lat, type: Float, desc: "latitude"
          requires :lng, type: Float, desc: "longitude"
        end
        get :by_location do
          r = Home
          r = r.accessible if params[:ada].present?
          r = r.unisex if params[:unisex]
          paginate(r.near([params[:lat], params[:lng]], 20, :order => 'distance'))
        end
      end
    end
  end
end
