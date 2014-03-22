require 'spec_helper'

describe BrowseController do

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'users'" do
    it "returns http success" do
      get 'users'
      response.should be_success
    end
  end

  describe "GET 'articles'" do
    it "returns http success" do
      get 'articles'
      response.should be_success
    end
  end

  describe "GET 'statistic'" do
    it "returns http success" do
      get 'statistic'
      response.should be_success
    end
  end

end
