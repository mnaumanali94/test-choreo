import ballerina/http;

listener http:Listener ep0 = new (3000, config = {host: "localhost"});

service / on ep0 {
    # Get User Info by User ID
    #
    # + return - User Not Found 
    resource function get users() returns NotFoundAddressDetailedObject {
    }
    # 
    #
    # + return - return value description 
    resource function patch users() {
    }
}
