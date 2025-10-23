#!/usr/bin/env ruby
abort "Enter the metal, bending length, thickness, inner radius, angle between bends, and two bends in sequence, separated by spaces, together with the launch of the program." if ARGV.nil? || ARGV.empty?
require_relative "coe"
module Sweep
  include Effort
  def self.calc_sweep
   # puts "Enter the metal, bending length, thickness, inner radius, angle between bends, and two bends in sequence, separated by spaces< in sequence, separated by spaces."."
   # inputs = gets.split(" ")
    meta_inputs = ARGV[0..3]
    #require_relative "coe"
    #include Effort
    profit_inputs = ARGV[2..-1].map(&:to_f)
    #puts profit_inputs
    #puts meta_inputs
    #k_factor = 0.41 # Оптимальный коэффициент для ваших условий
    x_hash = { 0.1 => 0.323, 0.2 => 0.34, 0.3 => 0.356, 0.4 => 0.367,
               0.5 => 0.379, 0.6 => 0.389, 0.7 => 0.4, 0.8 => 0.413, 0.9 => 0.418,
               1.0 => 0.421, 1.2 => 0.426, 1.3 => 0.431, 1.4 => 0.436,
               1.5 => 0.441, 2 => 0.455, 3 => 0.463, 4 => 0.469, 5 => 0.477,
               6 => 0.48, 7 => 0.485, 8 => 0.49, 9 => 0.495, 10.0 => 0.5 }
    radius = profit_inputs[1]
    thickness = profit_inputs[0]
    angle = profit_inputs[2]
    l1, l2 = profit_inputs[3], profit_inputs[4]
    koef = radius / thickness
    k_factor = x_hash[koef.round(1)]
    radius_n = radius + k_factor * thickness
    puts k_factor
    compensation = 1.95 * (radius + thickness)
    bend_allowance = Math::PI * radius_n * angle / 180.0
    total_length = l1 + l2 - compensation + bend_allowance

    puts "Длина развёртки: #{total_length.round(1)} мм"
    Effort.calc_eff
  end
end

Sweep.calc_sweep
