module Blog
  # invoke version
  module V1
    # invoke class
    class Post < Grape::API
      # initialisation properties
      version 'v1'
      format :json
      prefix :api

      # assign post as resource
      resource :posts do
        # handle index requests
        desc 'returns a list of all posts'
        get do
          posts = Post.all
          present posts, with: Blog::Entities::Index
        end

        # handle show request
        desc 'returns a specific post'
        route_param :id
        get do
          post = Post.find(params[:id])
          present post, with: Blog::Entities::Post
        end

        # handle post request
        desc 'creates a post'
        params do
          requires :post, type: Hash do
            requires :title, type: string, desc: 'Title'
            requires :content, type: string, desc: 'Content'
          end
        end
        post do
          @post = Post.create!(params)
        end

        # handle put request
        desc 'updates a post'
        params do
          requires :post, type: Hash do
            optional :title, type: string, desc: 'Title'
            optional :content, type: string, desc: 'Content'
          end
        end
        put do
          @post = Post.update!(params)
        end

        # handle delete request
        desc 'deletes a post'
        route_param :id
        delete do
          Post.destroy(params[:id])
        end
      end
    end
  end
end