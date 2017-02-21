class SeriesController < ApplicationController

  def new
    render 'shared/admin_only' unless is_admin?
    @series = Series.new
    respond_to do |format|
      format.html
      format.js
    end
  end

  def create
    @series = Series.new(series_params)

    if @series.save
      redirect_to new_course_path, notice: 'Series successfully created.'
    else
      render :new
    end
  end

  private
    def series_params
      params.require(:series).permit(:name, :end_date)
    end
end
