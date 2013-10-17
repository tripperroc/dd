class ConsentController < ApplicationController

  def info_letter

    if request.post?
#      if @student =  Student.create(params[:student])
#        if !@student.eligible?
#          redirect_to :action => 'not_eligible'
#        end 
      if @student =  params[:student]
#        if !@student.eligible?
#          redirect_to :action => 'not_eligible'
#        end 
#        session[:student_id] = @student.id
      else
         redirect_to :action => 'not_eligible'
      end
    else 
      redirect_to :action => 'index'
    end
  end

  def index
    @student = Student.new
#    @recruitee_coupon = session[:recruitee_coupon]
  end

  def not_eligible
  end

end
