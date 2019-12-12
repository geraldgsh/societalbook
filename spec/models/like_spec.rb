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
