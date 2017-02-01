class WelcomeController < ApplicationController
  def index
  end

  def catch_404
    redirect_to root_path
  end
end
