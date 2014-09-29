# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Recruiting::Application.initialize!

#could possibly also move this to a config file or ENV var, but the point was to try and define this in one place,
#and then base the STATES used for the form off of it. That way, a user couldn't even select an invalid state, and
# we would just need to update VALID_STATES, and get STATES updated for the form for free.
VALID_STATES = ['GA']
STATES = VALID_STATES.collect{|value| [value,value]}.sort
