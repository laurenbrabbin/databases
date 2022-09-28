require_relative './database_connection'
require_relative './account'

class AccountRepository
  def all
    sql = 'SELECT id, username, email FROM accounts'
    result_set = DatabaseConnection.exec_params(sql, [])
    
    accounts = []

    result_set.each do |record|
      account = Account.new
      account.id = record['id']
      account.username = record['username']
      account.email = record['email']

      accounts << account
    end
    return accounts
  end
  def find(id)
    sql = 'SELECT id, username, email FROM accounts WHERE id = $1'
    sql_params = [id]
    result_set = DatabaseConnection.exec_params(sql, sql_params)
    
    record = result_set[0]

    account = Account.new
    account.id = record['id']
    account.username = record['username']
    account.email = record['email']

    return account
  end

  def create(account)
    sql = 'INSERT INTO accounts (username, email) VALUES($1, $2);'
    sql_params = [account.username, account.email]
    result_set = DatabaseConnection.exec_params(sql, sql_params)

    return nil
  end

  def delete(id)
    sql = 'DELETE FROM accounts WHERE id = $1'
    sql_params = [id]
    result_set = DatabaseConnection.exec_params(sql, sql_params)

    return nil
  end

  def update(account)
    sql = 'UPDATE accounts SET username = $1, email = $2 WHERE id = $3'
    sql_params = [account.username, account.email, account.id]

    result_set = DatabaseConnection.exec_params(sql, sql_params)

    return nil
  end
end