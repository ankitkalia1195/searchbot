require 'rails_helper'

RSpec.describe User do
  it { is_expected.to have_many(:access_grants).class_name('Doorkeeper::AccessGrant').dependent(:delete_all) }
  it { is_expected.to have_many(:access_tokens).class_name('Doorkeeper::AccessToken').dependent(:delete_all) }
  it { is_expected.to have_many(:search_tasks).dependent(:destroy) }
end
