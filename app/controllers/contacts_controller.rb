class ContactsController < ApplicationController
  before_action :set_company
  before_action :set_contact, only: [:destroy, :edit, :update]

  def index

  end

  def create
    @contact = @company.contacts.new(contact_params)
    if @contact.save
      flash[:success] = "#{@contact.full_name} added for #{@company.name}!"
      redirect_to company_path(@company)
    else
      render :new
    end
  end

  def destroy
    @contact.destroy
    flash[:success] = "Contact for #{@contact.full_name} was successfully deleted!"
    redirect_to company_path(@company)
  end

  private

  def set_contact
    @contact = Contact.find(params[:id])
  end

   def set_company
     @company = Company.find(params[:company_id])
   end

   def contact_params
     params.require(:contact).permit(:first_name, :last_name, :position, :email)
   end
end
