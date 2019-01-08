class API < Grape::API
  mount Blog::V1::Posts
end