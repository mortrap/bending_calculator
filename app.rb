require "sinatra"
require_relative "./lib/sweep"
require_relative "./lib/bend"

enable :sessions
configure do
  set :server, :puma
end

error do
  e = env['sinatra.error']
  "Application error: #{e.message}"
end

get "/" do
  if session["id"].nil?
    session["id"] = rand(0..1000) + rand(0..1000)
    puts "Welcome!"
  else
    puts "Welcome back #{session["id"]}"
  end
  erb :index
end
 

get "/unset_id" do 
  session["id"] = nil
  erb :unset_id
end

post "/:id/calculate" do
  puts session["id"]
  me = params[:metal]
  #puts me
  b_l = params[:b_l].to_f
  th = params[:thickness].to_f
  radius = params[:radius].to_f
  angle = params[:angle].to_f
  bend_1 = params[:bend_1].to_f
  bend_2 = params[:bend_2].to_f
  # puts session
  @result_sweep = Sweep.calc_sweep(me, b_l, th, radius, angle, bend_1, bend_2)
  @result_effort = Sweep.calc_eff(me, b_l, th, radius)
  erb :result
end