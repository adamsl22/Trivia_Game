require "json"
require "http"
require "optparse"

class OpenTDB

    API_HOST = "https://opentdb.com/api.php?amount=10"


    def self.api
        response = HTTP.get("https://opentdb.com/api.php?amount=10&category=11&difficulty=hard&type=multiple")
        response.parse["results"]
    end


end