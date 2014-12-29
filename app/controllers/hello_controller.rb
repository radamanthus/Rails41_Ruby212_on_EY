class HelloController < ApplicationController
  def index
    render plain: "Hello!"
  end
end
