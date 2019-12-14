# frozen_string_literal: true

class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    @posts = Micropost.all
    @post = Micropost.new
  end
end
