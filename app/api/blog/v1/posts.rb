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
        # invoke helpers
        helpers Blog::V1::Helpers::AuthenticationHelper

        # handle index requests
        desc 'returns a list of all posts'
        get do
          posts = Post.all
          present posts, with: Blog::V1::Entities::Index
        end

        # handle show request
        desc 'returns a specific post'
        route_param :id do
          get do
            post = Post.find(params[:id])
            present post, with: Blog::V1::Entities::Post
          end
        end

        # handle post request
        desc 'creates a post'
        params do
          requires :title, type: String, desc: 'Title'
          requires :content, type: String, desc: 'Content'
        end
        post do
          if authenticated
            @post = Post.new(title: params[:title], content: params[:content], user_id: current_user_id)
            if @post.save!
              present @post
            end
          else
            error = { "error": "Authentication Failed! Please Login" }
            present error
          end
        end

        # handle put request
        desc 'updates a post'
        params do
          requires :id, type: Integer, desc: 'ID'
          optional :title, type: String, desc: 'Title'
          optional :content, type: String, desc: 'Content'
        end
        put '/:id' do
          if authenticated
            @post = Post.find(params[:id])
            if current_user_id == @post.user_id
              @post.update!(params)
            else
              error = { "error": "Authorization Failed! You are not the author of the Post" }
              present error
            end
          else
            error = { "error": "Authentication Failed! Please Login" }
            present error
          end
        end 

        # handle delete request
        desc 'deletes a post'
        params do
          requires :id
        end
        delete '/:id' do
          if authenticated
            post = Post.find(params[:id])
            if current_user == post.user_id
              if post.destroy
                status 204
              else
                present :errors
              end
            else
              error = { "error": "Authorization Failed! You are not the author of the Post" }
              present error
            end
          else
            error = { "error": "Authentication Failed! Please Login" }
            present error
          end
        end

        # handle post request
        desc 'creates a comment'
        params do
          requires :body, type: String, desc: 'Body'
        end
        post '/:post_id' do
          Comment.create!(params)
        end

        # handle put request for comments
        desc 'updates a comment'
        params do
          requires :id, type: Integer, desc: 'ID'
          optional :body, type: String, desc: 'Body'
        end
        put '/:post_id/comment/:id' do
          @comment = Comment.find(params[:id])
          @comment.update(params)
        end

        # handles delete request for comments
        desc 'deletes a comment'
        params do
          requires :id, type: Integer, desc: 'ID'
        end
        delete ':post_id/comment/:id' do
          Comment.destroy(params[:id])
        end
      end
    end
  end
end