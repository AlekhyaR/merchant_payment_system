# frozen_string_literal: true

module Admins
  class ApplicationController < ApplicationController
    before_action :authenticate_user
  end
end
