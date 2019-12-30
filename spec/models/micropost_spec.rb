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
