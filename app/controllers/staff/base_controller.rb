class Staff::BaseController < ApplicationController
  before_action :require_admin_or_staff
end