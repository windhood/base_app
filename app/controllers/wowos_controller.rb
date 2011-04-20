class WowosController  < ApplicationController
  def index
  end
  def new
    @themes = Theme.all
  end
end