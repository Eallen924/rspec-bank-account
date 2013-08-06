require "rspec"

require_relative "account"

describe Account do

  let(:short_acct_number) {'12345'}
  let(:account_number)   { '1234567890' }
  let(:account)       { Account.new(account_number)}

  describe "#initialize" do
    context "with valid input" do 
      it "creates a new Account with account number argument" do
        expect(account).not_to eq(nil)
      end
    end

    context "with invalid input" do 
      it "raises invalid account number error" do 
        expect { Account.new('12345')}.to raise_error InvalidAccountNumberError
      end
    end
  end

  describe "#transactions" do
    it "returns an array" do
      expect(account.transactions.class).to eq(Array)
    end
  end

  describe "#balance" do
    it "creates an Account with balance 0 if no balance is passed" do
      expect(account.balance).to eq(0)
    end

    it "returns a valid balance given an array of transactions" do
      account.stub(transactions: [0,1,2,3,4,5])
      expect(account.balance).to eq(15)
    end
  end

  describe "#account_number" do
    it "returns a hidden account number" do 
      expect(account.account_number).to eq("******7890")
    end
  end

  describe "deposit!" do
    it "raises an negative deposit error is the argument < 0 " do
      expect { account.deposit!(-10) }.to raise_error NegativeDepositError
    end

    it "returns the new balance of the account when money is deposited" do
        expect(account.deposit!(rand(10))).to eq(account.balance)
    end
  end

  describe "#withdraw!" do
    it "raises an overdraft error if balance - amount < 0 " do
      expect { account.withdraw!(10) }.to raise_error OverdraftError    
    end

    it "returns the new balance of the account when money is withdrawn" do
        account.stub(balance: 50)
        expect(account.withdraw!(25)).to eq(account.balance)
    end
  end
end
