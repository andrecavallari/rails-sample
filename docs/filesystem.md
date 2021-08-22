# Filesystem documentation

This is the filesystem part of this app, you can create directories with subdirectories and upload files.

# Directories

## List directories

### Request
GET: `/filesystem/directories`

### Response
Code: 200 (OK)
```
{
  "directories": [
    {
      "id": 16,
      "created_at": "2021-08-19T17:58:35.838Z",
      "updated_at": "2021-08-19T17:58:35.838Z",
      "parent_id": null,
      "name": "Directory Name"
    }
  ],
  "files": [
    {
      "id": 18,
      "created_at": "2021-08-19T18:11:23.862Z",
      "updated_at": "2021-08-22T00:56:48.270Z",
      "parent_id": null,
      "name": "Document.pdf"
    }
  ]
}
```

## Create a directory

You can create a directory sending `name` (required) and `parent_id` (optional), the `parent_id` is the parent directory of the new directory

### Request
POST: `/filesystem/directories`

### Request body example
```
{
	"directory": {
		"name": "Directory name",
		"parent_id": 1
	}
}
```

### Response body example
```
{
  "id": 22,
  "created_at": "2021-08-19T18:14:32.401Z",
  "updated_at": "2021-08-19T18:14:32.401Z",
  "parent_id": 1,
  "name": "Directory name"
}
```

## Update a directory

To update a directory you can send `name` and/or `parent_id` as params, both are optional, but you should send one or other

### Request
PATCH `/filesystem/directories/:id`

### Request body example
```
{
	"directory": {
		"name": "New Name",
		"parent_id": 1
	}
}
```

### Response example
```
{
  "name": "New Name",
  "parent_id": null,
  "id": 20,
  "created_at": "2021-08-19T18:12:55.977Z",
  "updated_at": "2021-08-19T18:17:01.772Z"
}
```

## Delete a directory

This path only requires the id of the directory

### Request
DELETE `/filesystem/directories/:id`
