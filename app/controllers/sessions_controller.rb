class SessionsController < ApplicationController
  respond_to :json

  def create
    user = User.find_by(email:params[:user][:email])

    if user && user.authenticate(params[:user][:password])
      session[:user_id] = user.id

      respond_with({ authenticated: true,
                     user: user },
                     status: 201,
                     location: nil)
    else
      respond_with({ errors: { email: ["password combination was not found."] } },
                     status: :unprocessable_entity,
                     location: nil)
    end
  end

  def destroy
    session.delete(:user_id)
    respond_with({ authenticated: false }, head: :ok)
  end
end
