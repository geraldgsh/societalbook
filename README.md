# Microverse Project Title - Final Project [Collaborative Project]
Ruby on Rails

### Introduction.
This project requests you to build a Facebook-like social network application.

Full task description: https://www.theodinproject.com/courses/ruby-on-rails/lessons/final-project

### Microverse Adjustments

* Skip points 16 about setting up a mailer - you will be able to do it if you complete extra task in next steps (which is optional).

* According to requirements first you should: “Think through the data architecture required to make this work. There are a lot of models and a lot of associations, so take the time to plan out your approach.” Keep that in your mind.

### Project specific

###  Ruby version

rbenv 2.6.5

###  System dependencies

Rails 6.0.1

Yarn 1.19.1

Ubuntu 18.04 & below

###  Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

### Milestone 1: Prepare data architecture documentation

Create Entity Relationship Diagram (ERD) for the following tables and its content.

1. Friendship
ID: Integer
Status: boolean
user_id: Integer
friend_id: Integer


2. User
ID: Integer
name: text
email: text
password: text
created_at: datetime
updated_at: datetime

3. Micro-Post
ID: Integer
user_id: Integer
CONTENT: text

4. Like
ID: Integer
user_ID: Integer
micropost_ID: Integer

5. Comment
ID: Integer
micropost_id: Integer
user_id: Integer
CONTENT: test
created_at: datetime
updated_at: datetime

### Milestone 2: Project setup

1. Use Postgresql for your database from the beginning (not sqlite3), that way your deployment to Heroku will go much more smoothly. See the [Heroku Docs](https://devcenter.heroku.com/articles/getting-started-with-rails4) for setup info.
```sh
$ rails new societalbook
      create
      create  README.md
      create  Rakefile
      create  .ruby-version
      create  config.ru
      create  .gitignore
      create  Gemfile
.
.
.

# ./gemfile

gem 'devise', '~> 4.7', '>= 4.7.1'

group :development, :test do
  gem 'sqlite3'
  gem 'pg'
end

group :production do
  gem 'pg'
end

# config/database.yml

default: &default
  adapter: postgresql
  encoding: unicode
  pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>

development:
  <<: *default
  database: societalbook_development
  host: localhost
  username: railsdevuser
  password: password

test:
  <<: *default
  database: societalbook_test
  host: localhost
  username: railsdevuser
  password: password

production:
  <<: *default
  database: societalbook_production
  username: societalbook
  password: <%= ENV['SOCIETALBOOK_DATABASE_PASSWORD'] %>

$ curl -sL https://deb.nodesource.com/setup_10.x 9 | sudo -E bash -

## Installing the NodeSource Node.js 10.x repo...
.
.

$ sudo apt-get install -y nodejs
Reading package lists... Done
Building dependency tree
Reading state information... Done
.
.

$ bundle install
The dependency tzinfo-data (>= 0) will be unused by any of the platforms Bundler is installing for. Bundler is installing for ruby but the dependency is only for x86-mingw32, x86-mswin32, x64-mingw32, java. To add those platforms to the bundle, run `bundle lock --add-platform x86-mingw32 x86-mswin32 x64-mingw32 java`.
Using rake 13.0.1
Using concurrent-ruby 1.1.5
.
.
.

```

2. Users must sign in to see anything except the sign in page.

3. User sign-in should use the [Devise](https://github.com/plataformatec/devise) gem. Devise gives you all sorts of helpful methods so you no longer have to write your own user passwords, sessions, and #current_user methods. See the [Railscast](http://railscasts.com/episodes/209-introducing-devise?view=asciicast) (which uses Rails 3) for a step-by-step introduction. The docs will be fully current.
```sh

# config/environments/development.rb

config.action_mailer.default_url_options = { :host => 'localhost:3000' }

# config/routes.rb

root to: "home#index"
```

```sh
$ rails g devise:views
      invoke  Devise::Generators::SharedViewsGenerator
      create    app/views/devise/shared
      create    app/views/devise/shared/_error_messages.html.erb
      create    app/views/devise/shared/_links.html.erb
.
.

$ rails generate devise User
      invoke  active_record
      create    db/migrate/20191204202822_devise_create_users.rb
      create    app/models/user.rb
      invoke    test_unit
      create      test/models/user_test.rb
      create      test/fixtures/users.yml
      insert    app/models/user.rb
       route  devise_for :users

$ rails db:migrate
== 20191204202822 DeviseCreateUsers: migrating ================================
-- create_table(:users)
   -> 0.0038s
-- add_index(:users, :email, {:unique=>true})
   -> 0.0020s
-- add_index(:users, :reset_password_token, {:unique=>true})
   -> 0.0010s
== 20191204202822 DeviseCreateUsers: migrated (0.0158s) =======================

```

```ruby
# models/user.rb
class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :lockable, :timeoutable, :confirmable and :activatable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation
end
```

```erb

# app/views/layouts/application.html.erb.

<div id="user_nav">
  <% if user_signed_in? %>
    Signed in as <%= current_user.email %>. Not you?
    <%= link_to "Sign out", destroy_user_session_path, :method => :delete %>
  <% else %>
    <%= link_to "Sign up", new_user_registration_path %> or <%= link_to "sign in", new_user_session_path %>
  <% end %>
</div>
<p class="notice"><%= notice %></p>
<p class="alert"><%= alert %></p>

````