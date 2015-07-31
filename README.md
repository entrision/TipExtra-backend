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
[Sessions](#Sessions), [Menus](#Menus), [Orders](#Orders), [Braintree](#braintree) and
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
  {"id":985,"drink_total":2,"customer_name": "Guy Testman", "order_total":2000},
  {"id":986,"drink_total":5,"customer_name": "Guy Testman", "order_total":4750}
]}
```

##### `GET /api/v1/orders/:id`
Returns order specific data.

Example Response data:
```
{"order" : {
  "id":1109,
  "customer_name": "Guy Testman"
  "line_items":[
    {
      "id":1544,
      "qty":1,
      "cost":1000,
      "drink": {
        "id":165,
        "name":"Drink9",
        "price":1000,
        "image": {
          "image_url":"https://entrision-tip-extra-test.s3.amazonaws.com/uploads/image/image/97/drink9.jpg",
          "thumb_url":"https://entrision-tip-extra-test.s3.amazonaws.com/uploads/image/image/97/thumb_drink9.jpg"}
      }
    },{
      "id":1545,
      "qty":1,
      "cost":1000
      "drink": {
        "id":166,
        "name":"Drink10",
        "price":1000,
        "image": {
          "image_url":"https://entrision-tip-extra-test.s3.amazonaws.com/uploads/image/image/97/drink10.jpg",
          "thumb_url":"https://entrision-tip-extra-test.s3.amazonaws.com/uploads/image/image/97/thumb_drink10.jpg"}
      }
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
  "customer_name": "Guy Testman"
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
  {"id":109,"drink_total":1,"order_total":1000, "customer_name": "Guy
  Testman"},
  {"id":110,"drink_total":1,"order_total":1000, "customer_name": "Guy
  Testman"}
]}
```

##### `GET /api/v1/menus/:menu_id/orders/:order_id`
Returns full order information for the order ID passed in.
The requesting user must be authenticated as the menu owner.
```
{"order":{
  "id":1109,
  "customer_name": "Guy Testman"
  "line_items":[ {
    "id":1544,
    "qty":1,
    "cost":1000,
    "drink": {
      "id":165,
      "name":"Drink9",
      "price":1000,
      "image": {
        "image_url":"https://entrision-tip-extra-test.s3.amazonaws.com/uploads/image/image/97/drink9.jpg",
        "thumb_url":"https://entrision-tip-extra-test.s3.amazonaws.com/uploads/image/image/97/thumb_drink9.jpg"}}
  }
}}
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
    {"drink_id":235,"qty":1,"cost":1000, "customer_name": "Guy Testman"}
  ]}
}
```

### Drinks<a name="drinks"></a>

### Braintree<a name="braintree"></a>
Endpoints relating to Braintree interactions.

##### `GET /api/v1/client_token`
Generates a Braintree client token. The Braintree docs say this should
be refreshed regularly, perhaps everytime the app is opened..?

Example Response data:
```
{"token":"eyJ2ZXJzaW9uIjoyLCJhdXRob3JpemF0aW9uRmluZ2VycHJpbnQiOiIxNGUxMzYxYWY1Y2Q3NTFlNDFkZDUyMzk0ZWY4OTY1MmEyNGMxY2YwMjRkNGZkZmMwNTQwYWIyOGJhZjAxOGVlfGNyZWF0ZWRfYXQ9MjAxNS0wNy0yOVQxODo0NjoxOC41MTI4OTQyNDErMDAwMFx1MDAyNm1lcmNoYW50X2lkPTNndHNqbWRuenZreWZrdzZcdTAwMjZwdWJsaWNfa2V5PXNkbno3N3RqamRqYm15a3ciLCJjb25maWdVcmwiOiJodHRwczovL2FwaS5zYW5kYm94LmJyYWludHJlZWdhdGV3YXkuY29tOjQ0My9tZXJjaGFudHMvM2d0c2ptZG56dmt5Zmt3Ni9jbGllbnRfYXBpL3YxL2NvbmZpZ3VyYXRpb24iLCJjaGFsbGVuZ2VzIjpbXSwiZW52aXJvbm1lbnQiOiJzYW5kYm94IiwiY2xpZW50QXBpVXJsIjoiaHR0cHM6Ly9hcGkuc2FuZGJveC5icmFpbnRyZWVnYXRld2F5LmNvbTo0NDMvbWVyY2hhbnRzLzNndHNqbWRuenZreWZrdzYvY2xpZW50X2FwaSIsImFzc2V0c1VybCI6Imh0dHBzOi8vYXNzZXRzLmJyYWludHJlZWdhdGV3YXkuY29tIiwiYXV0aFVybCI6Imh0dHBzOi8vYXV0aC52ZW5tby5zYW5kYm94LmJyYWludHJlZWdhdGV3YXkuY29tIiwiYW5hbHl0aWNzIjp7InVybCI6Imh0dHBzOi8vY2xpZW50LWFuYWx5dGljcy5zYW5kYm94LmJyYWludHJlZWdhdGV3YXkuY29tIn0sInRocmVlRFNlY3VyZUVuYWJsZWQiOnRydWUsInRocmVlRFNlY3VyZSI6eyJsb29rdXBVcmwiOiJodHRwczovL2FwaS5zYW5kYm94LmJyYWludHJlZWdhdGV3YXkuY29tOjQ0My9tZXJjaGFudHMvM2d0c2ptZG56dmt5Zmt3Ni90aHJlZV9kX3NlY3VyZS9sb29rdXAifSwicGF5cGFsRW5hYmxlZCI6dHJ1ZSwicGF5cGFsIjp7ImRpc3BsYXlOYW1lIjoiRW50cmlzaW9uLCBMTEMiLCJjbGllbnRJZCI6bnVsbCwicHJpdmFjeVVybCI6Imh0dHA6Ly9leGFtcGxlLmNvbS9wcCIsInVzZXJBZ3JlZW1lbnRVcmwiOiJodHRwOi8vZXhhbXBsZS5jb20vdG9zIiwiYmFzZVVybCI6Imh0dHBzOi8vYXNzZXRzLmJyYWludHJlZWdhdGV3YXkuY29tIiwiYXNzZXRzVXJsIjoiaHR0cHM6Ly9jaGVja291dC5wYXlwYWwuY29tIiwiZGlyZWN0QmFzZVVybCI6bnVsbCwiYWxsb3dIdHRwIjp0cnVlLCJlbnZpcm9ubWVudE5vTmV0d29yayI6dHJ1ZSwiZW52aXJvbm1lbnQiOiJvZmZsaW5lIiwidW52ZXR0ZWRNZXJjaGFudCI6ZmFsc2UsImJyYWludHJlZUNsaWVudElkIjoibWFzdGVyY2xpZW50MyIsIm1lcmNoYW50QWNjb3VudElkIjoiZW50cmlzaW9ubGxjIiwiY3VycmVuY3lJc29Db2RlIjoiVVNEIn0sImNvaW5iYXNlRW5hYmxlZCI6ZmFsc2UsIm1lcmNoYW50SWQiOiIzZ3Rzam1kbnp2a3lma3c2IiwidmVubW8iOiJvZmYifQ=="}
```

###### `POST /api/v1/payment_nonce`
Creates a payment method for the authenticated user and associates it
with their Braintree Customer. Must pass a valid payment nonce to this
endpoint. Successful requests respond with `HTTP 201` status.

Example Request data:
```
{"payment": { "nonce": "fake-valid-nonce" }}
```

