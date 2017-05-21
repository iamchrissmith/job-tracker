class ContactsController < ApplicationController
  before_action :set_company
  def create
    @contact = @company.contacts.new(contact_params)
    if @contact.save
      flash[:success] = "#{@contact.full_name} added for #{@company.name}!"
      redirect_to company_path(@company)
    else
      render :new
    end
  end

  private

   def set_company
     @company = Company.find(params[:company_id])
   end

   def contact_params
     params.require(:contact).permit(:first_name, :last_name, :position, :email)
   end
end
