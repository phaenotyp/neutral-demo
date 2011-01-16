authorization do
  role :admin do
    has_permission_on [:comments], :to => [:index, :show, :new, :create, :edit, :update, :destroy]
  end
  
  role :guest do
    has_permission_on :comments, :to => [:index, :show]
  end  
  
  role :member do
    has_permission_on :comments, :to => [:index, :show, :new, :create]
    has_permission_on :comments, :to => [:edit, :update, :destroy] do
      if_attribute :user => is { user }
    end
  end
  
  
end