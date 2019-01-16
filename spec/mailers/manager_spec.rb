require "rails_helper"

RSpec.describe ManagerMailer, type: :mailer do
  describe "balance_getting_low" do
    let(:manager_mailer) { ManagerMailer }
    let(:manager) { create(:manager) }
    let(:mail) { manager_mailer.with(user: manager).balance_getting_low }

    it "renders the headers" do
      expect(mail.subject).to eq("[Rockburg] Balance is getting low!")
      expect(mail.to).to eq([manager.email])
      expect(mail.from).to eq(["hello@rockburg.com"])
    end

    it "renders manager name" do
      expect(mail.body.encoded).to match(manager.name)
    end

    it "renders the body" do
      expect(mail.body.encoded).to match(/Your balance .* is getting low!/)
    end
  end

  describe "balance_negative" do
    let(:manager_mailer) { ManagerMailer }
    let(:manager) { create(:manager) }
    let(:mail) { manager_mailer.with(user: manager).balance_negative }

    it "renders the headers" do
      expect(mail.subject).to eq("[Rockburg] Balance is negative!")
      expect(mail.to).to eq([manager.email])
      expect(mail.from).to eq(["hello@rockburg.com"])
    end

    it "renders manager name" do
      expect(mail.body.encoded).to match(manager.name)
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Your balance has dropped below zero!")
    end
  end
end
