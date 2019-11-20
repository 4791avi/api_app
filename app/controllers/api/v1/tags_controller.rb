class Api::V1::TagsController < ApplicationController
	def index
		tags = Tag.all
		render json: {status: "SUCCESS", message: "Loaded tags", data: tags}, status: :ok 
	end

	def new
		@tag = Tag.new
	end

	def create
		@tag = Tag.new(tag_params)
		if @tag.save
			session[:user_id] = @tag.id
			render json: {status: "SUCCESS", message: "User Saved", data: @tag}, status: :ok
		else
			render json: {status: "ERROR", message: "User not saved", data: @tag.errors}, status: :unprocessable_entity
		end
	end

	def show
		tag = Tag.find(params[:id])
		render json: {status: "SUCCESS", message: "Loaded Tag", data: tag}, status: :ok 				
	end

	def edit
	end


	def update
		tag = Tag.find(params[:id])
		if tag.update_attributes(tag_params)
		    render json: {status: "SUCCESS", message: "tag Updated", data: tag}, status: :ok
		else
			render json: {status: "ERROR", message: "tag not updated", data: tag.errors}, status: :unprocessable_entity
		end
	end

	def destroy
		if params[:id]
			tag = Tag.find(params[:id])
			tag.destroy
			render json: {status: "SUCCESS", message: "User deleted succesfully", data: tag}, status: :ok
		else
			render json: {status: "ERROR", message: "User not found with id", data: params[:id]}, status: :unprocessable_entity
		end
	end

	def sorting
		if params[:sort]
			if params[:sort] == "name"
				tags = Tag.order("name")
			end

			render json: {status: "SUCCESS", message: "Sorted Tags", data: tags}, status: :ok 
		else
			render json: {status: "ERROR", message: "sorting is not valid", data: user.errors}, status: :unprocessable_entity
		end				
	end

	def filters
		if params[:name]
			tags = Tag.where(name: params[:name])
		end
		render json: {status: "SUCCESS", message: "Filtered Tags", data: tags}, status: :ok 		
	end

	private
	def tag_params
		params.permit(:name)
	end
end
