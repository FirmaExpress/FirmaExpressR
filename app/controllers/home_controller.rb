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
