ActiveAdmin.register Home do

permit_params :name, :street, :city, :state, :long_term, :family, :directions,
              :comment, :latitude, :longitude, :country
end
