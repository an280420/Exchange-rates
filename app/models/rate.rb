class Rate < ApplicationRecord
  belongs_to :currency

  def self.group_by_week_with_first_value
    trunc_sql = "date_trunc('week', rates.date + interval '1 day' - interval '1 day')"

    first_value_sql = "FIRST_VALUE(value) OVER (PARTITION BY #{trunc_sql}, rates.currency_id ORDER BY rates.date ASC NULLS LAST)"

    unique_combinations = Rate.select("#{trunc_sql} AS week_start, rates.currency_id, #{first_value_sql} AS first_value")
                              .distinct
                              .order('week_start, rates.currency_id')

    result_hash = {}
    unique_combinations.each do |rate|
      result_hash[rate.week_start.to_date] ||= {}
      result_hash[rate.week_start.to_date][rate.currency_id] = rate.first_value
    end

    result_hash
  end
end
