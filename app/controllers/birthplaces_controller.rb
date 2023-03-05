# frozen_string_literal: true

class BirthplacesController < ApplicationController
  def index
    @birthplaces = User.joins('INNER JOIN prefectures p ON prefecture_id = p.id')
                       .select('prefecture_id AS id, p.name, count(*) AS user_size')
                       .group(:prefecture_id)
                       .having('id IS NOT NULL')
                       .order(user_size: :desc)
  end

  def show
    @birthplace = Prefecture.find(params[:id])
  end
end
