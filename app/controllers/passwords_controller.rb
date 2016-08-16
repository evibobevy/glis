class PasswordsController < Devise::PasswordsController
  def index
    redirect_to root_path
  end

  def create
    super
  end

  def new
    super
  end

  def edit
    super
  end

  def update
    super
  end

end
