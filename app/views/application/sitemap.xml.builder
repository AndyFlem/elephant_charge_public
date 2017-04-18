xml.instruct! :xml, :version => "1.0", :encoding => "UTF-8"
xml.urlset(xmlns: "http://www.sitemaps.org/schemas/sitemap/0.9") do

  xml.url do
    xml.loc("https://www.elephantcharge.org/")
  end
  xml.url do
    xml.loc("https://www.elephantcharge.org/about")
  end
  xml.url do
    xml.loc("https://www.elephantcharge.org/contact")
  end
  xml.url do
    xml.loc("https://www.elephantcharge.org/awards")
  end
  xml.url do
    xml.loc("https://www.elephantcharge.org/charges")
  end
  xml.url do
    xml.loc("https://www.elephantcharge.org/rules")
  end
  xml.url do
    xml.loc("https://www.elephantcharge.org/beneficiaries")
  end
  xml.url do
    xml.loc("https://www.elephantcharge.org/cars")
  end
  xml.url do
    xml.loc("https://www.elephantcharge.org/newsletters")
  end



  @charges.each do |charge|
    xml.url do
      xml.loc("https://www.elephantcharge.org/" + charge.ref)
    end
  end
  @teams.each do |team|
    xml.url do
      xml.loc("https://www.elephantcharge.org/" + team.ref)
    end
  end
  @beneficiaries.each do |beneficiary|
    xml.url do
      xml.loc("https://www.elephantcharge.org/beneficiary/" + beneficiary.short_name)
    end
  end
  @entries.each do |entry|
    unless entry.is_current?
      xml.url do
        xml.loc("https://www.elephantcharge.org/" + entry.charge.ref + '/' + entry.team.ref )
      end
    end
  end
end
