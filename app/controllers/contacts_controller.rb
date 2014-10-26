class ContactsController < ApplicationController
  def new
    @contact = Contact.new(home_id: params['home_id'], home_name: params['home_name'])
  end

  def create
    @contact = Contact.new(params[:contact])
    @contact.request = request
      if @contact.deliver
        flash.now[:error] = nil
        flash.now[:notice] = 'Thank you for your message!'
      else
        flash.now[:error] = 'Cannot send message.'
        render :new
      end
  end
end
