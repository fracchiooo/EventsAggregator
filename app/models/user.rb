class User < ApplicationRecord

  #alias_attribute :events, :eventi_partecipo
  #alias_attribute ::events, :eventi_preferiti
  #has_many :eventi_partecipo
  #has_many :eventi_preferiti


  has_many :comments

  validates :data_nascita, :username, :nome, :cognome, :sesso, presence: true
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :lockable, :omniauthable, :omniauth_providers => [:facebook]



  enum role: [:user, :admin]

  after_initialize :set_default_role, :if => :new_record?
       
  def set_default_role
    self.role ||=:user
  end
       
       
       
       
  def self.from_omniauth(auth) 
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user| 
      user.email = auth.info.email 
      user.password = Devise.friendly_token[0,20] 
      user.data_nascita= Date.strptime(auth.extra.raw_info.birthday,'%d/%m/%Y')
      user.immagine_profilo=auth.info.image
      user.username= "profilo ${Random.rand(3000)}"
      user.nome=auth.info.first_name
      user.cognome=auth.info.last_name
      user.sesso=auth.extra.raw_info.gender
    end 
  end 
                  
  def self.new_with_session(params, session) 
    super.tap do |user| 
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"] 
        user.email = data["email"] if user.email.blank? 
      end 
    end 
  end
end
