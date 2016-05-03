class CollaboratorsController < ApplicationController
  before_action :set_wiki
  
  def index
    @users = User.all
  end
  
  #A premium owner of a wiki can add any user as a collaborator
  def create
    collaborator = @wiki.collaborators.new(user_id: params[:user_id])
    if collaborator.save
      flash[:notice] = "Collaborator added."
    else
      flash[:notice] = "Collaborating failed."
    end
    redirect_to wiki_collaborators_path(@wiki)
  end
  
  def destroy
    collaborator = Collaborator.find(params[:id])
        
    if collaborator.destroy
      flash[:notice] = "Collaboration ended."
    else
      flash[:alert] = "Unable to remove collaborator."
    end
    redirect_to wiki_collaborators_path(@wiki)
  end
  
  private
  
  def set_wiki
     @wiki = Wiki.find(params[:wiki_id])
  end
end
