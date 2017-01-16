# coding: utf-8
module Web
  class BaseController < ApplicationController
    before_action :authenticate_user!

    layout "web"
  end
end
