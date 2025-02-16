# Recent Changes

## Financial System Update (2025-02-15)

- Added beer cost changes to events
- Events now affect both tavern credits and beer costs
- Beer costs must be integers (1-10 credits range)
- Fixed AI confusion with financial transactions by providing clear rules
- Added validation to prevent beer costs from going below 1 credit
- Implemented database migrations for financial impact and beer cost changes
- Added FinancialService to handle all financial transactions

## Current Focus

- Monitoring the new financial system to ensure events generate appropriate beer cost changes
- Ensuring AI follows the integer-based beer cost rules
- Watching for proper positive/negative number usage in financial impacts
- Validating event financial impacts against defined ranges
- Testing edge cases in beer cost adjustments

## Active Decisions

1. Financial Impact Rules

   - Beer cost changes should be more common than credit changes
   - Beer costs must stay within 1-10 credits range
   - Small events: +/-1 credit change
   - Medium events: +/-2 credits change
   - Large events: +/-3 to +/-5 credits change

2. Implementation Guidelines

   - All financial changes must be processed through FinancialService
   - Events must include both financial_impact and beer_cost_change fields
   - Database constraints enforce valid beer cost ranges
   - Transaction wrapping for all financial operations

3. AI Integration
   - Updated prompts to enforce financial impact rules
   - Clear guidelines for AI to generate appropriate cost changes
   - Structured validation of AI-generated financial values
