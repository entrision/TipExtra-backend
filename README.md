# Tip Extra Backend

# Connecting to the API
Requests to protected endpoints within the API must be issued with a
standard token Authorization HTTP header e.g. `"Authorization" => "Token
token=your-token"`

A User's Authorization token will be included in the JSON payload
returned at user creation, or upon session creation. Review those
sections below for more details.

# API Endpoints
The following lists the API's current endpoints, their associated
requests for interacting with them, and expected request formatting and
reults. The API current has an endpoint for [Users](###Users),
[Sessions](###Sessions), [Menus](###Menus), [Orders](###Orders), and
[Drinks](###Drinks)

### Users

##### `POST /api/v1/users`
Creates a new user record. Succesful requests respond with a `HTTP 201`
status and a JSON payload of the create user's information. An
Authorization token is NOT required for this action.

Example Request data:
```
{"user": {
  "first_name": "Guy",
  "last_name" : "Testman",
  "email"     : "guy@testman.com",
  "password"  : "5up3r5tr0ng!"
 }}
```

Example successful Response data:
```
{"user": {
  "first_name"            : "Guy",
  "last_name"             : "Testman",
  "email"                 : "guy@testman.com",
  "authentication_token"  : "Qz5t5Q_tnJZskx38DVzP",
  "braintree_customer_id" : "68640513"
}}
```

Example failure Response data:
```
{"errors" : {
  "email"      : ["is invalid"],
  "first_name" : ["can't be blank"]
}}
```

### Sessions

### Menus

##### `GET /api/v1/menus`
Returns a list of drink menus. Succesful requests respond with a `HTTP
200` status and a JSON payload of available menus.

Example Response:
```
{"menus":[
  {"id":1285,"name":"Brady's Bar"}
]}
```

##### `GET /api/v1/menus/:id`
Returns a drink menu resource, including drink information.

Example Response:
```
{"menu":{
  "id":1283,
  "name":"Brady's Bar",
  "drinks":[
    {"id":1323,"name":"Drink1","price":1000},
    {"id":1324,"name":"Drink2","price":1000},
    {"id":1325,"name":"Drink3","price":1000}
  ]}
}
```

### Orders

##### `GET /api/v1/orders`
Returns a list of the authenticated user's orders.

Example Response data:
```
{"orders" : [
  {"id":985,"drink_total":2,"order_total":2000},
  {"id":986,"drink_total":5,"order_total":4750}
]}
```

##### `GET /api/v1/orders/:id`
Returns order specific data.

Example Response data:
```
{"order" : {
  "id":1109,
  "line_items":[
    {
      "drink_id":1544,
      "qty":1,
      "cost":1000
    },{
      "drink_id":1545,
      "qty":1,
      "cost":1000
    }
  ]
}}
```

##### `POST /api/v1/orders`
Creates a new order.

Example Request data:
```
{"order": {
  "line_items_attributes" : [
    {
      "drink_id" : 123,
      "qty"      : 2
    },
    {
      "drink_id" : 124,
      "qty"      : 3
    },
    {
      "drink_id" : 144,
      "qty"      : 1
    }
  ]
}}
```

Example Response data:
```
{"order" : {
  "id":1239,
  "order_total":6000,
  "line_items" : [
    {"drink_id":123,"qty":2,"cost":2000},
    {"drink_id":124,"qty":3,"cost":3000},
    {"drink_id":144,"qty":1,"cost":1000}
  ]
}}
```

Example Failure response data:
```
{"errors":{
  "line_items.drink" : ["can't be blank"]
}}
```

### Drinks
