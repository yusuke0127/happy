class MoodsController < ApplicationController
  def index
    @moods = policy_scope(Mood).order(created_at: :desc)
  end

  def new
  end

  def create
  end

  def show
  end

  def insights
    @moods = policy_scope(Mood).order(created_at: :desc)
  end
end
