module ApplicationHelper
  # used by devise when integrate with active_admin, active_admin seems needing this param
  def skip_sidebar?
      @skip_admin_sidebar == true
  end
  
  # the following methods get from diaspora
  def how_long_ago(obj)
    "#{time_ago_in_words(obj.created_at)} #{t('ago')}"
  end

  def user_image_tag(size=nil)
    person_image_tag(current_user, size)
  end

  def person_image_tag(user, size=:thumb_small)
    "<img alt='#{user.name}' class='avatar' data-user_id='#{user.id}' src='#{image_or_default(user, size)}' title='#{user.name}'>".html_safe
  end

  def image_or_default(user, size=:thumb_large)
    image_location = user.image_url(size) if user
    image_location ||= user.image_url(:thumb_large) if user  #backwards compatability for old profile pictures
    image_location ||= "/images/user/default.png"
    image_location
  end
  
  def hard_link(string, path)
    link_to string, path, :rel => 'external' 
  end
    
end
