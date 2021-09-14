Rails.application.routes.draw do
  resources :posts
  constraints(subdomain: /.+/) do
    get '/', to: redirect { |parmas, req| "#{req.protocol}#{Rails.application.routes.default_url_options[:host]}/archives/#{Archive.find_by(slug: req.subdomain).try(:id)}" }
  end

  devise_for :users

  resources :archives
  resources :data_sets
  resources :tags
  resources :links

  get 'pages/about', as: 'about'

  root "pages#home"

  namespace :admin do
    resources :users
    resources :assets, only: [:create, :destroy]
  end
end

#편집자 권한이 없는 가입자가 아카이브에 작성한 글이 표현되지 않는 이슈 대응이 필요합니다. post.68 게시글 이고요. 서울 디지털 사회혁신 센터 아카이브 소식 부분의 가운데 있습니다. 
