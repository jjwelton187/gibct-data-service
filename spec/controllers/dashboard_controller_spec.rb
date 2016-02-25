require 'support/controller_macros'
require 'support/devise'
require 'support/shared_examples_for_authentication'

RSpec.describe DashboardController, type: :controller do
	it_behaves_like "an authenticating controller", :index, "dashboard"
end
