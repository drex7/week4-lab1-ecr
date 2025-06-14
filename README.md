# Fullstack Blog App with NuxtJs (REST API)

This app implement a **fullstack app with [Nuxt](https://nuxtjs.org//)** using [Vue](https://vuejs.org/) (frontend) and **Prisma Client** with AWS RDS Pstgres DB.

## Getting started

### 1. Download example and navigate into the project directory

Clone this repository:

```
git clone repo-url
```

Install npm dependencies:

```
npm install
```

### 2. Create and seed the database

Run the following command to create your database. This also creates the `User` and `Post` tables that are defined in [`prisma/schema.prisma`](./prisma/schema.prisma):

```
npx prisma migrate dev --name init
```

Run `npx prisma migrate dev` against a newly created database, seeding is also triggered. The seed file in [`prisma/seed.ts`](./prisma/seed.ts) will be executed and your database will be populated with the sample data.

**Seed DB manually**,

```
npx prisma db seed
```


### 3. Start the app

```
npm run dev
```

### 3. Build for production

```
npm run build
```

The app is now running, navigate to [`http://localhost:3000/`](http://localhost:3000/) in your browser to explore its UI.

## Using the REST API

You can also access the REST API of the API server directly. It is running on the same host machine and port and can be accessed via the `/api` route (in this case that is `localhost:3000/api/`, so you can e.g. reach the API with [`localhost:3000/api/feed`](http://localhost:3000/api/feed)).

### `GET`

- `/api/post/:id`: Fetch a single post by its `id`
- `/api/feed`: Fetch all _published_ posts
- `/api/filterPosts?searchString={searchString}`: Filter posts by `title` or `content`

### `POST`

- `/api/post`: Create a new post
  - Body:
    - `title: String` (required): The title of the post
    - `content: String` (optional): The content of the post
    - `authorEmail: String` (required): The email of the user that creates the post
- `/api/user`: Create a new user
  - Body:
    - `email: String` (required): The email address of the user
    - `name: String` (optional): The name of the user

### `PUT`

- `/api/publish/:id`: Publish a post by its `id`

### `DELETE`

- `/api/post/:id`: Delete a post by its `id`

## Switch to another database (e.g. PostgreSQL, MySQL, SQL Server, MongoDB)