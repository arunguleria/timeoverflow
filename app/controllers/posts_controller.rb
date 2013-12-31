class PostsController < InheritedResources::Base
  respond_to :html, :js

  has_scope :by_category, as: :cat
  has_scope :fuzzy_search, as: :q


  protected

  def collection
    get_collection_ivar || begin
      c = end_of_association_chain
      set_collection_ivar(c.page(params[:page]).per(5))
    end
  end

  def begin_of_association_chain
    case params[:action].to_s
    when "index", "show"
      current_organization
    else
      current_user
    end
  end

  def permitted_params
    params.permit(resource_instance_name => [
      :description, :end_on, :global, :joinable, :permanent, :start_on, :title,
      :category_id, :tag_list
    ])
  end

end