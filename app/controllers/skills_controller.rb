class SkillsController < ApplicationController
  def index
    not_implemented
  end

  def show
    skill = policy_scope(Skill).ensure!(params[:id])
    authorize(skill)
    band = policy_scope(Band).ensure!(params[:band_id])
    members = Member.with_skill(skill).limit(8).order(Arel.sql("RANDOM()"))

    render :show, locals: {skill: skill, band: band, members: members}
  end
end
