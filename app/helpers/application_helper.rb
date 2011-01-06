module ApplicationHelper
  def mark_required(object, attribute)
    "*" if object.class.validators_on(attribute).map(&:class).include? ActiveModel::Validations::PresenceValidator
  end
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
  
  def ts(st)
    st.to_s.gsub(/(\d)(?=(\d\d\d)+(?!\d))/, "\\1,")
  end
  def i18n_number_to_currency(money)    
    #sprintf("#{DEFAULT_DOLLAR_SIGN} %0.02f" , money)
    ts(money)+DEFAULT_DOLLAR_SIGN.t
  end
  def teaser txt
    if txt.blank?
      ""
    elsif txt.length<=50
      txt
    else
      txt[1..50]+"..."
    end
  end
    
end
