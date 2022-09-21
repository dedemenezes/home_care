class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  geocoded_by :address
  before_save :set_default_image_url
  after_validation :geocode, if: :will_save_change_to_city?
  after_validation :geocode, if: :will_save_change_to_street?
  after_validation :geocode, if: :will_save_change_to_street_number?
  after_validation :geocode, if: :will_save_change_to_country?
  after_validation :geocode, if: :will_save_change_to_state?

  def full_name
    "#{first_name} #{last_name}"
  end

  def display_email
    return email unless email.size > 27

    "#{email[0..25]}..."
  end

  def available?
    true
  end

  def home_care?
    true
  end

  def address
    [country, state, city].compact.join(', ')
  end

  def set_default_image_url
    self.image_url = 'https://www.marketingmuses.com/wp-content/uploads/2018/01/invis-user.png' if image_url.nil?
  end
end
