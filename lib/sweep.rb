#!/usr/bin/env ruby
# frozen_string_literal: true

module Vmatrix
  def self.v_matrix(radius)
    case radius
    when (0.8..1)
      6
    when (1.3..1.5)
      8
    when (1.7..1.8)
      10
    when (2.0..2.2)
      12
    when (2.5..2.7)
      16
    when (3.0..3.4)
      20
    when (3.5..3.7)
      22
    else
      puts 'There is no such matrix'
    end
  end
end

module Sweep
  include Vmatrix
  def self.calc_sweep(me, b_l, th, radius, angle, bend_1, bend_2)
    def self.calc_eff(me, b_l, th, radius)
      b_l.to_f
      th.to_f
      radius.to_f
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
      effort = (1.42 * rm * b_l * th**2) / v
      res_eff = effort / 1000
      puts "Усилие на #{b_l} мм гиба #{res_eff.round(2)}"
      puts "Матрица для радиуса #{radius} =>V #{v}"
      {"effort" =>res_eff.round(2), "matrix for #{radius} radius" =>v} 
    end

    # puts "Enter the metal, bending length, thickness, inner radius, angle between bends, and two bends in sequence, separated by spaces in sequence, separated by spaces."
    # inputs = gets.split(" ")
    work_array = [me, b_l, th, radius, angle, bend_1, bend_2]
    puts b_l
    # require_relative "coe"
    # include Effort
    profit_inputs = work_array[2..].map(&:to_f)
    # puts meta_inputs
    # k_factor = 0.41 # Оптимальный коэффициент для ваших условий
    x_hash = { 0.1 => 0.323, 0.2 => 0.34, 0.3 => 0.356, 0.4 => 0.367,
               0.5 => 0.379, 0.6 => 0.389, 0.7 => 0.4, 0.8 => 0.413, 0.9 => 0.418,
               1.0 => 0.421, 1.2 => 0.426, 1.3 => 0.431, 1.4 => 0.436,
               1.5 => 0.441, 2 => 0.455, 3 => 0.463, 4 => 0.469, 5 => 0.477,
               6 => 0.48, 7 => 0.485, 8 => 0.49, 9 => 0.495, 10.0 => 0.5 }
    radius = profit_inputs[1]
    thickness = profit_inputs[0]
    angle = profit_inputs[2]
    l1 = profit_inputs[3]
    l2 = profit_inputs[4]
    koef = radius / thickness
    k_factor = x_hash[koef.round(1)]
    radius_n = radius + k_factor * thickness
    compensation = 1.95 * (radius + thickness)
    bend_allowance = Math::PI * radius_n * angle / 180.0
    total_length = l1 + l2 - compensation + bend_allowance

    puts "Длина развёртки: #{total_length.round(1)} мм"
    #calc_eff(me, b_l, th, radius)
    return total_length.round(1)
    
  end
end

#Sweep.calc_sweep("st", 200, 1.5, 1, 90, 20, 20)
