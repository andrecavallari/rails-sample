# Filesystem documentation

This is the filesystem part of this app, you can create directories with subdirectories and upload files.

* [Directories](#directories)
  * [List directories](#list-directories)
  * [Create directory](#create-a-directory)
  * [Update directory](#update-a-directory)
  * [Delete directory](#delete-a-directory)
* [Files](#files)
  * [Upload a file](#upload-a-file)
  * [Update a file](#update-a-file)
  * [Delete a file](#delete-a-file)

# Directories

## List directories

### Request
GET: `/filesystem/directories`

### Response
Code: 200 (OK)
```json
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
```json
{
	"directory": {
		"name": "Directory name",
		"parent_id": 1
	}
}
```

### Response body example
```json
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
```json
{
	"directory": {
		"name": "New Name",
		"parent_id": 1
	}
}
```

### Response example
```json
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

# Files

Here you can upload, update or delete a file

## Upload a file

### Request
POST `/filesystem/files`
Type: multipart/form-data

### Params
* file[content] \<Attached file to upload\>
* file[parent_id] (optional) \<The id of the folder\>

### Response
Code: 200 (OK)
```json
{
  "id": 23,
  "created_at": "2021-08-22T01:08:12.619Z",
  "updated_at": "2021-08-22T01:08:12.632Z",
  "parent_id": null,
  "name": "Document.pdf"
}
```

## Update a file

You can only update wich directory the file will be stored, passing the argument `parent_id` to the request

### Request
PATCH `/filesystem/files/:id`

### Request body example
```json
{
	"file": {
		"parent_id": 1
	}
}
```


### Response example
```json
{
  "parent_id": null,
  "id": 18,
  "created_at": "2021-08-19T18:11:23.862Z",
  "updated_at": "2021-08-22T00:56:48.270Z",
  "name": "Document.pdf"
}
```

## Delete a file

This deletes a file
### Request
DELETE `/filesystem/files/:id`
