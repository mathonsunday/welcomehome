ActiveAdmin.register Home do

permit_params :name, :street, :city, :state, :longterm, :family, :directions,
              :comment, :latitude, :longitude, :country
end
