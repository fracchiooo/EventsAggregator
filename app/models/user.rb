class User < ApplicationRecord
  #alias_attribute :events, :eventi_partecipo
  #alias_attribute ::events, :eventi_preferiti
  #has_many :eventi_partecipo
  #has_many :eventi_preferiti
  require 'open-uri'
  has_many :favorites
  has_many :like_comments
  has_many :like_events
  has_many :comments, dependent: :destroy
  has_many :segnala_cs

  validates :username, :nome, :cognome, presence: true

  #validates :avatar, :data_nascita, :username, :nome, :cognome, :sesso, presence: true
  
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :rememberable, :validatable, :recoverable,
         :omniauthable, :omniauth_providers => [:facebook, :google_oauth2]



  has_one_attached :avatar

  enum role: [:user, :admin]
 # enum sesso: [:male, :female, :altro]
  enum sesso: [:male, :female, :altro]

  after_initialize :set_default_sesso, :if => :new_record?

  after_initialize :set_default_role, :if => :new_record?

  after_initialize :set_default_immagine_profilo, :if => :new_record?

       
  def set_default_role
    self.role ||=:user
  end
       
      
  def set_default_sesso
    self.sesso ||=:male
  end


  def set_default_immagine_profilo


    File.open("#{Rails.root}/public/images.jpeg","rb") do |f|

      self.immagine_profilo ||= Base64.strict_encode64(f.read)
    end


  end



  def active_for_authentication?
    super && self.account_active
  end
  def inactive_message
    account_active? ? super : :locked
  end


       
  def self.from_omniauth(auth) 
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user| 
      user.email = auth.info.email 
      user.password = Devise.friendly_token[0,20] 

      if auth.provider=='google_oauth2'

        token=auth.credentials.token
        url="https://people.googleapis.com/v1/people/"+(auth.uid).to_s+"?oauth_token="+token.to_s+"&personFields=birthdays,genders&key="+Rails.application.credentials.dig(:google_api_key)
        uri=URI.parse(url)
        http= Net::HTTP.new(uri.host,uri.port)
        http.use_ssl=true
        http.verify_mode= OpenSSL::SSL::VERIFY_NONE
        request= Net::HTTP::Get.new(uri.request_uri)
        response=http.request(request)
        res=JSON.parse(response.body)
     
        begin
          compleanno= res['birthdays'][0]["date"]
          user.data_nascita= Date.strptime((compleanno['day'].to_s+'/'+compleanno['month'].to_s+'/'+compleanno['year'].to_s),'%d/%m/%Y')
        rescue 
          user.data_nascita=nil
        end

        begin
          user.sesso=res['genders'][0]["value"]
        rescue
          user.sesso='altro'
        end

      else
        user.sesso=auth.extra.raw_info.gender
        user.data_nascita=Date.strptime(auth.extra.raw_info.birthday,'%d/%m/%Y')

      end



      #user.immagine_profilo=auth.info.image
      #web=URI.open(auth.info.image).read

      URI.open(auth.info.image) do |f|
        #f.write(Base64.decode64(base_64_encoded_data))
        user.immagine_profilo=Base64.strict_encode64(f.string)
      end
      user.username= "profilo-#{SecureRandom.hex(7)}"
      user.nome=auth.info.first_name
      user.cognome=auth.info.last_name
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
