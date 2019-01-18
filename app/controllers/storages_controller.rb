class StoragesController < ApplicationController
  def index
  end

  def create
    case params['queryResult']['parameters']['request']
    when '入れる'
      st = Storage.find_or_initialize_by(food: params['queryResult']['parameters']['food'])
      st.count = 0 if st.count.nil?
      st.count += params['queryResult']['parameters']['count']&.to_i || 1
      st.save!
    when '出す'
      st = Storage.find_by(food: params['queryResult']['parameters']['food'])
      if st.present?
        if params['queryResult']['parameters']['count'] == 'all'
          st.destroy
        elsif params['queryResult']['parameters']['count'] == 'half'
          st.count = st.count / 2
          st.save!
        else
          st.count -= params['queryResult']['parameters']['count']&.to_i || 1
          st.save!
        end
      end
    end
  end
end
