class PasswordsController < Devise::PasswordsController

  def create
    super
  end

  def new
    super
  end

  def edit
    p "edit ======================"
    abort params.inspect
    super
  end

  def update
    p "update ======================"
    abort params.inspect
    super
  end

end
