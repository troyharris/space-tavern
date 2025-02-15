# Product Context

## Purpose

The Tavern API serves as the backend for a fantasy tavern simulation game set in a remote human colony. It creates an interactive environment where players manage a tavern's operations while dealing with AI-generated events and patron interactions.

## Problems Solved

1. Creates an engaging tavern management simulation with meaningful choices
2. Generates dynamic, AI-driven social interactions and events
3. Simulates realistic patron behaviors and relationships
4. Manages complex economic systems (inventory, costs, profits)
5. Provides persistent game state that evolves over time

## How It Works

1. Game State Management

   - Tracks tavern's financial metrics (bank account, inventory, costs, profits)
   - Maintains patron roster and their relationships
   - Records history of events and decisions

2. Patron System

   - AI generates unique patrons with backstories
   - Tracks patron sentiments toward tavern and other patrons
   - Simulates visit frequency based on patron satisfaction

3. Event Generation

   - AI creates contextual events based on present patrons
   - Events can affect tavern finances and patron relationships
   - Decisions impact tavern popularity and economic status

4. Time Progression
   - Advances game time to trigger new events
   - Updates patron relationships and tavern status
   - Builds historical narrative of the tavern

## User Experience Goals

1. Create an immersive text-based experience reminiscent of BBS/MUD games
2. Provide meaningful management decisions that affect game outcomes
3. Generate engaging narratives through AI-driven events and interactions
4. Maintain persistent consequences for player decisions
5. Balance economic management with social interaction mechanics
