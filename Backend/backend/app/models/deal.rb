require 'convert_amount'

class Deal < ApplicationRecord
  validates :amount, :currency, presence: :true
  validates :currency, format: { with: /\A[A-Z]{3}\z/, message: "only allows 3 capital letters" }

  def amount_in_euros
    ConvertAmount.new(amount, currency, 'EUR', created_at.strftime('%F')).convert
  end

  def self.global_revenue(date)
    # prend une date de format "YYYY-MM-DD" pour un jour précis ou "YYYY-MM" pour un mois ou "YYYY"pour une année
    date_hash = Hash[[:year, :month, :day].zip(date.split('-').map(&:to_i))]

    corresponding_deals = Deal.all.select do |deal|
      if date_hash[:day]
        deal.created_at.year == date_hash[:year] && deal.created_at.month == date_hash[:month] && deal.created_at.day == date_hash[:day]
      elsif date_hash[:month]
        deal.created_at.year == date_hash[:year] && deal.created_at.month == date_hash[:month]
      elsif date_hash[:year]
        deal.created_at.year == date_hash[:year]
      end
    end

    corresponding_deals.map(&:amount_in_euros).sum.round(2)
  end
end
