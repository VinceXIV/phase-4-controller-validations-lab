class AuthorsController < ApplicationController
  rescue_from ActiveRecord::RecordInvalid, with: :render_when_record_invalid
  
  def show
    author = Author.find(params[:id])

    render json: author
  end

  def create
    author = Author.create!(author_params)
    render json: author, status: :created, status: 201
  end

  private
  
  def author_params
    params.permit(:email, :name)
  end

  def render_when_record_invalid(invalid)
    render json: {errors: invalid.record.errors}, status: 422
  end
  
end
