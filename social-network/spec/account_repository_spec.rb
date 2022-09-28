require 'account_repository'

RSpec.describe AccountRepository do 
  def reset_accounts_table
    seed_sql = File.read('spec/seeds_accounts.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'social_network_test' })
    connection.exec(seed_sql)
  end
  
  before(:each) do 
    reset_accounts_table
  end
  
  it "returns a list of all accounts" do
    repo = AccountRepository.new 

    accounts = repo.all

    expect(accounts.length).to eq(2)
    expect(accounts.first.id).to eq("1") 
    expect(accounts.first.username).to eq("username1") 
    expect(accounts.first.email).to eq("username1@fakeemail.com")
  end

  it "returns a single account" do
    repo = AccountRepository.new
    account = repo.find(1)

    expect(account.id).to eq("1")
    expect(account.username).to eq("username1")
    expect(account.email).to eq("username1@fakeemail.com")
  end

  it "returns another account" do
    repo = AccountRepository.new
    account = repo.find(2)

    expect(account.id).to eq("2")
    expect(account.username).to eq("username2")
    expect(account.email).to eq("username2@fakeemail.com")
  end

  it "creates a new account" do
    repo = AccountRepository.new
    
    new_account = Account.new
    new_account.username = 'username3'
    new_account.email = 'username3@fakeemail.com'

    repo.create(new_account)
    
    accounts = repo.all

    expect(accounts.length).to eq(3)
    expect(accounts.last.username).to eq('username3')
    expect(accounts.last.email).to eq('username3@fakeemail.com')
  end

  it "deletes an account" do 
    repo = AccountRepository.new
    id_to_delete = 1

    repo.delete(id_to_delete)
    
    all_accounts = repo.all
    expect(all_accounts.length).to eq(1)
    expect(all_accounts.first.id).to eq("2")
  end

  it "updates an account" do
    repo = AccountRepository.new
    account = repo.find(1)

    account.username = 'new-username'
    account.email = 'new-username@fakeemail.com'

    repo.update(account)

    updated_account = repo.find(1)

    expect(updated_account.username).to eq('new-username')
    expect(updated_account.email).to eq('new-username@fakeemail.com')
  end
end
