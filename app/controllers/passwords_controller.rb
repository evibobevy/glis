class PasswordsController < Devise::PasswordsController

  def create
    super
  end

  def new
    super
  end

  def edit
    p "edit ======================"
    super
  end

  def update
    p "update ======================"
    super
  end

end
