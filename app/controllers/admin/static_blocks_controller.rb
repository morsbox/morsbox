class Admin::StaticBlocksController < Admin::IndexController
  def index
    @static_blocks = StaticBlock.all
  end
  
  def edit
    @static_block = StaticBlock.find params[:id]
  end
  
  def update
    (params[:static_block]||{}).each{ |k,v| params[:static_block][k]=nil if v.blank? }
    @static_block = StaticBlock.find params[:id]
    if @static_block.update_attributes params[:static_block]
      flash[:notice] = t.static_block.saved_successfully
      if params[:apply]
        redirect_to edit_admin_static_block_path(@static_block)
      else
        redirect_to admin_static_blocks_path
      end
    else
      flash[:alert] = t.static_block.errors_occurred
      redirect_to edit_admin_static_block_path(@static_block)
    end
  end
  
  def destroy
    @static_block = StaticBlock.find params[:id]
    @static_block.destroy
    redirect_to admin_static_blocks_path
  end
end
