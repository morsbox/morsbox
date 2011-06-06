class Admin::StaticBlocksController < Admin::IndexController
  def index
    @static_blocks = StaticBlock.all
  end
  
  def edit
    @static_block = StaticBlock.find params[:id]
  end
  
  def update
  end
  
  def destroy
  end
end
