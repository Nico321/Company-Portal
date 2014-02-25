class UserMailer < ActionMailer::Base
  default from: "companyportal99@gmail.com"

  def create_offer(user)
  	@user = user
  	mail(to: user.email, subject: 'Your Offer')
  end

    def create_invoice(user)
  	@user = user
  	mail(to: user.email, subject: 'Your Invoice')
  end

    def create_installation(user)
  	@user = user
  	mail(to: user.email, subject: 'Your Assignment')
  end

    def checkout_cart(user)
  	@user = user
  	mail(to: user.email, subject: 'Your Assignment')
  end
end
