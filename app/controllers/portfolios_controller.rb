class PortfoliosController < ApplicationController
  include UsersHelper

  def new
    @user = current_user
    @portfolio = Portfolio.new
  end

  def create
    @user = User.find_by(id: params[:user_id])
    @portfolio = @user.portfolios.build(portfolio_params)
    if @portfolio.save
      redirect_to user_portfolio_path(@user, @portfolio)
    else
      redirect_to user_path(@user)
    end
  end

  def show
    @user = User.find_by(id: params[:user_id])
    @portfolio = @user.portfolios.find_by(id: params[:id])
    @position = Position.new
    @coins = Coin.all
  end

  private
  def portfolio_params
    params.require(:portfolio).permit(:name, :public, :user_id)
  end
end
