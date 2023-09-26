class LinksController < ApplicationController
  def index
    links = Link.limit(10)
    render json: serialize_links(links)
  end

  def update
    # パラメータで指定されたリンクは登録or更新する
    links_params.each do |link_param|
      link = Link.find_or_initialize_by(url: link_param[:url])
      link.name = link_param[:name]
      link.save!
    end

    # パラメータにないリンクはDBから消す
    urls_in_params = links_params.map { |link_param| link_param[:url] }
    links_should_be_deleted = Link.where.not(url: urls_in_params)
    links_should_be_deleted.destroy_all

    head :no_content
  end

  private

  def links_params
    params.permit(links: [:name, :url])[:links]
  end

  def serialize_links(links)
    links.map do |link|
      { id: link.id, name: link.name, url: link.url }
    end
  end
end
