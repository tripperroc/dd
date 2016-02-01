class ConsentController < ApplicationController

  def info_letter

    if request.post?
      if @student =  params[:student] 
	 @st = Student.new
         @st.student_type = @student[:student_type]
         @st.gender = @student[:gender]
         @st.year = @student[:year]
         @st.facebook_user_id = 0
         if @st.save
           session[:student_id] = @st.id
           session[:student_type] = @st.student_type
	 else
           redirect_to :action => 'not_eligible'
         end
      else
         redirect_to :action => 'not_eligible'
      end
    else 
      redirect_to :action => 'index'
    end
  end

  def index
    @student = Student.new
    @indy = thanks_index_path
#    @recruitee_coupon = session[:recruitee_coupon]
  end

  def not_eligible
  end

end
