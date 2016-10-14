configure :production, :development, :test do
  # Database connection
  db = URI.parse(ENV['DATABASE_URL'] || 'postgres://localhost/postgres')

  ActiveRecord::Base.establish_connection(
      :adapter  => db.scheme == 'postgres' ? 'postgresql' : db.scheme,
      :host     => db.host,
      :username => 'postgres',#db.user,
      :password => db.password,
      :database => db.path[1..-1],
      :encoding => 'utf8'
  )
end