module ApplicationHelper
  #used by devise when integrate with active_admin, active_admin seems needing this param
  def skip_sidebar?
      @skip_admin_sidebar == true
  end
end
