module Visible
  extend ActiveSupport::Concern

  VALID_STATUSES = ['公開', '非公開']

  included do
    validates :status, inclusion: { in: VALID_STATUSES }
  end

  class_methods do
    def public
      where(status: '公開')
    end

    def private
      where(status: '非公開')
    end
  end

  def public
    where(status: '公開')
  end

  def private
    where(status: '非公開')
  end

  def public?
    status == '公開'
  end

  def private?
    status == '非公開'
  end
end