require 'active_support/time'
require 'treetop'


Treetop.load 'grammar.tt'

class FutureDate
  def initialize(rel_now = Time.now)
    @parser = DateGrammarParser.new
    @now    = rel_now
  end

  def parse(str)
    date = @parser.parse(str)
    p date
    if date
      eval_date(date.val)
    end
  end

  private

  def eval_date(date)
    p date
    case date[0]
    when :today              then @now.beginning_of_day
    when :tomorrow           then @now.beginning_of_day + 1.day
    when :day_after_tomorrow then @now.beginning_of_day + 2.day
    when :day_in_week        then eval_day_in_week(date[1])
    when :day_in_this_week   then (@now - 1.week).next_week(date[1])
    when :day_in_next_week   then @now.next_week(date[1])
    when :day_in_month       then 111
    end
  end

  def eval_day_in_week(day)
    if (@now - 1.week).next_weekday(day) > @now
      (@now - 1.week).next_weekday(day)
    else
      @now.next_weekday(day)
    end
  end
end
