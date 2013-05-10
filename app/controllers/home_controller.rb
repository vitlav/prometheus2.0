class HomeController < ApplicationController
  def index
    @branch = Branch.find_by_name_and_vendor!(params[:branch], 'ALT Linux')
    @branches = Branch.order('order_id').load
    if !fragment_exist?("#{I18n.locale}_top15_#{@branch.name}")
      @top15 = Maintainer.top15(@branch)
    end
    if !fragment_exist?("#{I18n.locale}_srpms_#{@branch.name}_#{params[:page]}")
      @srpms = @branch.srpms.where("srpms.created_at > '2010-11-09 09:00:00'").includes(:branch, :builder).includes(:group => [:parent]).order('srpms.created_at DESC').page(params[:page]).per(50)
    end
  end

  def maintainers_list
    @branch = Branch.find_by_name_and_vendor!(params[:branch], 'ALT Linux')
    @branches = Branch.order('order_id').load
    @maintainers = Maintainer.order(:name)
    @teams = MaintainerTeam.order(:name)
  end
end
