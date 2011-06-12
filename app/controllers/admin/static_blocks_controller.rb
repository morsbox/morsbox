class Admin::StaticBlocksController < Admin::IndexController
  before_filter(:only => :update){ nullify_empty_values_from_params :static_block }
  
  def index
    @static_blocks = StaticBlock.all
  end
  
  def edit
    @static_block = StaticBlock.find params[:id]
  end
  
  def update
    @static_block = StaticBlock.find params[:id]
    if @static_block.update_attributes params[:static_block]
      flash[:notice] = t.static_block.saved_successfully
      if params[:apply]
        redirect_to edit_admin_static_block_path(@static_block)
      else
        redirect_to admin_static_blocks_path
      end
    else
      flash[:alert] = t.static_block.errors_occurred+@static_block.errors.full_messages*", "
      redirect_to edit_admin_static_block_path(@static_block)
    end
  end
  
  def destroy
    @static_block = StaticBlock.find params[:id]
    @static_block.destroy
    flash[:notice] = t.static_block.destroyed_successfully
    redirect_to admin_static_blocks_path
  end
end
