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
## Create postgres DB
```sh
# config/database.yml

default: &default
  adapter: postgresql
  encoding: unicode
  # For details on connection pooling, see Rails configuration guide
  # https://guides.rubyonrails.org/configuring.html#database-pooling
  pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>
  timeout: 5000

development:
  adapter: postgresql
  encoding: unicode
  database: societalbook_development
  username: societalbook
  password: societalbook
  host: 127.0.0.1

test:
  adapter: postgresql
  encoding: unicode
  database: societalbook_test
  username: societalbook
  password: societalbook
  host: 127.0.0.1

production:
  adapter: postgresql
  encoding: unicode
  database: societalbook_production
  username: societalbook
  password: societalbook
  host: 127.0.0.1

$ docker run -d --name societalbook -e POSTGRES_USER=postgres -e POSTGRES_PASSWORD=postgres -d -p 5432:5432 postgres

# Create DB (optional)
$ docker exec -ti f5d710e43239 bash
$ su postgres
psql (12.1 (Debian 12.1-1.pgdg100+1))
Type "help" for help.

postgres=# CREATE DATABASE societalbook_development
postgres=# CREATE DATABASE societalbook_test
postgres=# CREATE DATABASE societalbook_production
```
## Rails with postgresql in Ubutu
```sh
sudo -u postgres createuser -s railsdevuser
sudo -u postgres psql
postgres=# \password railsdevuser
Enter new password:
Enter it again:
\q

#Telling rails to used postgresql
$ rails new societalbook -T -d postgresql

# ./gemfile
.
gem 'devise'
.
.


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
# Intalling devise via rails
```sh
$ rails generate devise:install
      create  config/initializers/devise.rb
      create  config/locales/devise.en.yml
.
.
```

```sh
$ rails generate devise User
      invoke  active_record
      create    db/migrate/20191204202822_devise_create_users.rb
      create    app/models/user.rb
      invoke    test_unit
      create      test/models/user_test.rb
      create      test/fixtures/users.yml
      insert    app/models/user.rb
       route  devise_for :users

$ rails g devise:views
      invoke  Devise::Generators::SharedViewsGenerator
      create    app/views/devise/shared
      create    app/views/devise/shared/_error_messages.html.erb
      create    app/views/devise/shared/_links.html.erb
.
.

$ rails generate migration add_name_to_users name:string
      invoke  active_record
      create    db/migrate/20160130022556_add_name_to_users.rb

## Create the databases via rails
```sh
$ rails db:create
Created database 'societalbook_development'
Created database 'societalbook_test'
```

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
# config/routes.rb

Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }
.
.
```

```sh

$ rails generate devise:controllers users

      create  app/controllers/users/confirmations_controller.rb
      create  app/controllers/users/passwords_controller.rb
      create  app/controllers/users/registrations_controller.rb
      create  app/controllers/users/sessions_controller.rb
      create  app/controllers/users/unlocks_controller.rb
      create  app/controllers/users/omniauth_callbacks_controller.rb
```

```ruby
# app/controller/users/registractiosn_controller.rb

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  def new
    super
  end

  # POST /resource
  def create
    super
  end

  # GET /resource/edit
  def edit
    super
  end

  # PUT /resource
  def update
    super
  end

  # DELETE /resource
  def destroy
    super
  end

  def cancel
    super
  end

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name email password password_confirmation])
  end

  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update,
                                      keys: %i[name email password password_confirmation current_password])
  end
end

```

```erb
# app/views/devise/registration/new.html.erb

<h2>Sign up</h2>

<%= form_for(resource, as: resource_name, url: registration_path(resource_name)) do |f| %>
  <%= render "devise/shared/error_messages", resource: resource %>
  
  <div class="name">
    <%= f.label :name %><br />
    <%= f.text_field :name, autofocus: true %>
  </div>

  <div class="field">
    <%= f.label :email %><br />
    <%= f.email_field :email, autofocus: true, autocomplete: "email" %>
  </div>

  <div class="field">
    <%= f.label :password %>
    <% if @minimum_password_length %>
    <em>(<%= @minimum_password_length %> characters minimum)</em>
    <% end %><br />
    <%= f.password_field :password, autocomplete: "new-password" %>
  </div>

  <div class="field">
    <%= f.label :password_confirmation %><br />
    <%= f.password_field :password_confirmation, autocomplete: "new-password" %>
  </div>

  <div class="actions">
    <%= f.submit "Sign up" %>
  </div>
<% end %>

<%= render "devise/shared/links" %>
```
```erb
# app/views/devise/registration/edit.html.ern

<h2>Edit <%= resource_name.to_s.humanize %></h2>

<%= form_for(resource, as: resource_name, url: registration_path(resource_name), html: { method: :put }) do |f| %>
  <%= render "devise/shared/error_messages", resource: resource %>

  <div class="name">
    <%= f.label :name %><br />
    <%= f.text_field :name, autofocus: true %>
  </div>

  <div class="field">
    <%= f.label :email %><br />
    <%= f.email_field :email, autofocus: true, autocomplete: "email" %>
  </div>

  <% if devise_mapping.confirmable? && resource.pending_reconfirmation? %>
    <div>Currently waiting confirmation for: <%= resource.unconfirmed_email %></div>
  <% end %>

  <div class="field">
    <%= f.label :password %> <i>(leave blank if you don't want to change it)</i><br />
    <%= f.password_field :password, autocomplete: "new-password" %>
    <% if @minimum_password_length %>
      <br />
      <em><%= @minimum_password_length %> characters minimum</em>
    <% end %>
  </div>

  <div class="field">
    <%= f.label :password_confirmation %><br />
    <%= f.password_field :password_confirmation, autocomplete: "new-password" %>
  </div>

  <div class="field">
    <%= f.label :current_password %> <i>(we need your current password to confirm your changes)</i><br />
    <%= f.password_field :current_password, autocomplete: "current-password" %>
  </div>

  <div class="actions">
    <%= f.submit "Update" %>
  </div>
<% end %>

<h3>Cancel my account</h3>

<p>Unhappy? <%= button_to "Cancel my account", registration_path(resource_name), data: { confirm: "Are you sure?" }, method: :delete %></p>

<%= link_to "Back", :back %>

```

3. User sign-in should use the [Devise](https://github.com/plataformatec/devise) gem. Devise gives you all sorts of helpful methods so you no longer have to write your own user passwords, sessions, and #current_user methods. See the [Railscast](http://railscasts.com/episodes/209-introducing-devise?view=asciicast) (which uses Rails 3) for a step-by-step introduction. The docs will be fully current.
```sh
$ rails generate controller home
      create  app/controllers/home_controller.rb
      invoke  erb
      create    app/views/home
      invoke  helper
      create    app/helpers/home_helper.rb
      invoke  assets
      invoke    scss
      create      app/assets/stylesheets/home.scss

```

```erb
# app/view/home/index.html.erb

<h1>Hello <%=current_user.email%></h1>

# app/view/layouts/_nav.html.erb

<nav class="nav bg-dark padding">
  <li class="nav-item">
    <%= link_to 'Home', root_path, class: "nav-link" %>
  </li>
	
  <% if user_signed_in? %>
    <li class="nav-item">
      <%= link_to 'Log Out', destroy_user_session_path, method: :delete, class: "nav-link" %>
    </li>
  <% else %>
    <li class="nav-item">
      <%= link_to 'Log In', new_user_session_path, class: "nav-link" %>
    </li>
    <li class="nav-item">
      <%= link_to 'Sign Up', new_user_registration_path, class: "nav-link" %>
    </li>
  <% end %>
</nav>

# app/view/layouts/application.html.erb

<!DOCTYPE html>
<html>
  <head>
    <title>Societalbook</title>
    <%= csrf_meta_tags %>
    <%= csp_meta_tag %>

    <%= stylesheet_link_tag 'application', media: 'all', 'data-turbolinks-track': 'reload' %>
    <%= javascript_pack_tag 'application', 'data-turbolinks-track': 'reload' %>
  </head>

  <body>
    <%= render 'layouts/nav' %>  
    <p class="notice"><%= notice %></p>
    <p class="alert"><%= alert %></p>
    <%= yield %>
  </body>
</html>
```

```ruby
# config/environments/development.rb

config.action_mailer.default_url_options = { :host => 'localhost:3000' }

# config/routes.rb

Rails.application.routes.draw do
  root to: "home#index"
.
.
end

```

```ruby
# models/user.rb
class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :lockable, :timeoutable, :confirmable and :activatable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
```

## Milestone 3: Users & posts

# Post functionality

1. Generate a Post model via rails and make the corresponding migration as follows:
```sh
$ rails generate model micropost content:text
Running via Spring preloader in process 3891
invoke  active_record
create    db/migrate/20191205215847_create_microposts.rb
create    app/models/micropost.rb
invoke    test_unit
create      test/models/micropost_test.rb
create      test/fixtures/microposts.yml
$ rails db:migrate
== 20191205204514 AddNameToUsers: migrating ===================================
-- add_column(:users, :name, :string)
   -> 0.0016s
== 20191205204514 AddNameToUsers: migrated (0.0016s) ==========================

== 20191205215847 CreateMicroposts: migrating =================================
-- create_table(:microposts)
   -> 0.0585s
== 20191205215847 CreateMicroposts: migrated (0.0585s) ========================
```
2. After the post model is generated we need to map the routes for the post actions.
```ruby
#routes
get "microposts", to: "microposts#index"
get "microposts/new", to: "microposts#new", as: :new_microposts
get "microposts/:id", to: "microposts#show"
get "microposts/:id/edit", to: "microposts#edit"

patch "microposts/:id",  to: "microposts#update", as: :micropost
post "microposts", to: "microposts#create"
delete "microposts/:id",  to: "microposts#destroy"
```
3. A controllers is needed for the resources that we put in our routes.
```sh
$ rails generate controller microposts
create  app/controllers/microposts_controller.rb
invoke  erb
create    app/views/microposts
invoke  test_unit
create    test/controllers/microposts_controller_test.rb
invoke  helper
create    app/helpers/microposts_helper.rb
invoke    test_unit
invoke  assets
invoke    scss
create      app/assets/stylesheets/microposts.scss
```
4. Associate micropots to user via migration:
```sh
$ rails g migration add_user_id_to_microposts user:references
invoke  active_record
create    db/migrate/20191205235313_add_user_id_to_microposts.rb
$ rails db:migrate
== 20191205235313 AddUserIdToMicroposts: migrating ============================
== 20191205235313 AddUserIdToMicroposts: migrated (0.0000s) ===================
```

## Unit and integrations tests
```ruby
# app/models/user.rb




