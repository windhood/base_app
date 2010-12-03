ActiveAdmin.register AdminUser do
  index do |display|    
    display.column("ID", :sortable => :id){|user| link_to user.id, admin_admin_user_path(user) }
    display.columns :username, :email, :current_sign_in_at,:sign_in_count, :created_at
  end
end
