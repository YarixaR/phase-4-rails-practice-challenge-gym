class ClientsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

    def index
        clients = Client.all
        render json: clients
    end

    def show
        client = find_client
        render json: client, status: :ok
    end


    def update
        client = find_client
        client.update(client_params)
        render json: client, status: :accepted
    end


    private

    def find_client
        Client.find(params[:id])
    end

    def client_params
        params.permit(:name, :age)
    end

    def record_not_found(not_found)
        render json: {error: "Client not found"}, status: :not_found
    end
end
