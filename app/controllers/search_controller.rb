class SearchController < ApplicationController
  def search

    @search=Sunspot.search [Charge,Team,Beneficiary] do
      fulltext params[:q]
    end
    @results=@search.results

  end
end