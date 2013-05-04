require 'spec_helper'

describe User do

  before do
    @user = User.new(name: "example boy", email: "example@example.com",
                    password: "foobar", password_confirmation: "foobar")
  end

  subject { @user }

  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:remember_token) }
  it { should respond_to(:admin) }
  it { should respond_to(:authenticate) }

  it { should respond_to(:playlist) }

  it { should be_valid }
  it { should_not be_admin }

  describe "creating playlist after creating user" do

    before { @user.save }
    it { @user.playlist.valid? }

  end
end
