# Backend Training session

Pet Project: Blog App (https://employmenthero.atlassian.net/wiki/spaces/GT/pages/3369402701/Pet+Project+Blog+App+-+Detailed+Guide)

## Configuration
1. Clone this repo
2. Open the console and run the below command.
```
bundle install
```

## Database creation
Run command
```
bundle exec rake db:create:all
bundle exec rake db:migrate
```

## APIs:

**Sign Up**

- POST /api/users

- Request body:
```
{ 
  "user": { 
    "email": "user@example.com", 
    "password": "password",
    "password_confirmation": "password" 
  } 
}
```



https://github.com/user-attachments/assets/f4bb85b7-889a-4665-a6b4-f5dd51df6232




**Sign In**

- POST /api/users/sign_in

- Request body:
```
{ 
  "user": { 
    "email": "user@example.com", 
    "password": "password" 
  } 
}
```

<img width="1279" alt="Untitled" src="https://github.com/user-attachments/assets/432c97b5-425a-4078-9022-1f2d881d17ee" />



**Create a Blog (Authenticated)**

- POST /api/blogs

- Request body:
```
{
  "blog": {
    "title": "Blog Post Title",
    "content": "This is the content of the blog post."
  }
}
```
<img width="1265" alt="Untitled" src="https://github.com/user-attachments/assets/00298748-e7d7-4b1c-9676-6feb26824ff3" />




**Get All Blogs**

- GET /api/blogs

- Response:
```
{
  data: [
      {
        "id": 1,
        "title": "Blog Post Title",
        "content": "This is the content of the blog post.",
        "user_id": 1,
        "created_at": "2025-01-01T00:00:00Z",
        "updated_at": "2025-01-01T00:00:00Z"
      }
  ]
}
```


<img width="1266" alt="Untitled" src="https://github.com/user-attachments/assets/1fceb5db-34d4-408e-8e2d-bb92d497e327" />


**Get a Specific Blog by ID**

- GET /api/blogs/:id

- Response:
```
{
  data: {
    "id": 1,
    "title": "Blog Post Title",
    "content": "This is the content of the blog post.",
    "user_id": 1,
    "created_at": "2025-01-01T00:00:00Z",
    "updated_at": "2025-01-01T00:00:00Z"
  }
}
```

<img width="1220" alt="Untitled" src="https://github.com/user-attachments/assets/e8a0c71f-d297-4e9b-9dd2-eeeb714ba283" />




**Update a Blog (Authenticated, own blog only)**

- PUT /api/blogs/:id

- Request body:
```
{
  "blog": {
    "title": "Updated Blog Post Title",
    "content": "This is the updated content of the blog post."
  }
}
```
<img width="1185" alt="Untitled" src="https://github.com/user-attachments/assets/95b2c4d1-afa6-4e8c-ad4e-d2bfc455a633" />





**Delete a Blog (Authenticated, own blog only)**

- DELETE /api/blogs/:id

<img width="1250" alt="Untitled" src="https://github.com/user-attachments/assets/79f1a257-c6c5-4d01-8b05-b8c8cc659999" />




**Create a Comment (Authenticated)**

- POST /api/blogs/:blog_id/comments

- Request body:
```
{
  "comment": {
    "content": "This is a comment on the blog post."
  }
}
```


<img width="1269" alt="Untitled" src="https://github.com/user-attachments/assets/429643fc-b60b-4b84-a7e4-7e6c3bff23fc" />



**Get All Comments for a Blog**

- GET /api/blogs/:blog_id/comments

- Response:
```
{
  data: [
    {
      "id": 1,
      "content": "This is a comment on the blog post.",
      "user_id": 1,
      "blog_id": 1,
      "created_at": "2025-01-01T00:00:00Z",
      "updated_at": "2025-01-01T00:00:00Z"
    }
  ]
}
```
<img width="1258" alt="Untitled" src="https://github.com/user-attachments/assets/89d091d9-b480-4415-9192-7393750b7ef5" />

