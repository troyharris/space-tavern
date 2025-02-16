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
     - Dynamic price adjustments (1-10 credits range)
     - Financial event processing
     - Transaction handling with validation
     - Cost range enforcement
     - Credit balance management
     - Event-driven price changes

2. GPT Manager Services

   - `GptChat`: Core AI interaction service
   - `CreateEvent`: Generates game events with financial impacts
   - `CreateHistory`: Builds narrative history
   - `CreatePatrons`: Generates new patrons

3. Event/Patron/Message Services

   - `EventService`: Manages event lifecycle and financial impacts
   - `PatronService`: Handles patron operations
   - `MessageService`: Manages game messages

## Design Patterns

1. Service Objects

   - Business logic encapsulated in service classes
   - Clear single responsibility principle
   - Standardized service interfaces
   - Transaction-wrapped operations

2. Active Record Patterns

   - Models: Game, Patron, Event, Message, PatronRelationship
   - Rich domain models with clear relationships
   - Database interactions through Active Record
   - Validation constraints for financial rules

3. Controller Patterns

   - RESTful resource controllers
   - Turbo Stream responses for real-time updates
   - Minimal business logic in controllers
   - Financial state updates via Turbo

## Component Relationships

1. Game Core

   ```
   Game
    ├── Patrons
    │    └── PatronRelationships
    ├── Events
    │    ├── Financial Impacts
    │    └── Beer Cost Changes
    └── Messages
   ```

2. Service Layer
   ```
   GameLogic
    ├── Financial Service
    │    ├── Transaction Handler
    │    ├── Price Manager
    │    └── Validation Rules
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
   - Integer-based beer costs (1-10 range)
   - Validated financial transactions
   - Event-based price adjustments

2. AI Integration

   - OpenAI GPT for content generation
   - Structured prompts with financial rules
   - Asynchronous processing where appropriate
   - Validated financial impact generation

3. Frontend Integration

   - Hotwire/Turbo for real-time updates
   - Tailwind CSS for styling
   - Progressive enhancement approach
   - Real-time financial state display

4. Data Management

   - PostgreSQL for persistent storage
   - Active Record for ORM
   - Join tables for many-to-many relationships
   - Financial constraint enforcement
   - Transaction isolation

5. Event Processing

   - Financial impact validation
   - Beer cost change tracking
   - Transaction wrapping
   - State consistency checks
   - Real-time updates
