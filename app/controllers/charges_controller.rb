class ChargesController < ApplicationController
  def new
  end
  
  def create
    #amount in cents
    @amount = 1500

  customer = Stripe::Customer.create(
     email: current_user.email,
     card: params[:stripeToken]
   )
 
   # Where the real magic happens
   charge = Stripe::Charge.create(
     customer: customer.id, # Note -- this is NOT the user_id in your app
     amount: @amount,
     description: "Premium Membership- #{current_user.email}",
     currency: 'usd'
   )

      
    current_user.premium!  
      
    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to new_charge_path
  end
  
  def downgrade
    current_user.standard!
    current_user.wikis.where(private: true).update_all(private: false)
    flash[:notice] = "You have downgraded to free standard membership and your private wikis are now public."
    redirect_to root_path
    
  end
end
