import ballerina/http;
import ballerina/constraint;

# Provides a set of configurations for controlling the behaviours when communicating with a remote HTTP endpoint.
@display {label: "Connection Config"}
public type ConnectionConfig record {|
    # The HTTP version understood by the client
    http:HttpVersion httpVersion = http:HTTP_2_0;
    # Configurations related to HTTP/1.x protocol
    ClientHttp1Settings http1Settings?;
    # Configurations related to HTTP/2 protocol
    http:ClientHttp2Settings http2Settings?;
    # The maximum time to wait (in seconds) for a response before closing the connection
    decimal timeout = 60;
    # The choice of setting `forwarded`/`x-forwarded` header
    string forwarded = "disable";
    # Configurations associated with request pooling
    http:PoolConfiguration poolConfig?;
    # HTTP caching related configurations
    http:CacheConfig cache?;
    # Specifies the way of handling compression (`accept-encoding`) header
    http:Compression compression = http:COMPRESSION_AUTO;
    # Configurations associated with the behaviour of the Circuit Breaker
    http:CircuitBreakerConfig circuitBreaker?;
    # Configurations associated with retrying
    http:RetryConfig retryConfig?;
    # Configurations associated with inbound response size limits
    http:ResponseLimitConfigs responseLimits?;
    # SSL/TLS-related options
    http:ClientSecureSocket secureSocket?;
    # Proxy server related options
    http:ProxyConfig proxy?;
    # Enables the inbound payload validation functionality which provided by the constraint package. Enabled by default
    boolean validation = true;
|};

# Provides settings related to HTTP/1.x protocol.
public type ClientHttp1Settings record {|
    # Specifies whether to reuse a connection for multiple requests
    http:KeepAlive keepAlive = http:KEEPALIVE_AUTO;
    # The chunking behaviour of the request
    http:Chunking chunking = http:CHUNKING_AUTO;
    # Proxy server related options
    ProxyConfig proxy?;
|};

# Proxy server configurations to be used with the HTTP client endpoint.
public type ProxyConfig record {|
    # Host name of the proxy server
    string host = "";
    # Proxy server port
    int port = 0;
    # Proxy server username
    string userName = "";
    # Proxy server password
    @display {label: "", kind: "password"}
    string password = "";
|};

public type NotFoundAddressDetailedObject record {|
    *http:NotFound;
    AddressDetailedObject body;
|};

# building details of an address
public type Building record {
    # Number that identifies the position of a building on a street.
    anydata number?;
    # Name of the building or house.
    anydata name?;
};

# Validity of this address
public type Validity anydata;

# Defines Axxiome Digital address model (including both structured and unstructrured data format) for entries to be created or updated.
public type AddressCreateObject record {
    # Address usage type (Shipping address, permanent address, holiday address)
    anydata 'type;
    # Default flag selected determines which address should be used in case there are multiple of the same type defined for a customer.
    anydata default?;
    # Validity of this address
    Validity validity?;
    # Address stuctured data (components defined as single fields)
    AddressStructured structuredAddress?;
    # Address unstructured data (components defined as lines)
    AddressUnstructured unstructuredAddress?;
    # Object including address properties
    AddressAdditions additions?;
};

# 
public type User record {
    # Unique identifier for the given user.
    anydata id;
    anydata firstName;
    anydata lastName;
    anydata email;
    anydata dateOfBirth?;
    # Set to true if the user's email has been verified.
    anydata emailVerified;
    # The date that the user was created.
    anydata createDate?;
};

# Object including address properties
public type AddressAdditions record {
    # Defines Axxiome Digital model including data specific for correspondence shipping.
    ShippingAddressAdditions shippingAddress?;
    # Contains the party or service which was used for address confirmation purposes
    anydata addressValidationServiceProvider?;
    # You can put the reason for non-delivery to the address in this field (usually relates to the PO box).
    anydata undeliverableReason?;
};

# Defines Axxiome Digital model including data specific for correspondence shipping.
public type ShippingAddressAdditions record {
    # Name by which a party is known and which is usually used to identify that party.
    anydata name?;
    PhoneNumber phoneNumber?;
};

# Address unstructured data (components defined as lines)
public type AddressUnstructured record {
    # Address presented as list of lines (e.g. Address Line 1, Address Line 2 usually up to 5). Consistency depends on the address specification (PO box, personal, company) and national post regulations
    anydata addressLines?;
    # Country ISO code
    anydata country?;
};

# Defines Axxiome Digital address model (including both structured and unstructrured data format) for existing data.
public type AddressDetailedObject anydata;

public type PhoneNumber anydata;

# The delivery service is part of the PO box address. Some countries offer different services in addition to regular postal delivery and PO boxes, for example the Private Bag or Response Bag. If an address is related to one of these delivery services, the information about this particular delivery service has to be entered in the corresponding fields.
public type PostBox record {
    # Numbered box in a post office, assigned to a person or organisation, where letters are kept until called for.
    anydata number?;
    # The delivery service is part of the PO box address. Some countries offer different services in addition to regular postal delivery and PO boxes, for example the Private Bag or Response Bag. If an address is related to one of these delivery services, the information about this particular delivery service has to be entered in the corresponding fields.
    anydata deliveryType?;
};

# Address stuctured data (components defined as single fields)
public type AddressStructured record {
    # Country ISO code
    anydata country?;
    # The highest level of a country's administrative division (e.g. state, state, canton, county)
    anydata countrySubDivision?;
    # Identifies a subdivision within a country sub-division. Second level of a country's administrative division (e.g. county, landkreis)
    anydata districtName?;
    # Town / City name
    anydata townName?;
    # Postal Code (mask dependent on country): dentifier consisting of a group of letters and/or numbers that is added to a postal address to assist the sorting of mail.
    anydata postCode?;
    # Street: Name of a street or thoroughfare.
    anydata streetName?;
    # building details of an address
    Building building?;
    # Room: Flat/Appartment number.
    anydata room?;
    # The delivery service is part of the PO box address. Some countries offer different services in addition to regular postal delivery and PO boxes, for example the Private Bag or Response Bag. If an address is related to one of these delivery services, the information about this particular delivery service has to be entered in the corresponding fields.
    PostBox postBox?;
    # C/O - care of. This abbreviation is used in addresses when you are sending a letter or package to a person by using someone else's address or the address of a company.
    anydata careOf?;
    # Floor or storey within a building.
    anydata floor?;
    # Secondary address unit designator - identification of a division of a large organisation or building.
    anydata department?;
    # Identification of a sub-division of a large organisation or building.
    anydata subDepartment?;
};
