class PagesController < ApplicationController
  # skip_before_action :authenticate_user!, only: [ :home ]
  # before_action :authenticate_user!, except: [:home]
  skip_before_action :authenticate_user!, only: [:index]


  # before_action :authenticate_user!

  def home
  end
end
