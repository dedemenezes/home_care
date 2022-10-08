class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :rounds, dependent: :destroy
  has_many :user_answers, class_name: 'Answer', foreign_key: :user_answer_id
  has_many :consultations_as_doctor, class_name: 'Consultation', foreign_key: :doctor_id
  has_many :consultations_as_patient, class_name: 'Consultation', foreign_key: :patient_id

  validates :first_name, uniqueness: { scope: :last_name }
  validates :country, presence: true

  geocoded_by :address
  before_save :set_default_image_url

  %w[city street street_number country state].each do |att|
    after_validation :geocode, if: "will_save_change_to_#{att}?".to_sym
  end

  def right_answers_count
    sum = 0
    rounds.each { |round| sum += round.questions.size if round.completed? }
    sum
  end

  def completed_rounds(game)
    rounds.where(game: game, completed: true)
  end

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

  def round_next_level_for(game)
    completed_rounds = rounds.where(completed: true)
    return 1 if completed_rounds.empty?

    completed_rounds.order(level: :desc).first.level + 1
  end
end
