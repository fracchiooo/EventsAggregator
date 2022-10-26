class PagesController < ApplicationController
  def home
    if User.where(id: 1).present?
      User.find(1).update_attribute(:role, 'admin')
    end
  end

  def faq
  
  end

  def contatti
  
  end
end
