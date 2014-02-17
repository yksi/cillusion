require 'spec_helper'
require 'factory_girl_rails' 

describe Comment do
  context "create" do
    it "must be valid" do
      user = FactoryGirl.build(:user)
      user.save
      article = user.user_articles.new(theme: "article", content: "content of article", date: Time.now)
      article.save
      comment = user.comments.new(content: "Comment comment", article: article)
      comment.save
      p article.id
      expect(article.id).to eq comment.article_id 
    end
  end
end
