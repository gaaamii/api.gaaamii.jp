class CloudinarySignatureController < ApplicationController
  def show
    params_to_sign = { timestamp: Time.now.to_i }
    signature = Cloudinary::Utils.api_sign_request(params_to_sign, ENV['CLOUDINARY_API_SECRET'])
    render json: { signature: signature }
  end
end
