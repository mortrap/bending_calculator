require "sinatra"
require_relative "./lib/sweep"

get "/" do
erb :index
end

post "/calculate" do
  me = params[:metal]
  b_l = params[:b_l].to_f
  th = params[:thickness].to_f
  radius = params[:radius].to_f
  angle = params[:angle].to_f
  bend_1 = params[:bend_1].to_f
  bend_2 = params[:bend_2].to_f
  @result_sweep = Sweep.calc_sweep(me, b_l, th, radius, angle, bend_1, bend_2)
  @result_effort = Sweep.calc_eff(me, b_l, th, radius)
  erb :result
end