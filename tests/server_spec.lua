local http_request = require "http.request"
local http = require("socket.http")

describe('Milua', function()
    it('should respond to simple GET', function()
        local headers, stream = assert(http_request.new_from_uri("http://localhost:8800"):go())
        assert.are.equal("200", headers:get ":status")
        
        local body = assert(stream:get_body_as_string())
        assert.are.equal("<h1>Welcome to the <i>handsome</i> server!</h1>", body)

        assert.are.equal("text/html", headers:get "content-type")
    end)

    it('should respond 404 to unknown route', function()
        local headers, stream = assert(http_request.new_from_uri("http://localhost:8800/undef"):go())
        assert.are.equal("404", headers:get ":status")
        
        local body = assert(stream:get_body_as_string())
        assert.are.equal("Not found", body)

        assert.are.equal("text/plain", headers:get "content-type")
    end)

    it('should capture arguments and path segments', function()
        local headers, stream = assert(http_request.new_from_uri("http://localhost:8800/user/bob?times=3"):go())
        assert.are.equal("200", headers:get ":status")
        
        local body = assert(stream:get_body_as_string())
        assert.are.equal("The user bob is very very very handsome", body)
    end)

    it('should respond correctly to routs without data', function()
        local result, code, headers, status = http.request {
            method = "DELETE",
            url = "http://localhost:8800/user"
        }
        assert.are.equal(204, code)
        assert.are.equal('HTTP/1.1 204 No Content', status)
    end)
end)