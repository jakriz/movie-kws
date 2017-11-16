module StatsHelper
  def amount_in_millions(value)
    (value/1000000).to_f
  end
end
