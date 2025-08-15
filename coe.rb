require_relative 'vth'
module Effort
  include Vmatrix
  def self.calc_eff
    me = ARGV[0]
    bend_length, th, radius = ARGV[1..3].map(&:to_f)
    v = Vmatrix.v_matrix(radius)
    case me
    when 'st'
      rm = 45
    when 'ss'
      rm = 80
    when 'al'
      rm = 20
    else puts 'There is no such metal'
    end
    effort = (1.42 * rm * bend_length * th**2) / v
    res_eff = effort/1000
    puts "Усилие на 1 метр гиба #{res_eff.round(2)}"
    puts "Матрица для радиуса #{radius} =>V #{v}"
    res_eff.round(2)
  end
end
#puts Effort.calc_eff
