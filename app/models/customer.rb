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

  def to_s
    email
  end

  def self.search(query)
    if query.blank?
      self.all
    else
      where('email LIKE ?', "%#{query}%").joins(:subscription).order("subscriptions.payment_status")
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
    "to" => [{"email"=>email,
      }],
    }
    sending = mandrill.messages.send message
    puts sending
  end
end
