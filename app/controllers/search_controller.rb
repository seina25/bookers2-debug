class SearchController < ApplicationController

  def search
    @model = params["search"]["model"] #選択したモデル
    @value = params["search"]["value"] #検索した文字、値
    @how = params["search"]["how"]     #選択した検索方法
    @datas = search_for(@how, @model, @value) #search_forの引数にインスタンス変数を定義
  end


  private

  # 完全一致の検索方法の場合
  def match(model, value)
    if model == 'user'
      User.where(name: value) # whereでvalueと完全一致するnameを探す
    elsif model == 'book'
      Book.where(title: value)
    end
  end

  # 前方一致　”値％”
  def forward(model, value)
    if model == 'User'
      User.where("name LIKE ?", "#{value}%" )    #（"カラム名 LIKE ?", "値％"）
    elsif model == 'book'
      Book.where("title LIKE ?", "#{value}%")
    end
  end

  # 後方一致 "％値"
  def backward(model, value)
    if model == 'User'
      User.where("name LIKE ?", "%#{value}")
    elsif model == 'book'
      Book.where("title LIKE ?", "%#{value}")
    end
  end

  # 部分一致 "%値%"
  def pertical(model, value)
    if model == 'user'
      User.where("name LIKE ?", "%#{value}%")
    elsif model == 'book'
      Book.where("title LIKE ?", "%#{value}%")
    end
  end

  #検索方法のhowの中身がどれなのかwhenの条件分岐の中から探す処理
  def search_for(how, model, value) # 例 howがmatchの場合は def match の処理に行く
    case how
    when 'match'
      match(model, value)
    when 'forward'
      forward(model, value)
    when 'backward'
      backward(model, value)
    when 'partical'
      pertical(model, value)
    end
  end
end