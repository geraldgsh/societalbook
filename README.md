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

# config/environments/development.rb

config.action_mailer.default_url_options = { :host => 'localhost:3000' }
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
# app/view/home/start.html.erb

<section class="hero is-dark">
  <div class="hero-body">
    <div class="container">
      <h1 class="title">
        Welcome to Societalbook!  <%=current_user.email%>
      </h1>
    </div>
  </div>
</section>

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

# app/views/layouts/application.html.erb

<!DOCTYPE html>
<html>
  <head>
    <title>Societalbook</title>
    <%= csrf_meta_tags %>
    <%= csp_meta_tag %>

    <%= stylesheet_link_tag 'application', media: 'all', 'data-turbolinks-track': 'reload' %>
    <%= javascript_pack_tag 'application', 'data-turbolinks-track': 'reload' %>
    <link href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
  </head>

  <body>
    <div class="container">
      <%# <%= render 'layouts/nav' %>
      <%= render "partials/nav"%>
        <% if notice %>
          <p class="notification is-success">
            <button class="delete"></button>
            <%= notice %>
          </p>
        <% end %>
        <% if alert %>
          <p class="notification is-danger">
            <button class="delete"></button>
            <%= alert %>
          </p>
        <% end %>
      <%= yield %>
    </div>
  </body>
  <script type="text/javascript">
    document.addEventListener('DOMContentLoaded', () => {
        (document.querySelectorAll('.notification .delete') || []).forEach(($delete) => {
        $notification = $delete.parentNode;
        $delete.addEventListener('click', () => {
          $notification.parentNode.removeChild($notification);
        });
      });
    });
  </script>
</html>

# app/views/microposts/_feed.html.erb

<% @posts.each do |p| %>
<article class="media">
  <figure class="media-left">
    <p class="image is-64x64">
      <%= link_to gravatar_for(current_user, size: 50)%>
    </p>
  </figure>
  <div class="media-content">
    <div class="content">
      <p>
        <strong><%= current_user.name %></strong>
        <br>
        <%= p.content %>
      </p>		
    </div>
    <nav class="level is-mobile">
      <div class="level-left">
        <a class="level-item">
          <span class="icon is-small"><i class="fas fa-reply"></i></span>
        </a>
        <a class="level-item">
          <span class="icon is-small"><i class="fas fa-retweet"></i></span>
        </a>
        <a class="level-item">
          <span class="icon is-small"><i class="fas fa-heart"></i></span>
        </a>
      </div>
    </nav>
  </div>
  <div class="media-right">
    <button class="micropost delete"></button>
  </div>
</article>
<%end%>

# app/views/microposts/_form.html.erb

<%= form_with(model: @post, local: true) do |form| %>

  <div class="field">
    <%= form.label :content, "What's on your mind ?", class: "label" %>
    <%= form.text_area :content, class: "textarea" %>
  </div>

  <div>
    <%= form.submit "Save", class: "button is-dark is-fullwidth" %>
  </div>
<% end %>

# app/views/microposts/edit.html.erb

<div class="small-container center-block">
  <%= render "microposts/form" %>
</div>

# app/views/microposts/index.html.erb

<div class="hero">
  <div class="hero-body">
    <div class="container">
      <% if signed_in? %>
        <div class="columns">
          <div class="column is-one-third">
            <section class="micropost_form">
              <%= render "form" %>
            </section>
          </div>
          <div class="column is-two-third">
            <h3>Micropost Feed</h3>
            <%= render "feed" %>
          </div>
        </div>
      <%end%>
    </div>
  </div>
</div>

# app/views/microposts/new.html.erb

<div class="columns is-mobile">
  <div class="column is-half is-offset-one-quarter">
    <%= render "microposts/form" %>
  </div>
</div>

# app/views/microposts/show.html.erb

<div>
  <%= @post.content %>
</div>

<div>
  <%= link_to "Delete Post", @post, method: :delete%>
</div>

```

```ruby
# config/routes.rb

Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }
  root to: "home#start"
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

Create models with associations and implement all requested features for users and posts. Add authentication with Devise as described in requirements.

Remember about unit and integrations tests!

## Gravatar Setup

Gravatar stands for Globally Recognized Avatar. It is globally recognized because millions of people and websites use them. Most popular applications like WordPress have built-in support for Gravatar. When a user leaves a comment (with email) on a site that supports Gravatar, it pulls their Globally Recognized Avatar from Gravatar servers. Then that picture is shown next to the comment. This allows each commenter to have their identity through out the world wide web.

[source](https://www.wpbeginner.com/beginners-guide/what-is-gravatar-and-why-you-should-start-using-it-right-away/)

For the purpose of this project, Gravatar will be used for added aesthetics.

```ruby
# app/helpers/users_help.rb

module UsersHelper

  # Returns the Gravatar for the given user.
  def gravatar_for(user, size: 80)
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user.name, class: "gravatar")
  end
end
```

```erb
# app/views/microposts/_feed.html.erb
.
.
  <figure class="media-left">
    <p class="image is-64x64">
      <%= link_to gravatar_for(current_user, size: 50)%>
    </p>
  </figure>
.
.
```

# Micropost functionality

1. Generate a Post model via rails and make the corresponding migration as follows:

## Generate/Setup micropost model & DB tables

```sh
$ rails generate model micropost content:text
Running via Spring preloader in process 3891
invoke  active_record
create    db/migrate/20191205215847_create_microposts.rb
create    app/models/micropost.rb
invoke    test_unit
create      test/models/micropost_test.rb
create      test/fixtures/microposts.yml
```
```ruby
#db/migrate/timestamp_create_microposts.rb
class CreateMicroposts < ActiveRecord::Migration[6.0]
  def change
    create_table :microposts do |t|
      t.text :content

      t.timestamps
    end
  end
end
```
```sh
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
```ruby
# app/models/micropost.rb

class Micropost < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  validates :content, length: { maximum: 255 }, presence: true
end
```

2. After the post model is generated we need to map the routes for the post actions.

```ruby
# config/routes.rb

Rails.application.routes.draw do
.
.
  resources :microposts, only: %i[create destroy index show]
.
.
```

3. Microposts controllers is generated to interact between model and view

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

4. Generate a DB table to Associate microposts to user via migration:

```sh
$ rails g migration add_user_id_to_microposts user:references
invoke  active_record
create    db/migrate/20191205235313_add_user_id_to_microposts.rb
$ rails db:migrate
== 20191205235313 AddUserIdToMicroposts: migrating ============================
== 20191205235313 AddUserIdToMicroposts: migrated (0.0000s) ===================
```

```ruby
# db/migrate/timestamp_add_user_id_to_micropost.rb

class AddUserIdToMicroposts < ActiveRecord::Migration[6.0]
  def change
    add_reference :microposts, :user, null: false, foreign_key: true
  end
end
```

5. Setup Micropost controller for model to interact with view

```ruby
class MicropostsController < ApplicationController
  before_action :find_post, except: [:new, :create, :index]
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  def index
    @posts = Micropost.all
    @post = Micropost.new
  end

  def show
  end

  def edit
  end

  def update
    @post.update(content: params[:post][:content])
    redirect_to @post
  end

  def new
    @post = current_user.posts.build
  end

  def create
    puts "#$$$$$$$$$$$$$$ #{current_user}"
    @post = current_user.microposts.create(content: params[:micropost][:content])
    redirect_to microposts_url
  end

  def destroy
    @post.destroy
    redirect_to root_path
  end

  def find_post
    @post = Micropost.find(params[:id])
  end
end
```

5. Generate & setup User model
```sh
$ rails generate model user
      invoke  active_record
      create    db/migrate/20191212161226_create_users.rb
      create    app/models/user.rb
      invoke    test_unit
      create      test/models/user_test.rb
      create      test/fixtures/users.yml
```
```ruby
# db/migrate/timestamp_devise_create_users.rb

# frozen_string_literal: true

class DeviseCreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      ## Database authenticatable
      t.string :email,              null: false, default: ""
      t.string :encrypted_password, null: false, default: ""

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      # t.integer  :sign_in_count, default: 0, null: false
      # t.datetime :current_sign_in_at
      # t.datetime :last_sign_in_at
      # t.inet     :current_sign_in_ip
      # t.inet     :last_sign_in_ip

      ## Confirmable
      # t.string   :confirmation_token
      # t.datetime :confirmed_at
      # t.datetime :confirmation_sent_at
      # t.string   :unconfirmed_email # Only if using reconfirmable

      ## Lockable
      # t.integer  :failed_attempts, default: 0, null: false # Only if lock strategy is :failed_attempts
      # t.string   :unlock_token # Only if unlock strategy is :email or :both
      # t.datetime :locked_at


      t.timestamps null: false
    end

    add_index :users, :email,                unique: true
    add_index :users, :reset_password_token, unique: true
    # add_index :users, :confirmation_token,   unique: true
    # add_index :users, :unlock_token,         unique: true
  end
end
```

```ruby
# app/model/user.rb

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :microposts
  has_many :likes, dependent: :destroy
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
end
```


6. Generate & setup users controller
```sh
$ rails generate controller users
      create  app/controllers/users_controller.rb
      invoke  erb
      create    app/views/users
      invoke  test_unit
      create    test/controllers/users_controller_test.rb
      invoke  helper
      create    app/helpers/users_helper.rb
      invoke    test_unit
      invoke  assets
      invoke    scss
      create      app/assets/stylesheets/users.scss`
```
```ruby
# app/controller/users_controller.rb

class UsersController < ApplicationController
  def show
  end

  def edit
  end
end

# app/controllers/users/registrations_controller.rb

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

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  def cancel
    super
  end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name email password password_confirmation])
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update,
                                      keys: %i[name email password password_confirmation current_password])
  end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
```

# Rspec test Setup

Ensure rspec-rails present in both the :development and :test groups of your app’s Gemfile:
```sh
# Run against the latest stable release
group :development, :test do
  gem 'rspec-rails', '~> 4.0'
end

```

Then, in your project directory:
```sh
# Download and install
$ bundle update
$ bundle install
$ bundle update rspec-rails

# Generate boilerplate configuration files
# (check the comments in each generated file for more information)
$ rails generate rspec:install
      create  .rspec
      create  spec
      create  spec/spec_helper.rb
      create  spec/rails_helper.rb
```

Create boilerplate specs with rails generate after coding is complete

```sh
# RSpec also provides its own spec file generators
$ rails generate rspec:model user
      create  spec/models/user_spec.rb
```

# spec/models/user_spec.rb
```ruby
require 'rails_helper'

RSpec.describe User, type: :model do
  before :each do
    User.create(name: 'test', email: 'test@test.com', password: "foobar", password_confirmation: "foobar")
  end

  describe '#name' do
    before :each do
      User.create(name: 'test', email: 'test@test.com', password: "foobar", password_confirmation: "foobar")
    end
    it 'doesnt take user without the name' do
      user = User.new
      user.name = nil
      user.valid?
      expect(user.errors[:name]).to include("can't be blank")

      user.name = 'test'
      user.valid?
      expect(user.errors[:name]).to_not include("can't be blank")
    end
  end

  describe '#email' do
    it 'validates for presence of email adress' do
      user = User.new
      user.name = 'test3334'
      user.email = ''
      user.valid?
      expect(user.errors[:email]).to include("can't be blank")

      user.email = 'test3334@gmail.com'
      user.valid?
      expect(user.errors[:email]).to_not include("can't be blank")
    end

    it 'validates for format of email adress' do
      user = User.new
      user.name = 'test9999'
      user.email = 'testtest..com'
      user.valid?
      expect(user.errors[:email]).to include('is invalid')

      user.email = 'test9999@gmail.com'
      user.valid?
      expect(user.errors[:email]).to_not include('is invalid')
    end

  it 'validates email uniquness' do
      user = User.new
      user.name = 'test'
      user.email = 'test@test.com'
      user.password = 'foobar'
      user.valid?
      expect(user.errors[:email]).to include('has already been taken')

      user.name = 'test33'
      user.email = 'testgen@test.com'
      user.password = '123456'
      expect(user.valid?).to eql(true)
    end
  end

  describe '#password' do
    it 'validates the presence of password' do
      user = User.new
      user.name = 'test12'
      user.email = 'test12@test.com'
      user.password = ''
      user.valid?
      expect(user.errors[:password]).to include("can't be blank")

      user.password = '123456'
      expect(user.valid?).to eql(true)
    end

    it 'validates the password confirmation' do
      user = User.new
      user.name = 'test13'
      user.email = 'test13@test.com'
      user.password = '1234567'
      user.password_confirmation = '123456'
      user.valid?
      expect(user.errors[:password_confirmation]).to include("doesn't match Password")

      user.password = '123456'
      expect(user.valid?).to eql(true)
    end

    it 'validates the password length' do
      user = User.new
      user.name = 'test12'
      user.email = 'test12@test.com'
      user.password = ''
      user.valid?
      expect(user.errors[:password]).to include("is too short (minimum is 6 characters)")

      user.password = '123456'
      expect(user.valid?).to eql(true)
    end
  end
end

```

```sh
$ bundle exec rspec spec/models
```

# Micropost rspec test

1. This test should be in a file called micropost_spec.tb inside the spec/modles folder as shows bellow:
```ruby
require 'rails_helper'

RSpec.describe Micropost, type: :model do
  before :each do
    @user = User.create(name: 'test', email: 'test@test.com', password: 'foobar')
  end
  describe 'content' do
    it 'should not be empty' do
      @micropost = @user.microposts.build(content: '')
      expect(@micropost.valid?).to eql(false)
      expect(@micropost.errors.messages[:content]).to include("can't be blank")
    end
    it 'should not be longer than 255' do
      @micropost = @user.microposts.build(content: 'A' * 256)
      expect(@micropost.valid?).to eql(false)
      expect(@micropost.errors.messages[:content]).to include('is too long (maximum is 255 characters)')
    end
    it 'should have an author' do
      @micropost = Micropost.new(content: 'A' * 10)
      expect(@micropost.valid?).to eql(false)
      expect(@micropost.errors.messages[:user]).to include('must exist')
    end
  end
end
```
Then we need to execute the test
```sh
$ bundle exec rspec spec/models
..........

Finished in 0.58586 seconds (files took 0.76588 seconds to load)
10 examples, 0 failures
```

# Milestone 4: Comments & likes

Create models with associations and implement all requested features for comments and likes.

Remember about unit and integrations tests!

1. Generate & setup comment model & DB
```sh
$ rails generate model comment
      invoke  active_record
      create    db/migrate/20191212163355_create_comments.rb
      create    app/models/comment.rb
      invoke    test_unit
      create      test/models/comment_test.rb
      create      test/fixtures/comments.yml
```

```ruby
# app/model/comment.rb

class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :micropost
  validates :replay, presence: true, length: { maximum: 255 }
end
```

```ruby
# db/migrate/timestamp_create_comments.rb

class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.integer :user_id
      t.integer :micropost_id
      t.text :replay

      t.timestamps
    end
  end
end
```

```ruby
# app/models/comment.rb

class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :micropost
  validates :replay, presence: true, length: { maximum: 255 }
end
```

** Run rails db:migrate command

2. Generate & setup comments controller

```sh
$ rails generate controller comments
      create  app/controllers/comments_controller.rb
      invoke  erb
      create    app/views/comments
      invoke  test_unit
      create    test/controllers/comments_controller_test.rb
      invoke  helper
      create    app/helpers/comments_helper.rb
      invoke    test_unit
      invoke  assets
      invoke    scss
      create      app/assets/stylesheets/comments.scss
```
```ruby
# app/controllers/comments_controller.rb

# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_post, only: %i[edit update destroy]
  before_action :authenticate_user!

  def create
    @post = Micropost.find(params[:comment][:micropost_id])
    @comments = @post.comments
    @comment = @post.comments.build(comment_params)
    if @comment.save
      redirect_back(fallback_location: microposts_path)
    else
      flash[:alert] = 'Check the comment form'
      redirect_to root_path
    end
  end

  def destroy
    @comment.destroy
    redirect_to microposts_path
  end

  def edit; end

  def update; end

  private

  def comment_params
    params.require(:comment).permit(:user_id, :micropost_id, :replay)
  end

  def set_post
    @comment = Comment.find(params[:id])
  end
end
```

** Run rails db:migrate command

3. Generate & setup like model & DB
```sh
$ rails generate model like
      invoke  active_record
      create    db/migrate/20191212164601_create_likes.rb
      create    app/models/like.rb
      invoke    test_unit
      create      test/models/like_test.rb
      create      test/fixtures/likes.yml
```

```ruby
# app/model/like.rb

class Like < ApplicationRecord
  belongs_to :micropost
  belongs_to :user

  validates :user_id, uniqueness: { scope: :micropost_id }
end
```

```ruby
# db/migrate/timestamp_create_likes.rb

class CreateLikes < ActiveRecord::Migration[6.0]
  def change
    create_table :likes do |t|
      t.references :user
      t.references :micropost

      t.timestamps
    end
  end
end
```

4. Generate & setup likes controller

```sh
$ rails generate controller likes
      create  app/controllers/likes_controller.rb
      invoke  erb
      create    app/views/likes
      invoke  test_unit
      create    test/controllers/likes_controller_test.rb
      invoke  helper
      create    app/helpers/likes_helper.rb
      invoke    test_unit
      invoke  assets
      invoke    scss
      create      app/assets/stylesheets/likes.scss
```

```ruby
class LikesController < ApplicationController
  before_action :find_post
  before_action :find_like, only: [:destroy]

  def create
    if already_liked?
      flash[:notice] = "You can't like more than once"
    else
      @post.likes.create(user_id: current_user.id)
    end
    redirect_to microposts_path
  end

  def destroy
    if !(already_liked?)
      flash[:notice] = "Cannot unlike"
    else
      @like.destroy
    end
    redirect_to microposts_path
  end

  private

  def find_post
    @post = Micropost.find(params[:micropost_id])
  end

  def find_like
    @like = @post.likes.find(params[:id])
  end

  def already_liked?
    Like.where(user_id: current_user.id, micropost_id:
    params[:micropost_id]).exists?
  end
end
```

5. Setup views for comments & likes

* add font awesome
```erb
# views/layouts/application.html.erb

<!DOCTYPE html>
<html>
  <head>
    <title>Societalbook</title>
    <%= csrf_meta_tags %>
    <%= csp_meta_tag %>

    <%= stylesheet_link_tag 'application', media: 'all', 'data-turbolinks-track': 'reload' %>
    <%= javascript_pack_tag 'application', 'data-turbolinks-track': 'reload' %>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.11.2/css/fontawesome.css" rel="stylesheet">

  </head>

  <body>
    <div class="container">
      <%# <%= render 'layouts/nav' %>
      <%= render "partials/nav"%>
        <% if notice %>
          <p class="notification is-success">
            <button class="delete"></button>
            <%= notice %>
          </p>
        <% end %>
        <% if alert %>
          <p class="notification is-danger">
            <button class="delete"></button>
            <%= alert %>
          </p>
        <% end %>
      <%= yield %>
    </div>
  </body>
  <script type="text/javascript">
    document.addEventListener('DOMContentLoaded', () => {
        (document.querySelectorAll('.notification .delete') || []).forEach(($delete) => {
        $notification = $delete.parentNode;
        $delete.addEventListener('click', () => {
          $notification.parentNode.removeChild($notification);
        });
      });
    });
  </script>
</html>
```
```erb
# app/views/micropost/_feed.html.erb
<% @posts.each do |p| %>
<article class="media">
  <figure class="media-left">
    <p class="image is-64x64">
      <%= link_to gravatar_for(current_user, size: 50)%>
    </p>
  </figure>
  <div class="media-content">
    <div class="content">
      <p>
        <strong><%= p.user.name %></strong>
        <br>
        <%= p.content %>
      </p>
    </div>
    <nav class="level is-mobile">
      <div class="level-left">
        <a class="level-item">
          <span class="icon is-small"><%=fa_icon "reply-all"%></span>
        </a>
        <a class="level-item">
          <span class="icon is-small"><%=fa_icon "retweet"%></span>
        </a>
        <a class="level-item">
          <span class="icon is-small">
          <% pre_like = p.likes.find { |like| like.user_id == current_user.id} %>
          <% if pre_like %>
            <%= link_to fa_icon("thumbs-down"), micropost_like_path(p.id, pre_like), method: :delete %>
          <% else %>
            <%= link_to fa_icon("thumbs-up"), micropost_likes_path(micropost_id: p.id), method: :post %>
          <% end %>              
          </span>
          <p><%= p.likes.count %> <%= (p.likes.count) == 1 ? 'Like' : 'Likes'%></p>
        </a>
      </div>
    </nav>

    <% @comments.each do |c| %>
    <% if p.id == c.micropost_id %>
      <div class="media-right">
        <button class="micropost delete"></button>
      </div>
      <article class="media">
        <figure class="media-left">
          <p class="image is-64x64">
            <%= link_to gravatar_for(current_user, size: 50)%>
          </p>
        </figure>
        <div class="media-content">
          <div class="content">
            <p>
              <strong><%= c.user.name %></strong>
              <br>
              <%= c.replay %>
            </p>
          </div>
          <nav class="level is-mobile">
            <div class="level-left">
              <a class="level-item">
                <span class="icon is-small"><%=fa_icon "reply-all"%></span>
              </a>
              <a class="level-item">
                <span class="icon is-small"><%=fa_icon "retweet"%></span>
              </a>
              <a class="level-item">
                <span class="icon is-small"><%=fa_icon "thumbs-down"%></span>
              </a>
            </div>
          </nav>
        </div>
        <div class="media-right">
          <button class="micropost delete"></button>
        </div>

      </article>
    <%end%>
    <%end%>
    <%= form_with(model: @comment, local: true) do |c| %>

      <div class="field">
        <%= c.hidden_field :user_id, value:current_user.id%>
        <%= c.hidden_field :micropost_id, value:p.id%>
        <%= c.label :replay, "What is your comment ?", class: "label" %>
        <%= c.text_area :replay, class: "textarea", rows: "2", placeholder: 'Add a comment...' %>
      </div>

      <div>
        <%= c.submit "Save", class: "button is-dark is-fullwidth" %>
      </div>
    <% end %>
  </div>
</article>
<%end%>

```
```erb
# app/views/micropost/_form.html.erb
<%= form_with(model: @post, local: true) do |form| %>
  <div class="field">
    <%= form.label :content, "What's on your mind ?", class: "label" %>
    <%= form.text_area :content, class: "textarea", placeholder: 'Add a micropost...' %>
  </div>
  <div>
    <%= form.submit "Save", class: "button is-dark is-fullwidth" %>
  /div>
<% end %>

```
```erb
# app/views/micropost/_post.html.erb

```
```erb
# app/views/microposts/edit.html.erb
<div class="small-container center-block">
  <%= render "microposts/form" %>
</div>
```
```erb
# app/views/microposts/index.html.erb
<div class="hero">
  <div class="hero-body">
    <div class="container">
      <% if signed_in? %>
        <div class="columns">
          <div class="column is-one-third">
            <section class="micropost_form">
              <%= render "form" %>
            </section>
          </div>
          <div class="column is-two-third">
            <h3>Micropost Feed</h3>
            <%= render "feed" %>
          </div>
        </div>
      <%end%>
    </div>
  </div>
</div>
```
```erb
# app/views/microposts/new.html.erb
<div class="columns is-mobile">
  <div class="column is-half is-offset-one-quarter">
    <%= render "microposts/form" %>
  </div>
</div>
```
```erb
# app/views/microposts/show.html.erb
<div>
  <%= @post.content %>
</div>

<div>
  <%= link_to "Delete Post", @post, method: :delete%>
</div>
```
```erb
# app/views/partials/error_messages.html.erb

<% if object.errors.any? %>
  <div id="error_explanation">
    <div class="alert alert-danger">
      The form contains <%= pluralize(object.errors.count, "error") %>.
    </div>
    <ul>
    <% object.errors.full_messages.each do |msg| %>
      <li><%= msg %></li>
    <% end %>
    </ul>
  </div>
<% end %>
```
```erb
# app/views/partials/_nav.erb
<nav class="navbar" role="navigation" aria-label="main navigation">
  <div class="navbar-brand">
    <a class="navbar-item" href="#">
      <p>SocietalBook</p>
    </a>

    <a role="button" class="navbar-burger burger" aria-label="menu" aria-expanded="false" data-target="navbarBasicExample">
      <span aria-hidden="true"></span>
      <span aria-hidden="true"></span>
      <span aria-hidden="true"></span>
    </a>
  </div>

  <div id="navbarBasicExample" class="navbar-menu">
    <div class="navbar-start">

      <%= link_to 'Home', root_path, class: "navbar-item"%>

      <%= link_to 'Micropost', microposts_path, class: "navbar-item"%>

      <div class="navbar-item has-dropdown is-hoverable">
        <a class="navbar-link">
          More
        </a>

        <div class="navbar-dropdown">
          <a class="navbar-item">
            Option 1
          </a>
          <a class="navbar-item">
            Option 2
          </a>
          <a class="navbar-item">
            Option 3
          </a>
          <hr class="navbar-divider">
          <a class="navbar-item">
            Need help?
          </a>
        </div>
      </div>
    </div>

    <div class="navbar-end">
      <div class="navbar-item">
        <div class="buttons">
          <% if user_signed_in? %>
        			<%= link_to 'Sign out', destroy_user_session_path, class: "button is-primary", method: :delete %>
          <% else %>
              <strong>
                <%= link_to 'Sign up', new_user_registration_path, class: "button is-primary" %>
              </strong>
              <strong>
                <%= link_to 'Sign in', new_user_session_path, class: "button is-light" %>
              </strong>
        	<% end %>
        </div>
      </div>
    </div>
  </div>
</nav>

```

6. Setup routes for comments & likes
```ruby
Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }

  resources :microposts, only: %i[create destroy index show] do
    resources :likes, only: %i[create destroy]
  end
  resources :comments, only: [:create, :destroy, :update, :edit]

end

```

```erb
# app/views/partials/

```
```erb
# app/views/partials/

```
```erb
# app/views/partials/

```
reference for like/unlike: https://medium.com/full-taxx/how-to-add-likes-to-posts-in-rails-e81430101bc2
** Note: For "<% link_to : "", ---_path %>" copy path from Rails Routes command.
 7. Performing Unit test for likes and comments with rspec as shown bellow:
 ```ruby
 #societalbook/spec/models/like_spec.rb
 require 'rails_helper'

 RSpec.describe Like, type: :model do
   before :each do
     @user = User.create(name: 'test', email: 'test@test.com',
                       password: '123456')
     @post = @user.microposts.create(content: 'test post')
   end

   it 'should have micropost_id' do
    @like = @user.likes.build
    @like.valid?
    expect(@like.errors[:micropost]).to include('must exist')

    @like = @user.likes.build(micropost_id: @post.id)
    expect(@like.valid?).to eql(true)
  end

  it 'should have user_id' do
   @like = @post.likes.build
   @like.valid?
   expect(@like.errors[:user]).to include('must exist')

   @like = @post.likes.build(user_id: @user.id)
   expect(@like.valid?).to eql(true)
   end

   it 'cant be on same post twice from same user' do
     @like = @post.likes.create(user_id: @user.id)

     @like2 = @post.likes.build(user_id: @user.id)
     expect(@like2.valid?).to eql(false)
     expect(@like2.errors[:user_id]).to include('has already been taken')
   end
 end

```
```ruby
#societalbook/spec/models/comment_spec.rb
require 'rails_helper'

RSpec.describe Like, type: :model do
  before :each do
    @user = User.create(name: 'test', email: 'test@test.com',
                      password: '123456')
    @post = @user.microposts.create(content: 'test post')
  end

  it 'should have micropost_id' do
   @like = @user.likes.build
   @like.valid?
   expect(@like.errors[:micropost]).to include('must exist')

   @like = @user.likes.build(micropost_id: @post.id)
   expect(@like.valid?).to eql(true)
 end

 it 'should have user_id' do
  @like = @post.likes.build
  @like.valid?
  expect(@like.errors[:user]).to include('must exist')

  @like = @post.likes.build(user_id: @user.id)
  expect(@like.valid?).to eql(true)
  end

  it 'cant be on same post twice from same user' do
    @like = @post.likes.create(user_id: @user.id)

    @like2 = @post.likes.build(user_id: @user.id)
    expect(@like2.valid?).to eql(false)
    expect(@like2.errors[:user_id]).to include('has already been taken')
  end
end
```

# Milestone 5: Friendships V1

Create a model with associations and all requested features for friendships. Hint with spoiler alert: If you are stuck, read this article https://smartfunnycool.com/friendships-in-activerecord/.

IMPORTANT NOTE: In the next milestone, you will make friendships associations more efficient. In this one, let’s prepare the working version of the feature.

Remember about unit and integrations tests!

1. Generate & setup friendship model & DB

```sh
$ rails g model friendship user:references friend:references status:boolean  
      invoke  active_record
      create    db/migrate/20191212212954_create_friendships.rb
      create    app/models/friendship.rb
      invoke    test_unit
      create      test/models/friendship_test.rb
      create      test/fixtures/friendships.yml
```

```ruby
# db/migrate/timestamp_create_friendships.rb

class CreateFriendships < ActiveRecord::Migration[6.0]
  def change
    create_table :friendships do |t|
      t.references :user, index: true, foreign_key: true
      t.references :friend, index: true
      t.boolean :status

      t.timestamps null: false
    end
    add_foreign_key :friendships, :users, column: :friend_id
  end
end
```

```ruby
# app/models/friendship.rb

class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, :class_name => "User"
end
```

```sh
$ rails db:migrate

== 20191212201303 CreateFriendships: migrating ================================
-- create_table(:friendships)
   -> 0.6539s
-- add_foreign_key(:friendships, :users, {:column=>:friend_id})
   -> 0.0032s
== 20191212201303 CreateFriendships: migrated (0.6584s) =======================
```

2. Setup friendship in user model & DB

```ruby
# app/models/user.rb

class User < ApplicationRecord
.
.
  has_many :friendships
  has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id"
.
.
  def friends
    friends_array = friendships.map{|friendship| friendship.friend if friendship.status}
    friends_array += inverse_friendships.map{|friendship| friendship.user if friendship.status}
    friends_array.compact
  end

  # Users who have yet to confirme friend requests
  def pending_friends
    friendships.map{|friendship| friendship.friend if !friendship.status}.compact
  end

  # Users who have requested to be friends
  def friend_requests
    inverse_friendships.map{|friendship| friendship.user if !friendship.status}.compact
  end

  def confirm_friend(user)
    friendship = inverse_friendships.find{|friendship| friendship.user == user}
    friendship.status = true
    friendship.save
  end

  def friend?(user)
    friends.include?(user)
  end
end
```

3. Generate and setup friendships controller
```sh
rails generate controller friendships
      create  app/controllers/friendships_controller.rb
      invoke  erb
      create    app/views/friendships
      invoke  rspec
      create    spec/controllers/friendships_controller_spec.rb
      invoke  helper
      create    app/helpers/friendships_helper.rb
      invoke    rspec
      create      spec/helpers/friendships_helper_spec.rb
      invoke  assets
      invoke    scss
      create      app/assets/stylesheets/friendships.scss
```

```ruby
# app/controller/friendships_controller.rb
````

4. Create friendship between users via rails console
```sh
2.6.5 :002 > u1 = User.find(1)
  User Load (1.5ms)  SELECT "users".* FROM "users" WHERE "users"."id" = $1 LIMIT $2  [["id", 1], ["LIMIT", 1]]
 => #<User id: 1, email: "batman@email.com", created_at: "2019-12-11 22:40:48", updated_at: "2019-12-11 22:40:48", name: "batman">
2.6.5 :003 > u2 = User.find(2)
  User Load (1.6ms)  SELECT "users".* FROM "users" WHERE "users"."id" = $1 LIMIT $2  [["id", 2], ["LIMIT", 1]]
 => #<User id: 2, email: "hackernoon@email.com", created_at: "2019-12-12 14:05:22", updated_at: "2019-12-12 14:05:22", name: "hacker noon">

Friendship.all
  Friendship Load (2.9ms)  SELECT "friendships".* FROM "friendships" LIMIT $1  [["LIMIT", 11]]
 => #<ActiveRecord::Relation []>

2.6.5 :068 > f = Friendship.create(user_id: u2.id, friend_id: u1.id, status: false)
   (1.9ms)  BEGIN
  User Load (1.8ms)  SELECT "users".* FROM "users" WHERE "users"."id" = $1 LIMIT $2  [["id", 2], ["LIMIT", 1]]
  User Load (1.0ms)  SELECT "users".* FROM "users" WHERE "users"."id" = $1 LIMIT $2  [["id", 1], ["LIMIT", 1]]
  Friendship Create (1.4ms)  INSERT INTO "friendships" ("user_id", "friend_id", "status", "created_at", "updated_at") VALUES ($1, $2, $3, $4, $5) RETURNING "id"  [["user_id", 2], ["friend_id", 1], ["status", false], ["created_at", "2019-12-12 22:08:53.549844"], ["updated_at", "2019-12-12 22:08:53.549844"]]
   (125.8ms)  COMMIT
 => #<Friendship id: 3, user_id: 2, friend_id: 1, status: false, created_at: "2019-12-12 22:08:53", updated_at: "2019-12-12 22:08:53">

2.6.5 :009 > f
 => #<Friendship id: 1, user_id: 1, friend_id: 2, status: false, created_at: "2019-12-12 21:45:26", updated_at: "2019-12-12 21:45:26">

2.6.5 :014 > u2.friend?(u1)
  Friendship Load (1.2ms)  SELECT "friendships".* FROM "friendships" WHERE "friendships"."user_id" = $1  [["user_id", 2]]
  Friendship Load (3.2ms)  SELECT "friendships".* FROM "friendships" WHERE "friendships"."friend_id" = $1  [["friend_id", 2]]
 => true

2.6.5 :015 > u1.friend?(u2)
  Friendship Load (1.6ms)  SELECT "friendships".* FROM "friendships" WHERE "friendships"."user_id" = $1  [["user_id", 1]]
  Friendship Load (1.3ms)  SELECT "friendships".* FROM "friendships" WHERE "friendships"."friend_id" = $1  [["friend_id", 1]]
 => false

# requestee and requestor

2.6.5 :017 > f.friend
 => #<User id: 2, email: "hackernoon@email.com", created_at: "2019-12-12 14:05:22", updated_at: "2019-12-12 14:05:22", name: "hacker noon">
2.6.5 :018 > f.user
 => #<User id: 1, email: "batman@email.com", created_at: "2019-12-11 22:40:48", updated_at: "2019-12-11 22:40:48", name: "batman">

# Check first user's (user) pending friendship request

2.6.5 :020 > u1.pending_friends
  User Load (1.5ms)  SELECT "users".* FROM "users" WHERE "users"."id" = $1 LIMIT $2  [["id", 2], ["LIMIT", 1]]
 => [#<User id: 2, email: "hackernoon@email.com", created_at: "2019-12-12 14:05:22", updated_at: "2019-12-12 14:05:22", name: "hacker noon">]


# Check 2nd user's (friend) in coming friend reques

2.6.5 :022 > u2.friend_requests
  User Load (2.4ms)  SELECT "users".* FROM "users" WHERE "users"."id" = $1 LIMIT $2  [["id", 1], ["LIMIT", 1]]
 => [#<User id: 1, email: "batman@email.com", created_at: "2019-12-11 22:40:48", updated_at: "2019-12-11 22:40:48", name: "batman">]

# 2nd user (friend) confirm friendship with 1st user (user)

u2.confirm_friend(u1)
   (1.6ms)  BEGIN
  User Load (1.4ms)  SELECT "users".* FROM "users" WHERE "users"."id" = $1 LIMIT $2  [["id", 2], ["LIMIT", 1]]
  Friendship Update (2.8ms)  UPDATE "friendships" SET "status" = $1, "updated_at" = $2 WHERE "friendships"."id" = $3  [["status", true], ["updated_at", "2019-12-12 21:54:51.970268"], ["id", 1]]
   (40.3ms)  COMMIT
 => true

# Check friend's name

2.6.5 :025 > u1.friends[0].name
  Friendship Load (1.2ms)  SELECT "friendships".* FROM "friendships" WHERE "friendships"."user_id" = $1  [["user_id", 1]]
  User Load (3.1ms)  SELECT "users".* FROM "users" WHERE "users"."id" = $1 LIMIT $2  [["id", 2], ["LIMIT", 1]]
  Friendship Load (1.2ms)  SELECT "friendships".* FROM "friendships" WHERE "friendships"."friend_id" = $1  [["friend_id", 1]]
 => "robin"

```

5. Micropost Image Upload

To handle an uploaded image and associate it with the Micropost model, we’ll use the CarrierWave image uploader. To get started, we need to include the carrierwave and mini_magick gems in the Gemfile.

```sh
# gemfile

source 'https://rubygems.org'
.
.
gem 'carrierwave', '~> 2.0', '>= 2.0.2'
gem 'mini_magick', '~> 4.9', '>= 4.9.5'
.
.
end
```
```sh
$ bundle install
```

CarrierWave adds a Rails generator for creating an image uploader, which we’ll use to make an uploader for an image called picture.

```sh
$ rails generate uploader Picture
      create  app/uploaders/picture_uploader.rb
```

Images uploaded with CarrierWave should be associated with a corresponding attribute in an Active Record model, which simply contains the name of the image file in a string field. 

To add the required picture attribute to the Micropost model, we generate a migration and migrate the development database:

```sh
$ rails generate migration add_picture_to_microposts picture:string
      invoke  active_record
      create    db/migrate/20191214211030_add_picture_to_microposts.rb

$ rails db:migrate
== 20191214211030 AddPictureToMicroposts: migrating ===========================
-- add_column(:microposts, :picture, :string)
   -> 0.0832s
== 20191214211030 AddPictureToMicroposts: migrated (0.0839s) ==================
```

The way to tell CarrierWave to associate the image with a model is to use the mount_uploader method, which takes as arguments a symbol representing the attribute and the class name of the generated uploader:

```sh
mount_uploader :picture, PictureUploader
```

Here PictureUploader is defined in the file picture_uploader.rb, which we’ll start editing in Section 13.4.2, but for now the generated default is fine. Adding the uploader to the Micropost model gives the code shown below;

```ruby
class Micropost < ApplicationRecord
.
.
  mount_uploader :picture, PictureUploader
.
.
end

```

To include the uploader on the form page

```erb
# app/views/microposts/_form.html.erb

<%= form_with(model: @post, local: true) do |form| %>
.
.
  <span class="picture">
    <%= form.file_field :picture %>
  </span>
<% end %>
```

Finally, we need to add picture to the list of attributes permitted to be modified through the web. This involves editing the micropost_params method, as shown below;

```ruby

# Image validation

The first image validation, which restricts uploads to valid image types, appears in the CarrierWave uploader itself. The resulting code (which appears as a commented-out suggestion in the generated uploader) verifies that the image filename ends with a valid image extension (PNG, GIF, and both variants of JPEG), as shown below;

```ruby
# app/uploaders/picture_uploader.rb

class PictureUploader < CarrierWave::Uploader::Base
  storage :file

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Add a white list of extensions which are allowed to be uploaded.
  def extension_whitelist
    %w(jpg jpeg gif png)
  end
end
```

The second validation, which controls the size of the image, appears in the Micropost model itself. In contrast to previous model validations, file size validation doesn’t correspond to a built-in Rails validator. As a result, validating images requires defining a custom validation, which we’ll call picture_size and define as shown below

```ruby
# app/models/micropost.rb
class Micropost < ApplicationRecord
.
.
  validate  :picture_size

  private

  # Validates the size of an uploaded picture.
  def picture_size
    if picture.size > 5.megabytes
      errors.add(:picture, "should be less than 5MB")
    end
  end
end
```

This custom validation arranges to call the method corresponding to the given symbol (:picture_size). In picture_size itself, we add a custom error message to the errors collection.

Add two client-side checks on the uploaded image. We’ll first mirror the format validation by using the accept parameter in the file_field input tag:

```sh
<%= form.file_field :picture, accept: 'image/jpeg,image/gif,image/png' %>
```

Include a little JavaScript (or, more specifically, jQuery) to issue an alert if a user tries to upload an image that’s too big (which prevents accidental time-consuming uploads and lightens the load on the server).

```sh
# app/views/shared/_micropost_form.html.erb
.
.
  <span class="picture">
    <%= f.file_field :picture, accept: 'image/jpeg,image/gif,image/png' %>
  </span>
<% end %>
.
.
<script type="text/javascript">
  $('#micropost_picture').bind('change', function() {
    var size_in_megabytes = this.files[0].size/1024/1024;
    if (size_in_megabytes > 5) {
      alert('Maximum file size is 5MB. Please choose a smaller file.');
    }
  });
</script>
```

# Image resizing

It’s also a good idea to resize the images before displaying them.

```sh
