require 'spec_helper'

describe Playlist do

  before do
    @user = User.new(name: "example boy", email: 'example@example.com',
                    password: 'foobar', password_confirmation: 'foobar')
  end

  #subject { @playlist }

  describe "creating playlist after creating user" do

    before { @user.save }

    it { @user.playlist.valid? }
  end

end
