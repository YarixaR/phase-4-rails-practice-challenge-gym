class GymsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

    def index
        gyms = Gym.all
        render json: gyms
    end

    def show
        gym = find_gym
        render json: gym, status: :ok
    end


    def update
        gym = find_gym
        client.update(gym_params)
        render json: gym, status: :accepted
    end

    def destroy
        gym = find_gym
        gym.destroy
        head :no_content
    end

    private

    def find_gym
        Gym.find(params[:id])
    end

    def gym_params
        params.permit(:name, :address)
    end

    def record_not_found(not_found)
        render json: {error: "Gym not found"}, status: :not_found
    end
end
