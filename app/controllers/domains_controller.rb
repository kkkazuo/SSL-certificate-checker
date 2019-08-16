class DomainsController < ApplicationController
  def index
    render json: { domains: Domain.all }
  end
end