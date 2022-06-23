# Ecommerce App

## App Specs

The application should consists of three screens:
 
### Store details & products screen:

```
Fetch the store detail from /storeInfo endpoint and display them in the upper part of the screen.
Fetch the list of products from /products endpoint and display them in a list below store detail section.
Add an ability for the user to select product(s). - Only one product selection
Add a button at the bottom most of the screen to bring the user to the order summary screen.
```

### Order summary screen:
```
Display the product(s) selected.
Display the total price.
Add one text box to allow user to fill in the delivery address.
Add a button at the bottom of the screen for the user to confirm order placement. Tapping on this button should display a loading indicator and make a request to post the data to /orderDone endpoint(store locally in jSOn). After the save successful request is completed, display a success screen.
```

### Success screen:
```
Show a simple dismiss button that brings the user back to the first screen.
```


## Model Specs

### Store Info

| Property      | Type                |
|---------------|---------------------|
| `id`          | `String`            |
| `name` 		| `String` 			  |
| `address`	    | `String` 			  |
| `phone`	    | `String`            |
| `website`	    | `String`            |

### Payload contract

```
GET /storeInfo

200 RESPONSE

{
	"items": [
		{
			"id": "store id",
			"name": "store name",
			"address": "store address",
			"phone": "store contact details",
			"website": "store website link"
		}
	]
}

Note: Currently as per the requirement we are displaying only one store, but we have kept the payload items of store in an array to accomodate multiple stores in the future.

```

### Products Info

| Property      | Type                |
|---------------|---------------------|
| `id`          | `String`            |
| `name` 		| `String` 			  |
| `price`	    | `String` 			  |
| `min_qty`	    | `String` (optional) |
| `max_qty`	    | `String` (optional) |

### Payload contract

```
GET /products

200 RESPONSE

{
	"items": [
		{
			"id": "product id",
			"name": "product name",
			"price": "product price"
		}
	]
}

Note: Currently for the demonstration we are allowing only one product to the cart, but we have kept the payload items of products in an array to accomodate multiple products in the future.

```

### Order Summary

| Property      | Type                |
|---------------|---------------------|
| `id`          | `String`            |
| `name` 		| `String` 			  |
| `price`	    | `String` 			  |

### Payload contract

```
POST /orderDone

2xx RESPONSE

{
	"items": [
		{
			"id": "product id",
			"name": "product name",
			"price": "product price"
		}
	],
	"totalPrice": "total price of the selected item(s)",
	"deliveryAddress": "address to deliver the product(s)"
}

```
