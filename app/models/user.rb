class User < ActiveRecord::Base
    has_many :authorizations  
    has_many :authentications

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :phone_number, :carrier, :username, :rec1, :rec2, :rec3


  def self.create_from_hash!(hash)
    create(:name => hash['user_info']['name'])
  end
  
   def self.find_for_facebook_oauth(access_token, signed_in_resource=nil)
    data = access_token['extra']['user_hash']
    if user = User.find_by_email(data["email"])
      user
    else # Create a user with a stub password. 
      User.create!(:email => data["email"], :password => Devise.friendly_token[0,20]) 
    end
  end
  
  def update_rec(qry)
    self.update_attribute(:rec3,self.rec2)
    self.update_attribute(:rec2,self.rec1)
    self.update_attribute(:rec1,qry)
  end
  
  def text_address
    str = self.phone_number
    if !str 
      return "fuckshit@balls.com"
    end
    str = str.gsub!(/[^0-9]*/,'')
    if self.carrier == "Verizon"
      str<<"@vtext.com"
    elsif self.carrier == "AT&T"
      str<<"@txt.att.net" 
    elsif self.carrier == "T-Mobile"
      str<<"@tmomail.net"
    elsif self.carrier == "Sprint"
      str<<"@messaging.sprintpcs.com"
    else
      str="Fuck"
    end
  end
  
end
