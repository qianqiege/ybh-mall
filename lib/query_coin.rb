require 'net/http'

class QueryCoin
  def self.query(username, password)
    return if username.nil? || password.nil?
    uri = URI("http://lab.imjs.work/rubbishWebsite/?username=#{username}&password=#{password}")
    result = JSON.parse Net::HTTP.get(uri)
    return false if result["status"] && result["status"] == "error"
    {HeldCoins: result["d"]["DashBoardNotificationViewModel"]["HeldCoins"], CoinsAvailable: result["d"]["DashBoardNotificationViewModel"]["CoinsAvailable"], CashAccount: result["d"]["EwalletAccountViewModel"]["CashAccount"]}
  end
end
