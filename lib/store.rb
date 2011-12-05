get '/' do
  redirect '/store'
end

get '/store' do
  haml :phasers, :locals => { :phasers => Phaser.all }
end

get '/admin/phasers/new' do
  haml :new_phaser
end

post '/phasers' do
  phaser = Phaser.new(params[:phaser])
  if phaser.save
    redirect '/store'
  end
end

get '/phasers' do
  redirect '/store'
end
