# Flutter CRUD App with Bloc and Clean Architecture

A simple Flutter CRUD application demonstrating Bloc and Clean Architecture principles. This app allows users to manage posts with basic Create, Read, Update, and Delete functionalities.

## Features

- Create Post
- Read Posts
- Update Post
- Delete Post

## Project Structure

- `lib/`
  - `data/`: Data sources and models
  - `domain/`: Business logic, entities, and use cases
  - `presentation/`: UI and state management with Bloc

## Getting Started

1. **Clone the repository**:
    ```bash
    git clone [https://github.com/Adithyalajeesh/crud_workshop].git
    cd flutter-crud-bloc-clean
    ```

2. **Install dependencies**:
    ```bash
    flutter pub get
    ```

3. **Run the application**:
    ```bash
    flutter run
    ```

## API Configuration

Configure the base URL in the `PostRepo` class. This app uses a REST API to manage posts.

### Example API Endpoints

- **GET** /posts: Fetch all posts
- **POST** /posts: Create a new post
- **PUT** /posts/{id}: Update a post
- **DELETE** /posts/{id}: Delete a post

## Verify API Endpoints Using Postman

1. **Install Postman**: [Download here](https://www.postman.com/downloads/)

2. **Create a new request**:
   - Method: Choose GET, POST, PUT, or DELETE
   - URL: Enter the endpoint URL (e.g., `https://jsonplaceholder.typicode.com/posts`)

3. **Set Headers** (if required):
   - `Content-Type`: `application/json`

4. **Set Body** (for POST and PUT requests):
   - Choose raw and select JSON
   - Enter the JSON data

5. **Send the request** and verify the response

### Example DELETE Request

- **Method**: DELETE
- **URL**: `https://jsonplaceholder.typicode.com/posts/1`
- **Response**: Status 200 OK

---

Thank you!
