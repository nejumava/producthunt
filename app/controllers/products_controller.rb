class ProductsController < ApplicationController
    def index
        @products = Product.all
    end

    def new
        @product = Product.new
    end

    def create
        @product = Product.new(product_params)
        if @product.save
            redirect_to products_path, notice: "El producto fue publicado con éxito"
        else
            render :new
        end
    end

    def show
        @product = Product.find(params[:id])
    end

    def edit
        @product = Product.find(params[:id])
    end

    def update
        @product = Product.find(params[:id])
        if @product.update(product_params)
            redirect_to products_path, notice: "El producto ha sido modificado con éxito"
        else
            render :edit
        end
    end

    def destroy
        product = Product.find(params[:id])
        product.destroy

        redirect_to products_path, notice: "El producto fue eliminado con éxito"
    end

    def sign_in(user)
        cookies.permanent.signed[:user_id] = user.id
        @current_user = user
    end

    def sign_out
        cookies.delete(:user_id)
        @current_user = nil
    end

    private
        def product_params
            params.require(:product).permit(:name, :url, :description)
        end

        def signed_in?
            !current_user.nil?
        end
        helper_method :signed_in?
        
        def current_user
            @current_user ||= User.find(cookies.signed[:user_id]) if cookies.signed[:user_id]
            rescue ActiveRecord::RecordNotFound
        end
        helper_method :current_user
end