module ApplicationHelper
  # used by devise when integrate with active_admin, active_admin seems needing this param
  def skip_sidebar?
      @skip_admin_sidebar == true
  end
  
  # the following methods get from diaspora
  def object_path(object, opts = {})
    return "" if object.nil?
    object = object.person if object.is_a? User
    eval("#{object.class.name.underscore}_path(object, opts)")
  end

  def object_fields(object)
    object.attributes.keys
  end

  def mine?(post)
    current_user.owns? post
  end

  def type_partial(post)
    class_name = post.class.name.to_s.underscore
    "#{class_name.pluralize}/#{class_name}"
  end

  def how_long_ago(obj)
    "#{time_ago_in_words(obj.created_at)} #{t('ago')}"
  end

  def person_url(person)
    case person.class.to_s
    when "User"
      user_path(person)
    when "Person"
      person_path(person)
    else
      I18n.t('application.helper.unknown_person')
    end
  end

  def profile_photo(person)
    person_image_link(person, :size => :thumb_large, :to => :photos)
  end

  def owner_image_tag(size=nil)
    person_image_tag(current_user.person, size)
  end

  def owner_image_link
    person_image_link(current_user.person)
  end

  def person_image_tag(person, size=:thumb_small)
    "<img alt='#{person.name}' class='avatar' data-person_id='#{person.id}' src='#{image_or_default(person, size)}' title='#{person.name}'>".html_safe
  end

  def person_link(person)
"<a href='/people/#{person.id}'>
  #{person.name}
</a>".html_safe
  end

  def image_or_default(person, size=:thumb_large)
    image_location = person.profile.image_url(size) if person.profile
    image_location ||= person.profile.image_url(:thumb_large) if person.profile  #backwards compatability for old profile pictures
    image_location ||= "/images/user/default.png"
    image_location
  end
  
  def hard_link(string, path)
    link_to string, path, :rel => 'external' 
  end

  def person_image_link(person, opts = {})
    return "" if person.nil?
    if opts[:to] == :photos
      link_to person_image_tag(person,opts[:size]), person_photos_path(person)
    else
"<a href='/people/#{person.id}'>
  #{person_image_tag(person)}
</a>".html_safe
    end
  end

  def post_yield_tag(post)
    (':' + post.id.to_s).to_sym
  end

  def person_photos_path person
    person_id = person.id if person.respond_to?(:id)
    person_id ||= person
      
    "#{photos_path}?person_id=#{person_id}"
  end

  def markdownify(message, options = {})
    message = h(message).html_safe

    [:autolinks, :youtube, :emphasis, :links].each do |k|
      if !options.has_key?(k)
        options[k] = true
      end
    end

    if options[:links]
      message.gsub!(/\[([^\[]+)\]\(([^ ]+) \&quot;(([^&]|(&[^q])|(&q[^u])|(&qu[^o])|(&quo[^t])|(&quot[^;]))+)\&quot;\)/) do |m|
        escape = (options[:emphasis]) ? "\\" : ""
        res = "<a target=\"#{escape}_blank\" href=\"#{$2}\" title=\"#{$3}\">#{$1}</a>"
        res
      end
      message.gsub!(/\[([^\[]+)\]\(([^ ]+)\)/) do |m|
        escape = (options[:emphasis]) ? "\\" : ""
        res = "<a target=\"#{escape}_blank\" href=\"#{$2}\">#{$1}</a>"
        res
      end
    end

    if options[:youtube]
      message.gsub!(/( |^)(http:\/\/)?www\.youtube\.com\/watch[^ ]*v=([A-Za-z0-9_]+)(&[^ ]*|)/) do |m|
        res = "#{$1}youtube.com::#{$3}"
        res.gsub!(/(\*|_)/) { |m| "\\#{$1}" } if options[:emphasis]
        res
      end
    end

    if options[:autolinks]
      message.gsub!(/( |^)(www\.[^ ]+\.[^ ])/, '\1http://\2')
      message.gsub!(/(<a target="\\?_blank" href=")?(https|http|ftp):\/\/([^ ]+)/) do |m|
        if !$1.nil?
          m
        else
          res = %{<a target="_blank" href="#{$2}://#{$3}">#{$3}</a>}
          res.gsub!(/(\*|_)/) { |m| "\\#{$1}" } if options[:emphasis]
          res
        end
      end
    end

    if options[:emphasis]
      message.gsub!("\\**", "-^doublestar^-")
      message.gsub!("\\__", "-^doublescore^-")
      message.gsub!("\\*", "-^star^-")
      message.gsub!("\\_", "-^score^-")
      message.gsub!(/(\*\*\*|___)(.+?)\1/m, '<em><strong>\2</strong></em>')
      message.gsub!(/(\*\*|__)(.+?)\1/m, '<strong>\2</strong>')
      message.gsub!(/(\*|_)(.+?)\1/m, '<em>\2</em>')
      message.gsub!("-^doublestar^-", "**")
      message.gsub!("-^doublescore^-", "__")
      message.gsub!("-^star^-", "*")
      message.gsub!("-^score^-", "_")
    end

    if options[:youtube]
      while youtube = message.match(/youtube\.com::([A-Za-z0-9_\\\-]+)/)
        video_id = youtube[1]
        if options[:youtube_maps] && options[:youtube_maps][video_id]
          title = options[:youtube_maps][video_id]
        else
          title = I18n.t 'application.helper.youtube_title.unknown'
        end
        message.gsub!('youtube.com::'+video_id, '<a class="video-link" data-host="youtube.com" data-video-id="' + video_id + '" href="#video">Youtube: ' + title + '</a>')
      end
    end

    return message
  end

  def info_text(text)
    image_tag 'icons/monotone_question.png', :class => 'what_is_this', :title => text
  end
end
