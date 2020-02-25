# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    @fabricantes = Manufacturer.all
  end
end
