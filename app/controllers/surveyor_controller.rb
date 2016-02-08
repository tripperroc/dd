# encoding: UTF-8
module SurveyorControllerCustomMethods
  def self.included(base)
    base.send :layout, 'surveyor_custom'
  end
end

class UpdateServices
  #attr_accessor :options
  def initialize(fr, fat)
    #self.options = options
    @facebook_response = fr
    @facebook_access_token = fat
  end

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

 def save_relationships
    #  Retrieve Facebook data for current user
    graph_page = "me?fields=interested_in,name,id,gender,relationship_status,significant_other" + 
      "&access_token=#{@facebook_access_token}"
    fetched_page = FbGraph::Page.fetch(graph_page)
    user_data = fetched_page.raw_attributes
    u = FacebookUser.find_or_initialize_from_graph_query_fields(user_data)
    u.save!


    #  Retrieve Facebook data for current user's friends
    graph_page = "me/friends?fields=interested_in,name,id,gender,relationship_status,significant_other" +
      "&access_token=#{@facebook_access_token}"
    fetched_page = FbGraph::Page.fetch(graph_page)
    friend_data = fetched_page.raw_attributes['data']
 
    so_facebook_account_numbers = Array.new
    
    friend_data.each do |friend_fields|
      puts "duh"
      friend = FacebookUser.find_or_initialize_from_graph_query_fields(friend_fields)
      friend.save! if friend.changed?
      u.find_or_create_friendship_with(friend)

      if friend.significant_other
        so_facebook_account_numbers.append(friend.significant_other.facebook_account_number)
      end
    end



    #  Retrieve Facebook data for significant others
    #graph_query = "?ids=" + so_facebook_account_numbers.join(',') + "&fields=id,gender" +
     # "&access_token=#{@facebook_access_token}"
    #significant_other_gender_page = FbGraph::Page.fetch(graph_query)
    #significant_other_gender_data = significant_other_gender_page.raw_attributes
    
    #  significant_other_gender_data looks like:
    #    {
    #      "access_token => nil, 
    #      "1059286719"=>{"id"=>"1059286719", "gender"=>"female"}, 
    #      "64901770"=>{"id"=>"64901770"},
    #      "1563292800"=>{"id"=>"1563292800", "gender"=>"female"},
    #      ...
    #    }

    #significant_other_gender_data.delete('access_token')

    #significant_other_gender_data.each do |facebook_id, significant_other_gender|
    #  so = FacebookUser.find_or_initialize_by_facebook_account_number(facebook_id)
    #  so.gender ||= significant_other_gender["gender"]
    #  so.save! if so.changed?
    #end
    u.total_male_friends
  end

  def perform
    #Debugging code
    #Delayed::Worker.dj_say "starting"
    File.open("test.txt","w").close
    #@facebook_response.facebook_male_friends = 69
    @facebook_response.facebook_male_friends = save_relationships
    @facebook_response.save

    #End debugging code
    #bunch-o-code-here
    #Delayed::Worker.dj_say "completed"

  end
end

class SurveyorController < ApplicationController
  include Surveyor::SurveyorControllerMethods
  include SurveyorControllerCustomMethods


  def surveyor_finish
    #thanks_index_path
    "/ritsurv/thanks"
  end

  def create
      surveys = Survey.where(:access_code => params[:survey_code]).order("survey_version DESC")
      if params[:survey_version].blank?
        @survey = surveys.first
      else
        @survey = surveys.where(:survey_version => params[:survey_version]).first
      end
      
      ### Initialize a response set after first getting the facebook id of the user.
      #require_fb_graph_authentication
      authenticate_with_fb_graph
      @response_set = ResponseSet.find_or_create_by_survey_id_and_user_id(@survey.id, 
                                                                          facebook_user.facebook_account_number)
      @response_set.user_id = facebook_user.facebook_account_number

      facebook_response_set = FacebookResponseSet.find_or_create_by_response_set_id(@response_set.id)
      facebook_response_set.facebook_user_id = facebook_user.id
      session[:email_address]  = params[:user][:address]
      facebook_response_set.email_address = params[:user][:address]
      facebook_response_set.save
      student = Student.find(session[:student_id])
      student.facebook_user_id = facebook_user.facebook_account_number
      student.save


	#save_relationships


 
      Delayed::Job.enqueue(UpdateServices.new(facebook_response_set, facebook_access_token), :priority => 0)

      logger.debug("@@@@@@@@@@@@@@@@@@@@@@@@@@@")
      logger.debug(session[:student_type])
      logger.debug("@@@@@@@@@@@@@@@@@@@@@@@@@@@")
      
      if (@survey && @response_set)
        flash[:notice] = t('surveyor.survey_started_success')
        if session[:student_type] == "NTID"
          logger.debug("/////////////////////////////")
          logger.debug("should be redirecting correctly")
        #redirect_to ("/ritsurv/surveys/rit-quality-of-life-survey/" + @response_set.access_code + "/take")
          redirect_to ("/ritsurv/surveys/rit-quality-of-life-survey/" + @response_set.access_code + "/take?locale=ntid")
        else
          redirect_to ("/ritsurv/surveys/rit-quality-of-life-survey/" + @response_set.access_code + "/take")
        end
        
      else
        flash[:notice] = t('surveyor.Unable_to_find_that_survey')
        redirect_to surveyor_index
      end
    end

end
