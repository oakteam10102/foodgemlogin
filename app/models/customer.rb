class Customer < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_one :subscription
  has_one :address 
  has_many :allergies
  has_many :allergens, through: :allergies
  has_one :other_allergy
  has_many :health_goals
  has_many :customer_health_goals, through: :health_goals
  has_many :delivered_meals
  

  def to_s
    email
  end

  def self.search(query)
    if query.blank?
      self.all
    else
      select('(addresses.first_name || " " || addresses.last_name) as \'addresses.full_name\', *')
      self.joins(:address).where('customers.email LIKE :query_string OR addresses.first_name LIKE :query_string OR addresses.last_name LIKE :query_string', {query_string: "%#{query}%"}).joins(:subscription).order("subscriptions.payment_status")
    end
  end


  def send_welcome_email
    require 'mandrill'
    mandrill = Mandrill::API.new ENV['FGLOGIN_MANDRILL_KEY']
    

    message = {"html" =>"<p> Congratulations! <br><br>

      You’ve signed up for a subscription with FoodGem. Expect to have some of the most delicious food from the best restaurants in your area!<br><br>

      Please contact us at info@foodgem.com with any questions you have.<br><br>

      Cheers!</p>",
                "text"=>"Congratulations! 
      You’ve signed up for a subscription with FoodGem. Expect to have some of the most delicious food from the best restaurants in your area!

      Please contact us at info@foodgem.com with any questions you have.

      Cheers!",
    "subject"=>"Success! You Have Subscribed to FoodGem!",
    "from_email"=> "jason@foodgem.com",
    "to" => [
      {"email"=>email,}, 
      {"email"=>"james@foodgem.com", "type"=>"bcc"},
      {"email"=>"jason@foodgem.com", "type"=>"bcc"},
      ],
    }
    sending = mandrill.messages.send message
    puts sending
  end
end
