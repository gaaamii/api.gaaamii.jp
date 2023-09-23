class LinksController < ApplicationController
  def update
    links_params.each do |link_param|
      link = Link.find_or_initialize_by(url: link_param[:url])
      link.name = link_param[:name]
      link.save!
    end

    head :no_content
  end

  private

  def links_params
    params.permit(links: [:name, :url]).require(:links)
  end
end
