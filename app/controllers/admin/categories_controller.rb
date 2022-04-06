# frozen_string_literal: true

module Admin
  class CategoriesController < AdminController
    def index
      @categories = Category.all
    end

    def edit
      @category = Category.find(params[:id])
    end

    def new
      @category = Category.new
    end

    def create
      @category = Category.new(category_params)
      if @category.save
        redirect_to admin_categories_path, notice: 'Category was successfully created.'
      else
        render :new
      end
    end

    def update
      @category = Category.find(params[:id])
      if @category.update(category_params)
        redirect_to admin_categories_path, notice: 'Category was successfully updated.'
      else
        render :edit
      end
    end

    def destroy
      @category = Category.find(params[:id])
      if @category.rewards.count.positive?
        redirect_to admin_categories_path, notice: 'Category must be empty in order to delete it.'
      else
        @category.destroy
        redirect_to admin_categories_path, notice: 'Category was successfully destroyed.'
      end
    end

    private

    def category_params
      params.require(:category).permit(:title)
    end
  end
end
