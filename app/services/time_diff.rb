class TimeDiff

  def plural_form(number)
    if (number % 100).between?(10, 15)
      return 'many'
    end
    case number % 10
    when 1
      return 'one'
    when 2..4
      return 'few'
    end
    return 'many'
  end

  def diff(from, to)
    secs  = (to - from).to_i
    mins  = secs / 60
    hours = mins / 60
    days  = hours / 24

    days_form = I18n.t 'time.days.' + plural_form(days)
    hours_form = I18n.t 'time.hours.' + plural_form(hours % 24)
    minutes_form = I18n.t 'time.minutes.' + plural_form(mins % 60)
    seconds_form = I18n.t 'time.seconds.' + plural_form(secs % 60)

    word_and = I18n.t :'and'

    if hours > 0
      if mins > 0
        "#{hours} #{hours_form} #{word_and} #{mins % 60} #{minutes_form}"
      else
        "#{hours} #{hours_form} #{word_and}"
      end
    elsif mins > 0
      if secs > 0
        "#{mins} #{minutes_form} #{word_and} #{secs % 60} #{seconds_form}"
      else
        "#{mins} #{minutes_form} #{word_and}"
      end
    elsif secs >= 0
      "#{secs} #{seconds_form}"
    end
  end
end
