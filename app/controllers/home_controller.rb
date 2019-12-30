# frozen_string_literal: true

class HomeController < ApplicationController
  before_action :authenticate_user!

  def home
  end

  def index 
  end

  def about
  end
end
