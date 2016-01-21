class SurveyController < ApplicationController

# NOTE: this has caused problems in the past. Remove this section to use surveyor's builtin tools.
  def index
        redirect_to :controller => 'consent', :action => 'nothing_here'
  end

  def new
        redirect_to :controller => 'consent', :action => 'nothing_here'
  end

  def export
        redirect_to :controller => 'consent', :action => 'nothing_here'
  end

  def show
        redirect_to :controller => 'consent', :action => 'nothing_here'
  end

  def update
        redirect_to :controller => 'consent', :action => 'nothing_here'
  end

  def edit
        redirect_to :controller => 'consent', :action => 'nothing_here'
  end
# END troublesome patch
end
