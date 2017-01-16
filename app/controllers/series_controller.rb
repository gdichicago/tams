class SeriesController < ApplicationController

  # GET /series/new
  def new
    render 'shared/admin_only' unless is_admin?
    @series = Series.new
    respond_to do |format|
      format.html
      format.js
    end
  end

  # POST /series
  def create
    @series = Series.new(series_params)

    if @series.save
      redirect_to admins_dashboard_path, notice: 'Series was successfully created.'
    else
      render :new
    end
  end

  private
    # Only allow a trusted parameter "white list" through.
    def series_params
      params.require(:series).permit(:name, :end_date)
    end
end
