def login?
  if session[:username].nil?
    return false
  else
    return true
  end
end

def username
  return session[:username]
end


get '/' do
  if session[:id]
    @user = User.find(session[:id].to_i-100)
  end
  p @user
  @title = 'Posts & Comments'
  @post = Post.all
  erb :index
end

get '/form' do
  if session[:id]
    @user = User.find(session[:id].to_i - 100) 
    erb :form
  else
    redirect '/login'
  end
end

get '/comment/:id' do
  if session[:id]
    @user = User.find(session[:id].to_i - 100) 
    @commentable_id = params[:id]
    erb :comment
  else
    redirect '/login'
  end
end

post '/comment/:id' do
  Post.find(params[:id]).comments << Comment.create(text: params[:message],
    commenter_id: session[:id] - 100)
  redirect '/'
end

post '/form' do
  Post.create(text: params[:message], creator_id: session[:id] - 100)
  redirect '/'
end

get '/login' do
  erb :login
end

post '/login' do
  u = User.find_by_name(params[:username])
  session[:id] = u.id + 100 if u
  p session[:id]
  redirect '/'
end

get '/register' do
  erb :register
end

get '/posts/:post_id' do
  @post = Post.find(params[:post_id])
  erb :posts
end
post '/register' do
  puts params
  if params[:password] == params[:password_confirmation]
    u = User.create(name: params[:username], password: params[:password])
    session[:id] = u.id + 100
    redirect '/'
  else
    redirect '/register'
  end
end
# is there a session[:id]
# if yes
#   then find the user in the database using the id User.find(session[:id])
#   then load the corresponding user
#   if not 
#     redirect to login page
