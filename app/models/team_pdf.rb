require "render_anywhere"

class TeamPdf
  include RenderAnywhere

  def initialize(team)
    @team = team
    @entries=@team.entries.joins(:charge).where("charges.has_result=true").order('charges.charge_date desc')
    @best_leg=@team.best_leg
    @honours=@team.honours
  end

  def to_pdf


    html=as_html
    #File.open("#{Rails.root}/public/system/teams/#{team.ref}.html",'w'){|f| f << html}
    kit = PDFKit.new(html)
    kit.to_file("#{Rails.root}/public/system/teams/#{team.ref}.pdf")
  end

  def filename
    "Team #{invoice.id}.pdf"
  end

  private

  attr_reader :team,:entries,:best_leg,:honours

  def as_html
    render template: "teams/pdf", layout: "pdf", locals: { team: team, entries: entries, best_leg: best_leg, honours:honours}
  end
end