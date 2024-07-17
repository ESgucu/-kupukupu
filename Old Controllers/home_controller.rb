class HomeController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index,:home]

  def index
  end
end
