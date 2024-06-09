# Space Tavern

## Overview

Space Tavern is an in-development game set in a futuristic human colony on a frontier planet. The game involves managing a tavern, interacting with patrons, and handling various events. All of the patrons and events are generated using the OpenAI API.

## Installation

### Prerequisites

- Ruby 3.3.2
- Bundler
- SQLite3
- Rails 7.1.3.4
- OpenAI API Key

### Setup

1. Clone the repository:

   ```sh
   git clone <repository_url>
   cd tavern-api
   ```

2. Install dependencies:

   ```sh
   gem install bundler
   bundle install
   ```

3. Prepare the database:

   ```sh
   bin/rails db:prepare
   ```

4. Set the OpenAI API Key in the .env file:

   ```sh
   OPENAI_API_KEY=<your_api_key>
   ```

5. Start the server:
   ```sh
   bin/rails server
   ```

## Development

### Current Features

- Patron management
- Event generation
- Time advancement
- Message management
- Game logic

### In Development

- Patron management
- Frontend integration
- Relationship management
- Economic management

### Running Tests

Execute the test suite:

```sh
bin/rails test
```

### Contributing

1. Fork the repository.
2. Create a feature branch.
3. Commit your changes.
4. Push to your fork.
5. Create a pull request.

### Contact

For any questions or suggestions, please open an issue or contact the maintainers.
