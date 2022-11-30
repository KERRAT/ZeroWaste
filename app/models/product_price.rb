# frozen_string_literal: true

# == Schema Information
#
# Table name: product_prices
#
#  id         :bigint           not null, primary key
#  category   :integer
#  price      :float
#  uuid       :uuid             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  product_id :bigint           not null
#
# Indexes
#
#  index_product_prices_on_product_id  (product_id)
#  index_product_prices_on_uuid        (uuid) UNIQUE
#
class ProductPrice < ApplicationRecord
  belongs_to :product
  validates :category, inclusion: { in: %w[BUDGETARY MEDIUM PREMIUM],
                                    message: '%<value>s not a valid category' }
  validates :category, :price, presence: true
end
