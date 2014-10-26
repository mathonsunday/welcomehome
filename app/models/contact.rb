class Contact < MailForm::Base
  attribute :name,      :validate => true
  attribute :email,     :validate => /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i
  attribute :home_id, :allow_blank => true
  attribute :home_name, :allow_blank => true
  validate :home_must_exist
  attribute :message
  attribute :nickname,  :captcha  => true

  def home_must_exist
    if home_id.present?
      if Home.where(:id => home_id, :name => home_name).blank?
        errors.add(:base, "Must be valid home ID and Name")
      end
    end
  end
  # Declare the e-mail headers. It accepts anything the mail method
  # in ActionMailer accepts.
  def headers
    {
      :subject => "My Contact Form #{home_id}",
      :to => "veronica.l.ray@gmail.com",
      :from => %("#{name}" <#{email}>)
    }
  end
end
