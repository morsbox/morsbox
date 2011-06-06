class Admin::StaticBlocksController < Admin::IndexController
  def index
    @static_blocks = StaticBlock.all
  end
  
  def edit
  end
  
  def update
  end
  
  def destroy
  end
end
