module NBP
  module Commons
    CORE_WEB_PATH = 'http://www.nbp.pl/kursy/xml/'
    def self.extended(base)
      base.private_class_method :normalize_time_period
    end

    def nbp_date_format_hash(date)
      day =  normalize_time_period date.day.to_s
      month = normalize_time_period date.month.to_s
      year = date.year.to_s[-2..-1]
      { day: day, month: month, year: year }
    end

    private

    def normalize_time_period(number_word)
      number_word.size == 1 ? '0' + number_word : number_word
    end
  end
end
