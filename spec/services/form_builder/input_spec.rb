require 'rails_helper'
require_relative './as_json'

describe FormBuilder::Input do
  include_examples 'as_json with type'
end
