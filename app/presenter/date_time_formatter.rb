class DateTimeFormatter
  def self.DDMMddyy(date)
    date.strftime("%A, %B, %e, %Y") unless date.nil?
    end
end