require "json"
require "http"
require "optparse"

class OpenTDB

    API_HOST = "https://opentdb.com/api.php?amount=1&type=multiple"
    NEW_TOKEN = "https://opentdb.com/api_token.php?command=request"



    def self.new_session_key
        response = HTTP.get(NEW_TOKEN)
        response.parse["token"]
    end

    def self.search_question(category_num, difficulty)
        url = "#{API_HOST}"
        params = {
            category: category_num,
            difficulty: difficulty
        }
        response = HTTP.get(url, params: params)
        response.parse["results"]
    end


end