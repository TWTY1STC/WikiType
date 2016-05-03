class CollaboratorsController < ApplicationController
  before_action :require_sign_in
  before_action :authorize_user
  
  #A premium owner of a wiki can add any user as a collaborator
  def create
    wiki = Wiki.find(params[:wiki_id])
    collaborate = user.collaborates.build(wiki: wiki)
    if collaborate.save
      flash[:notice] = "Collaborator added."
    else
      flash[:notice] = "Collaborating failed."
    end
    redirect_to[wiki]
  end
  
  def destroy
    wiki = Wiki.find(params[:wiki_id])
    collaborate = user.collaborates.find(params[:id])
        
    if collaborate.destroy
      flash[:notice] = "Collaboration ended."
    else
      flash[:alert] = "Unable to remove collaborator."
    end
    redirect_to [wikis]
  end
end
