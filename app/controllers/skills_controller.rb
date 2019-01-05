class SkillsController < ApplicationController
  def index
  end

  def show
    skill = Skill.ensure!(params[:id])
    band = Band.ensure!(params[:band_id])
    members = Member.with_skill(skill).limit(8).order(Arel.sql("RANDOM()"))

    render :show, locals: {skill: skill, band: band, members: members}
  end
end
