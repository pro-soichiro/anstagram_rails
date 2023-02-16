module Visible
  extend ActiveSupport::Concern

  VALID_STATUSES = ['公開', '非公開', 'アーカイブ']

  included do
    validates :status, inclusion: { in: VALID_STATUSES }
  end

  class_methods do
    def public_count
      where(status: '公開').count
    end

    def public
      where(status: '公開')
    end
  end


  def public_count
    where(status: '公開').count
  end

  def archived?
    status == 'アーカイブ'
  end
end