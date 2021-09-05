# Simple Store

This is the simple store example, you can create segments and create a calculation for final price for each product based on the segment, for example, if you have a product with price of $100 in a segment wich have a calculation `price + (price * 0.1)` then the final price for this product will be $110.

# Contents

* [Segments](#segments)
  * [List segments](#list-segments)]
  * [Create segment](#create-segment)
  * [Update segment](#update-segment)
  * [Delete segment](#delete-segment)
* [Products](#products)
  * [List products](#list-products)
  * [Create product](#create-product)
  * [Update product](#update-product)
  * [Delete product](#delete-product)

# Segments

The segments are like categories, you can create segments and assign them to products, each segment can have it´s own calculation.

## List segments

### Request
- GET `/store/segments`
- Headers: `Authorization: Bearer <token>`

### Response body
```json
[
  {
    "id": 1,
    "created_at": "2021-08-21T20:38:08.141Z",
    "updated_at": "2021-08-21T20:38:08.141Z",
    "name": "National",
    "operation": "price - (price * 0.1)"
  },
  {
    "id": 2,
    "created_at": "2021-08-21T20:38:22.763Z",
    "updated_at": "2021-08-21T20:38:22.763Z",
    "name": "Importe",
    "operation": "price + (price * 0.1)"
  }
]
```

## Create segment

In the `operation` param a variable named `price` should be used for the price value, for example to have a 10% of discount for the price of the product, you can use the following calculation: `price - (price * 0.1)`, and apply this segment to the product.

### Request
- POST `/products/segments`
- Headers: `Authorization: Bearer <token>`

### Request body
```json
{
  "segment": {
    "name": "Imported",
    "operation": "price + (price * 0.10)"
  }
}
```

### Response body
```json
{
  "id": 1,
  "created_at": "2021-08-21T20:39:08.064Z",
  "updated_at": "2021-08-21T20:39:08.064Z",
  "name": "Imported",
  "operation": "price + (price * 0.10)"
}
```

## Update segment

You can update the segment name and the operation, in the operation param a valid calculation using `price` as product price value should be used.

### Request
- PATCH `/store/segments/:id`
- Headers: `Authorization: Bearer <token>`

```json
{
  "segment": {
    "name": "Imported",
    "operation": "price + (price * 0.35)"
  }
}
```

### Response
```json
{
  "operation": "price + (price * 0.35)",
  "id": 3,
  "created_at": "2021-08-21T20:38:30.868Z",
  "updated_at": "2021-08-21T20:38:58.601Z",
  "name": "Imported"
}
```

## Delete segment

This deletes a segment, but it´s restricted to not be assigned to any product, otherwise it will return an error.
### Request
- DELETE `/store/segments/:id`
- Headers: `Authorization: Bearer <token>`

# Products

## List products

### Request
- GET `/store/products`
- Headers: `Authorization: Bearer <token>`

### Response body
```json
[
  {
    "id": 1,
    "created_at": "2021-08-21T20:42:05.475Z",
    "updated_at": "2021-08-21T20:42:05.475Z",
    "name": "Notebook",
    "price": 1000.0,
    "final_price": 900.0,
    "segment_id": 1
  },
  {
    "id": 2,
    "created_at": "2021-08-21T20:42:17.216Z",
    "updated_at": "2021-08-21T20:42:17.216Z",
    "name": "Mouse",
    "price": 100.0,
    "final_price": 150.0,
    "segment_id": 2
  },
]
```

## Create product

Creates a product, the params should be `name`, `price` and `segment_id` only, a `final_price` will be calculated based on the segment assigned to the product.

### Request
- POST `/store/products`
- Headers: `Authorization: Bearer <token>`

```json
{
  "product": {
    "name": "Gamer notebook",
    "price": 1000.0,
    "segment_id": 1
	}
}
```

### Response
```json
{
  "id": 4,
  "created_at": "2021-08-21T20:42:22.671Z",
  "updated_at": "2021-08-21T20:42:22.671Z",
  "name": "Gamer notebook",
  "price": 1000.0,
  "final_price": 1150.0,
  "segment_id": 1
}
```

## Update product

Like the create product, you can update the product `name`, `price` and `segment_id`, and the final price will be calculated based on the segment assigned to the product.

### Request
- PATCH `/store/products/:id`
- Headers: `Authorization: Bearer <token>`

```json
{
  "product": {
    "price": 10000.0,
    "segment_id": 2,
    "name": "Top notebook"
  }
}
```

### Response body
```json
{
  "price": 10000.0,
  "id": 1,
  "final_price": 13500.0,
  "created_at": "2021-08-21T20:42:22.671Z",
  "updated_at": "2021-08-21T20:42:45.612Z",
  "name": "Top notebook",
  "segment_id": 2
}
```

## Delete product

This will delete the product

### Request
- DELETE `/store/products/:id`
- Headers: `Authorization: Bearer <token>`
