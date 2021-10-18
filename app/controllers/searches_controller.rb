class SearchesController < ApplicationController

  def search
    @model = params[:model]
    @method = params[:method]
    @content = params[:content]
    @records = search_for(@model,@method,@content)
  end

  private

  def search_for(model,method,content)
    if model == 'user'
      if method == 'perfect'
        User.where(name: content)
      elsif method == 'prefix'
        User.where('name LIKE?': content+'%')
      elsif method == 'suffix'
        User.where('name LIKE?': '%'+content)
      elsif method == 'partial'
        User.where('name LIKE?': '%'+content+'%')
      end
    elsif model == 'book'
      if method == 'perfect'
        Book.where(title: content)
      elsif method == 'prefix'
        Book.where('name LIKE?': content+'%')
      elsif method == 'suffix'
        Book.where('name LIKE?': '%'+content)
      elsif method == 'partial'
        Book.where('name LIKE?': '%'+content+'%')
      end
    end
  end

end
