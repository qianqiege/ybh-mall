module ApplicationHelper
  def title(page_title)
    content_for(:title) { page_title }
  end

  def money(number)
    number_to_currency(number, precision: 2, unit: '', delimiter: '')
  end

  def datetime(datetime)
    datetime.to_time.strftime('%Y-%m-%d %H:%M:%S') unless datetime.nil?
  end

  def reservationtime(datetime)
    datetime.to_time.strftime('%Y-%m-%d %H:%M') unless datetime.nil?
  end

  def program_time(datetime)
    datetime = datetime - 28800
    datetime.to_time.strftime('%Y-%m-%d %H:%M:%S') unless datetime.nil?
  end

  def spine_time(datetime)
    datetime.to_time.strftime('%Y-%m-%d %H:%M') unless datetime.nil?
  end

  def date(datetime)
    datetime.to_time.strftime('%Y-%m-%d') unless datetime.nil?
  end

  def unix_time_to_datatime(unix_time)
    spine_time DateTime.strptime(unix_time,'%s')
  end
end
