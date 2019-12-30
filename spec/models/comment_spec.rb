require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'Content' do
    before :each do
      @user = User.create(name: 'author', email: 'author@email.com',
                             password: '123465')
      @post = @user.microposts.create(content: 'New post')
      @comment = @post.comments.create(replay: 'this a comment',
                                       user_id: @user.id)
      expect(@comment.valid?).to eql(true)
    end

    it 'should be not be empty' do
      @comment.replay = ''
      expect(@comment.valid?).to eql(false)
    end

    it 'should not exceed 255 characters' do
      @comment.replay = 'A' * 256
      expect(@comment.valid?).to eql(false)
    end

    it 'should belong to a user' do
      @comment.user = nil
      expect(@comment.valid?).to eql(false)
    end

    it 'should belong to a micropost' do
      @comment.micropost = nil
      expect(@comment.valid?).to eql(false)
    end
  end


end
