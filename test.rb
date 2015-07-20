
require_relative 'parser'

parser = FutureDate.new(Time.now)
p parser.parse('下週一')
