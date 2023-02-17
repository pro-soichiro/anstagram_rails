class PrefecturesController < ApplicationController
  def index
    @prefectures = Prefecture.all
  end
end
