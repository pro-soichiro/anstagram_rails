# frozen_string_literal: true

class PrefecturesController < ApplicationController
  def index
    @prefectures = Prefecture.all
  end
end
