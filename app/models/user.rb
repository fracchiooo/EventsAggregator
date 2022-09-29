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
         :lockable, :omniauthable, :omniauth_providers => [:facebook, :google_oauth2]



  enum role: [:user, :admin]

  after_initialize :set_default_role, :if => :new_record?
       
  def set_default_role
    self.role ||=:user
  end
       
       
       
       
  def self.from_omniauth(auth) 
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user| 
      user.email = auth.info.email 
      user.password = Devise.friendly_token[0,20] 

      if auth.provider=='google_oauth2'

        token=auth.credentials.token
        url="https://people.googleapis.com/v1/people/"+(auth.uid).to_s+"?oauth_token="+token.to_s+"&personFields=birthdays,genders&key=AIzaSyDiwKxTnX4EFxCuo75XRDAeltZ6KKXL-Ds"
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
          user.data_nascita=Date.strptime('01/01/1970','%d/%m/%Y')
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



      user.immagine_profilo=auth.info.image
      user.username= "profilo "+(Time.now).to_s
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
