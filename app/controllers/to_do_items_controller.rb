class ToDoItemsController < ApplicationController

  def new
    list = List.find params[:id]
    @item = list.items.new

    render partial: 'to_do_items/form', locals: {item: @item}
  end

  def create
    @item = Item.new item_params
    @item.save
  end

  private

  def item_params
    params.require(:item).permit(:text, :list_id)
  end

end