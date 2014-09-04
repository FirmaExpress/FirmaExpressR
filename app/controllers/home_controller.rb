class HomeController < ApplicationController
  def index
  	
  end

  def homepage
    
  end

  def benefits
    
  end

  def get_plan
    @plan = Plan.find(params[:plan_id])
  end

  def get_plan_post
    plan_id = params[:plan_id]
    name = params[:name]
    email = params[:email]
    message = params[:message]
    plan = Plan.find(plan_id)
    UserMailer.get_plan_email(name, email, message, plan).deliver
    UserMailer.billing_info_email(name, email, plan).deliver
    redirect_to root_url
  end

  def login
  	
  end
  def register

  end
  def aboutus
  	
  end
  def plans
  	
  end
  def terms
    
  end
  def contact
    
  end
end
