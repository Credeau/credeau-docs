# PostgreSQL Data Schema

## Tables

### users

- **id**: SERIAL PRIMARY KEY
- **username**: VARCHAR(50)
- **email**: VARCHAR(100)
- **created_at**: TIMESTAMP

### sessions

- **id**: SERIAL PRIMARY KEY
- **user_id**: INTEGER REFERENCES users(id)
- **token**: VARCHAR(255)
- **expires_at**: TIMESTAMP

## Indexes

- `users_email_idx` on users(email)
- `sessions_token_idx` on sessions(token)