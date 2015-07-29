# Tip Extra Backend

# Connecting to the API
Requests to protected endpoints within the API must be issued with a
standard token Authorization HTTP header e.g. `Authorization: Token
token=your-token`

A User's Authorization token will be included in the JSON payload
returned at user creation, or upon session creation. Review those
sections below for more details.

# API Endpoints
The following lists the API's current endpoints, their associated
requests for interacting with them, and expected request formatting and
reults. The API current has an endpoint for [Users](#users),
[Sessions](#Sessions), [Menus](#Menus), [Orders](#Orders), and
[Drinks](#Drinks)

### Users<a name="users"></a>

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

### Sessions<a name="sessions"></a>
Sign users in and out.

##### `POST /api/v1/sessions`
Signs a user in. Successful requests respond with `HTTP 200`.

Example Request Data:
```
{"user":{
  "email"    : "guy@testman.com",
  "password" : "p4ssw0rd"
}}
```

Example Response data:
```
{"user" : {
  "id"                    : 733,
  "first_name"            : "Guy",
  "last_name"             : "Testman",
  "email"                 : "test_1@tipextra.com",
  "authentication_token"  : "-tBaDFjDoTzS2snzJiJa",
  "braintree_customer_id" : "23237209"}}
```

Example failure response data:
```
{"errors" :
  {"login" : ["Invalid email or password"]
}}
```

##### `DELETE /api/v1/sessions`
Signs a user out. This clears the auth token from the database. Successful requests respond with `HTTP 204`.

### Menus<a name="menus"></a>

##### `GET /api/v1/menus`
Returns a list of drink menus. Succesful requests respond with a `HTTP
200` status and a JSON payload of available menus.

Example Response:
```
{"menus":[
  {"id":1285,"name":"Brady's Bar", "service_enabled": true}
]}
```

##### `GET /api/v1/menus/:id`
Returns a drink menu resource, including drink information.

Example Response data:
```
{"menu":{
  "id":1283,
  "name":"Brady's Bar",
  "service_enabled": true,
  "drinks":[
    {"id":97,"name":"Drink1","price":1000, "image":{
      "image_url":"https://entrision-tip-extra-test.s3.amazonaws.com/uploads/image/image/97/drink1.jpg",
      "thumb_url":"https://entrision-tip-extra-test.s3.amazonaws.com/uploads/image/image/97/thumb_drink1.jpg"}},
    {"id":98,"name":"Drink2","price":1000, "image":{
      "image_url":"https://entrision-tip-extra-test.s3.amazonaws.com/uploads/image/image/98/drink2.jpg",
      "thumb_url":"https://entrision-tip-extra-test.s3.amazonaws.com/uploads/image/image/98/thumb_drink2.jpg"}},
    {"id":99,"name":"Drink3","price":1000, "image":{
      "image_url":"https://entrision-tip-extra-test.s3.amazonaws.com/uploads/image/image/99/drink3.jpg",
      "thumb_url":"https://entrision-tip-extra-test.s3.amazonaws.com/uploads/image/image/99/thumb_drink3.jpg"}}
  ]}
}
```

##### `PATCH /api/v1/menus/:id`
Updates the menu. You must be authenticated as the Menu owner user in
order to utilize this endpoint, others will receive `HTTP 403 Access
Denied`.

Example Request data:
```
{"menu": {
  "service_enabled": false
}}
```

Example Response data:
```
{"menu" : {
  "id":33,
  "name":"Brady's Bar",
  "service_enabled":false,
  "drinks":[
    {"id":97,"name":"Drink1","price":1000, "image":{
      "image_url":"https://entrision-tip-extra-test.s3.amazonaws.com/uploads/image/image/97/drink1.jpg",
      "thumb_url":"https://entrision-tip-extra-test.s3.amazonaws.com/uploads/image/image/97/thumb_drink1.jpg"}},
    {"id":98,"name":"Drink2","price":1000, "image":{
      "image_url":"https://entrision-tip-extra-test.s3.amazonaws.com/uploads/image/image/98/drink2.jpg",
      "thumb_url":"https://entrision-tip-extra-test.s3.amazonaws.com/uploads/image/image/98/thumb_drink2.jpg"}},
    {"id":99,"name":"Drink3","price":1000, "image":{
      "image_url":"https://entrision-tip-extra-test.s3.amazonaws.com/uploads/image/image/99/drink3.jpg",
      "thumb_url":"https://entrision-tip-extra-test.s3.amazonaws.com/uploads/image/image/99/thumb_drink3.jpg"}}
  ]
}}
```

Example failure data:
```
{"errors":{"message":"Access Denied"}}
```

### Orders<a name="orders"></a>

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

##### `GET /api/v1/menus/:menu_id/orders`
Returns a list of non-complete orders placed from the menu ID passed in.
The requesting user must be authenticated as the menu owner.

Example Response data:
```
{"menu_orders":[
  {"id":109,"drink_total":1,"order_total":1000},
  {"id":110,"drink_total":1,"order_total":1000}
]}
```

##### `GET /api/v1/menus/:menu_id/orders/:order_id`
Returns full order information for the order ID passed in.
The requesting user must be authenticated as the menu owner.
```
{"order":
  {"id":239,"order_total":1000,"line_items":[
    {"drink_id":235,"qty":1,"cost":1000}
  ]}
}
```
##### `PATCH /api/v1/menus/:menu_id/orders/:order_id`
Updates the order. You must be authenticated as the Menu owner user in
order to utilize this endpoint, others will receive `HTTP 403 Access
Denied`.

Example Request data:
```
{"order": {
  "complete": true
}}
```

Example Response data:
```
{"order":
  {"id":239,"order_total":1000,"line_items":[
    {"drink_id":235,"qty":1,"cost":1000}
  ]}
}
```

### Drinks<a name="drinks"></a>
