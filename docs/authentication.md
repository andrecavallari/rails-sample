# Authentication

The authentication for this app, almost every route in this app is designed to be protected by bearer token, to generate a bearer token you need to authenticate with the app, and you get a six hours valid token wich you can revoke anytime.

On every request you need to send the bearer token in the header, like this:

```
Authorization: Bearer <token>
```

* [Login](#login)
* [Logout](#logout)

## Login

### Request
- POST: `/auth/login`

### Response
Code: 200 (OK)
```json
{
  "token": "<your bearer token>"
}
```

## Logout

### Request
- DELETE: `/auth/logout`
- Headers: `Authorization: Bearer <token>`

### Response
Code: 204 (No Content)
