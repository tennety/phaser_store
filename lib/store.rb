get '/' do
  redirect to('/store')
end

get '/store' do
  haml :phasers, :locals => { :phasers => Phaser.all }
end

get '/admin/phasers/new' do
  haml :new_phaser
end

post '/phaser' do
  phaser = Phaser.new(params["phaser"])
  if phaser.save
    redirect '/store'
  end
end

get '/phasers' do
  redirect to('/store')
end

post '/receipt' do
  phaser = Phaser.find(params["receipt"].delete("phaser_id"))
  receipt = Receipt.new(params["receipt"])
  if receipt.save
    phaser.decrement(receipt)
    redirect to(receipt.checkout_url)
  end
end
