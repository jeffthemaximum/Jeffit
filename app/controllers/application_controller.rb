
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
	before_filter :configure_permitted_parameters, if: :devise_controller?

	protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :name
    devise_parameter_sanitizer.for(:account_update) << :name
  end
  
  def url_with_protocol(url)
    /^http/i.match(url) ? url : "http://#{url}"
  end

  def name_checker(link_user)
    if link_user == nil
      "Deleted account :("
    else
      link_user.name
    end
  end
  
  #up_or_down_vote param must be either "likes" or "dislikes" according to acts_as_votable gem
  def total_votes(user, like_status)
    total_votes = []
    if like_status == "likes"
      user.links.each do |link|
        total_votes << link.get_likes.size
      end
    end
    if like_status == "dislikes"
      user.links.each do |link|
        total_votes << link.get_dislikes.size
      end
    end
    total_votes.inject{|sum,x| sum + x}
  end
  
  helper_method :url_with_protocol, :name_checker, :total_votes
end