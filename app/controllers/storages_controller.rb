class StoragesController < ApplicationController
  def index
  end

  def create
    case params['queryResult']['parameter']['request']
    when '入れる'
      st = Storage.find_or_initialized_by(food: params['queryResult']['parameter']['food'])
      st.count = 0 if st.count.nil?
      st.count += params['queryResult']['parameter']['count'].to_i
      st.save!
    when '出す'
      st = Storage.find_by(food: params['queryResult']['parameter']['food'])
      if st.present?
        if params['queryResult']['parameter']['count'] == 'all'
          st.destroy
        elsif params['queryResult']['parameter']['count'] == 'half'
          st.count = st.count / 2
          st.save!
        else
          st.count -= params['queryResult']['parameter']['count'].to_i
          st.save!
        end
      end
    end
  end
end
