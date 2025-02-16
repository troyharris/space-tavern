# System Patterns

## Architecture Overview

The system follows a service-oriented architecture within the Rails framework, with clear separation of concerns:

### Core Services

1. Game Logic Services

   - `CreateNewGameService`: Initializes new game instances
   - `AdvanceTimeService`: Handles time progression
   - `CreateRelationshipsService`: Manages patron relationships
   - `UpdateGameHistory`: Records game events and changes
   - `FinancialService`: Manages tavern finances
     - Beer inventory management
     - Price adjustments
     - Financial event processing
     - Transaction handling

2. GPT Manager Services

   - `GptChat`: Core AI interaction service
   - `CreateEvent`: Generates game events
   - `CreateHistory`: Builds narrative history
   - `CreatePatrons`: Generates new patrons

3. Event/Patron/Message Services

   - `EventService`: Manages event lifecycle
   - `PatronService`: Handles patron operations
   - `MessageService`: Manages game messages

## Design Patterns

1. Service Objects

   - Business logic encapsulated in service classes
   - Clear single responsibility principle
   - Standardized service interfaces

2. Active Record Patterns

   - Models: Game, Patron, Event, Message, PatronRelationship
   - Rich domain models with clear relationships
   - Database interactions through Active Record

3. Controller Patterns

   - RESTful resource controllers
   - Turbo Stream responses for real-time updates
   - Minimal business logic in controllers

## Component Relationships

1. Game Core

   ```
   Game
    ├── Patrons
    │    └── PatronRelationships
    ├── Events
    └── Messages
   ```

2. Service Layer
   ```
   GameLogic
    ├── GPT Manager
    ├── Event Manager
    ├── Patron Manager
    └── Message Manager
   ```

## Key Technical Decisions

1. Financial System

   - Atomic transactions with database locking
   - Event-driven financial impacts
   - Comprehensive inventory tracking
   - Real-time financial status updates

2. AI Integration

   - OpenAI GPT for content generation
   - Structured prompts for consistent output
   - Asynchronous processing where appropriate

3. Frontend Integration

   - Hotwire/Turbo for real-time updates
   - Tailwind CSS for styling
   - Progressive enhancement approach

4. Data Management

   - PostgreSQL for persistent storage
   - Active Record for ORM
   - Join tables for many-to-many relationships
