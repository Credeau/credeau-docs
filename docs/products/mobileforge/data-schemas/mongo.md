# MongoDB Data Schema

## Collections

### users

- **_id**: ObjectId
- **username**: String
- **email**: String
- **created_at**: DateTime

### sessions

- **_id**: ObjectId
- **user_id**: ObjectId (Reference to users)
- **token**: String
- **expires_at**: DateTime

## Indexes

- `users.email`: Unique
- `sessions.token`: Unique