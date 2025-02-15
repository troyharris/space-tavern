# Technical Context

## Technology Stack

1. Backend Framework

   - Ruby on Rails 7.1.3.4
   - Ruby version specified in .ruby-version

2. Database

   - PostgreSQL
   - Active Record ORM

3. Frontend

   - Hotwire for real-time updates
   - Turbo for page updates
   - Tailwind CSS for styling

4. AI Integration

   - OpenAI GPT via ruby-openai gem
   - Structured prompt system

## Development Setup

1. Required Environment Variables

   - Database configuration
   - OpenAI API key
   - Rails environment settings

2. Development Tools

   - Procfile.dev for development server
   - Docker support (Dockerfile present)
   - bin/dev for local development

## Dependencies

1. Key Gems

   - ruby-openai for AI integration
   - Tailwind CSS for styling
   - Standard development/test gems

2. Development Dependencies

   - Standard Rails testing framework
   - System test capabilities

## Technical Constraints

1. AI Integration

   - Requires valid OpenAI API key
   - Rate limiting considerations
   - Prompt engineering requirements

2. Database

   - PostgreSQL specific features
   - Complex relationships between models

3. Frontend

   - Turbo/Hotwire conventions
   - Tailwind CSS structure

## Infrastructure

1. Development

   - Local PostgreSQL database
   - Local development server
   - Docker container support

2. Testing

   - Standard Rails testing setup
   - Fixtures for test data
   - System tests for integration testing

## Security Considerations

1. API Security

   - Protected OpenAI API key
   - Standard Rails security features
   - Environment-based configuration

2. Data Security

   - Database encryption where necessary
   - Secure environment variable handling
   - Standard Rails security practices
