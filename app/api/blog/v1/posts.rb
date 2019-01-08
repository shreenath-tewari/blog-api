module Blog
  # invoke version
  module V1
    # invoke class
    class Posts < Grape::API
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
        route_param :id do
          get do
            post = Post.find(params[:id])
            present post, with: Blog::Entities::Post
          end
        end

        # handle post request
        desc 'creates a post'
        params do
          requires :post, type: Hash do
            requires :title, type: String, desc: 'Title'
            requires :content, type: String, desc: 'Content'
          end
        end
        post do
          @post = Post.create!(params)
        end

        # handle put request
        desc 'updates a post'
        params do
          requires :post, type: Hash do
            optional :title, type: String, desc: 'Title'
            optional :content, type: String, desc: 'Content'
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

      # assign comment as resource
      resource :comments do
      end
    end
  end
end