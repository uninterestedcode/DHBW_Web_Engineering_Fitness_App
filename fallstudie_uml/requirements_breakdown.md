# Requirements Breakdown: DHBW Fitness Web App

## Methodology

This document structures requirements using the Agile hierarchy: **Initiative -> Epic -> User Story -> Task**.

The hierarchy follows Atlassian's model and the INVEST criteria for user stories.

| Level | Description | Duration | Owner |
|---|---|---|---|
| Initiative | Overarching goal that drives all work | Multi-quarter to a year | Product owner, stakeholders |
| Epic | Large feature set delivering business value | 2-6 months, multiple sprints | Product owner, business stakeholders |
| User Story | Small, user-focused requirement written from the end user's perspective | 1-2 weeks, fits in one sprint | Product owner with team input |
| Task | Specific, actionable technical work item | 1-8 hours | Development team member |

A user story uses the format: **"As a [type of user], I want [goal] so that [reason/benefit]."**

Each user story includes acceptance criteria in Given/When/Then format. These criteria are testable, specific, and define when the story is complete.

Good user stories follow the INVEST criteria:
- **Independent**: Can be developed and tested separately.
- **Negotiable**: Details can be discussed and refined.
- **Valuable**: Delivers clear value to users or the business.
- **Estimable**: The team can estimate effort.
- **Small**: Fits within a single sprint.
- **Testable**: Has clear acceptance criteria.

---

## Context and Stakeholders

**Project**: "Die dualen Muskeltiere" is a student initiative at DHBW developing a web application for DHBW students.

**Team**:
- Filippo Airinei: Technische Entwicklung
- devdoot.roy: Technische Entwicklung
- Lennart dbl: Organisation & Design
- Jojo: Organisation & Design

**Scope**: Running and jogging only. The app is a mobile-optimized responsive web application built with React, HTML, CSS, and JavaScript. Authentication uses DHBW email, Matrikelnummer, and Kurscode (e.g., WWI25AMB). Data import uses CSV files exported from apps like Strava, Google Fit, or Apple Health.

**Operating context**: German law applies. The app stores personal data (email, Matrikelnummer, running data) and uses third-party AI services. DSGVO compliance is mandatory. The app targets DHBW students only.

---

## Actors and Use Cases

### Actor 1: DHBW Student (Registered User)
The primary user. Authenticated with DHBW email, Matrikelnummer, and Kurscode. Can upload data, view statistics, compare with peers, receive AI motivation.

| ID | Use Case |
|---|---|
| UC1 | Register a new account with DHBW credentials |
| UC2 | Log in with email and password |
| UC3 | Upload running data via CSV file |
| UC4 | View personal running statistics (weekly, monthly) |
| UC5 | View performance charts and trends |
| UC6 | View benchmark comparison against DHBW averages |
| UC7 | View leaderboard (individual ranking) |
| UC8 | View course-level aggregated statistics |
| UC9 | View Studiengang-level comparison |
| UC10 | Receive AI-generated motivational messages after uploads |
| UC11 | Receive coaching suggestions after inactivity |
| UC12 | View milestone celebrations |
| UC13 | Edit profile information or change password |
| UC14 | Reset forgotten password via email |
| UC15 | Delete a single imported run |
| UC16 | Export all personal running data as CSV |
| UC17 | Delete account and all personal data |
| UC18 | View legal pages (Impressum, Datenschutz, AGB) |

### Actor 2: Unregistered Visitor
Any person who opens the website without logging in. Can access public legal pages and may see a limited public leaderboard or landing page.

| ID | Use Case |
|---|---|
| UC19 | View Impressum |
| UC20 | View Datenschutzerklaerung |
| UC21 | View AGB |
| UC22 | Accept or decline cookie banner |
| UC23 | View public landing page with feature overview |

### Actor 3: System Administrator (Team Member)
A member of the development team who monitors system health, manages deployments, and ensures data integrity.

| ID | Use Case |
|---|---|
| UC24 | Monitor application health and uptime |
| UC25 | View application logs and error reports |
| UC26 | Manage database backups |
| UC27 | Deploy new versions of the application |

---

## Non-Functional Requirements

| ID | Category | Requirement |
|---|---|---|
| NFR1 | Performance | Dashboard page loads within 2 seconds on a 4G connection. |
| NFR2 | Performance | CSV file upload of 500 rows completes within 5 seconds. |
| NFR3 | Scalability | System supports at least 500 registered users and 50 concurrent sessions. |
| NFR4 | Availability | Application maintains 95% uptime during the semester period. |
| NFR5 | Security | All passwords are hashed using bcrypt with a cost factor of at least 12. |
| NFR6 | Security | All API communication uses HTTPS. |
| NFR7 | Security | OWASP Top 10 vulnerabilities are mitigated (XSS, SQL injection, CSRF). |
| NFR8 | Security | API endpoints enforce rate limiting (100 requests per minute per IP, 10 login attempts per 5 minutes). |
| NFR9 | Accessibility | Application meets WCAG 2.1 Level AA (color contrast, keyboard navigation, screen reader support). |
| NFR10 | Browser support | Application functions on the last 2 versions of Chrome, Firefox, Safari, and Edge. |
| NFR11 | Data protection | User data is encrypted at rest. |
| NFR12 | Data protection | Users can request deletion of all personal data within 30 days (DSGVO Art. 17). |
| NFR13 | Data protection | Users can download all their data in a structured format (DSGVO Art. 20). |
| NFR14 | Data retention | Running records are retained until the user deletes their account. |
| NFR15 | Localization | User interface is in German. Date formats follow DD.MM.YYYY. Distance in kilometers. Pace in minutes per kilometer. |
| NFR16 | Backup | Database is backed up daily with a 7-day retention period. |
| NFR17 | Error handling | All API errors return a consistent JSON structure with a human-readable message. |
| NFR18 | Logging | Security-relevant events (login, password change, data export, account deletion) are logged with timestamps. |

---

## Data Model Overview

The following entities are required:

**users** (id, email, matrikelnummer, kurscode, password_hash, email_verified, is_active, created_at, updated_at)

**running_records** (id, user_id, date, distance_km, duration_min, pace_min_per_km, source_app, created_at)

**user_consents** (id, user_id, consent_type, accepted, accepted_at, ip_address)

**ai_interactions** (id, user_id, interaction_type, prompt_context, response_content, created_at)

**milestones_shown** (id, user_id, milestone_type, milestone_value, shown_at)

**system_logs** (id, event_type, user_id, ip_address, details, created_at)

---

## Risk Analysis

| ID | Risk | Likelihood | Impact | Mitigation |
|---|---|---|---|---|
| R1 | CSV export formats differ between running apps (Strava vs Google Fit vs Apple Health) | High | High | Support multiple formats. Provide a CSV template. Allow column mapping. |
| R2 | Users upload fake or manipulated data to rank higher | Medium | High | Flag anomalies. No direct rewards tied to ranking. Focus on community rather than competition. |
| R3 | AI API (OpenAI) costs exceed student budget | Medium | Medium | Cache AI responses. Limit AI interactions per user per day. Use lightweight local models as fallback. |
| R4 | Hosting costs exceed budget | Low | Medium | Use free tiers (Render, Railway, Vercel). Optimize database queries to reduce compute. |
| R5 | Low initial adoption (few students register) | Medium | Medium | Integrate with DHBW student channels. Make registration frictionless. |
| R6 | DSGVO complaint or data breach | Low | High | Encrypt data. Minimal data collection. Clear privacy policy. Implement right to deletion. |
| R7 | Leaderboard query performance degrades with growth | Medium | Medium | Use database indexing. Pre-compute aggregates. Implement pagination. |

---

## Initiative

# DHBW Fitness Web App: Student Running Motivation and Performance Tracking

---

## Epics

### Epic 1: User Authentication and Identity Management

**Business value**: Students must identify themselves as DHBW members and be grouped into their courses automatically so the comparison and ranking features function correctly.

#### Story 1.1: Registration with DHBW credentials
**As a DHBW student, I want to register using my DHBW email, Matrikelnummer, and Kurscode so that my identity and course affiliation are verified.**

**Acceptance criteria**:
- Given a user enters a DHBW email domain, a valid Matrikelnummer, and a Kurscode in the format [Studiengang][Jahr][Richtung][Kurs], when the user submits the registration form, then an account is created.
- Given a user enters an email that does not end in the DHBW domain, when the user submits, then an error message is displayed and the account is not created.
- Given a user enters a Kurscode, when the registration succeeds, then the user is assigned to the corresponding course group automatically.

**Tasks**:
- Create database schema for users (id, email, matrikelnummer, kurscode, password_hash, email_verified, is_active, created_at, updated_at).
- Create REST API endpoint for user registration.
- Implement server-side validation for email domain, Matrikelnummer format, and Kurscode format.
- Write unit tests for registration validation logic.
- Create registration form UI component in React.
- Implement frontend form validation with inline error messages.
- Add password strength indicator on registration form.

#### Story 1.2: Secure login
**As a registered user, I want to log in with my email and password so that I can access my personal data.**

**Acceptance criteria**:
- Given a registered user enters correct credentials, when the user submits the login form, then a JWT token is issued and the user is redirected to the dashboard.
- Given a user enters incorrect credentials, when the user submits, then an error message is displayed without revealing which field was wrong.
- Given a logged-in user, when the token expires, then the user is redirected to the login page.
- Given a user, when 5 failed login attempts occur within 5 minutes, then the account is temporarily locked for 15 minutes.

**Tasks**:
- Create REST API endpoint for user authentication.
- Implement JWT token generation and validation.
- Implement login attempt tracking and rate limiting.
- Create login form UI component in React.
- Implement protected route middleware on the frontend.
- Write unit tests for authentication logic.
- Write integration tests for login flow.

#### Story 1.3: Automatic course group assignment
**As a registered user, I want my Kurscode to determine my course, degree program, year, and specialization automatically so that I am included in the correct leaderboards.**

**Acceptance criteria**:
- Given a user registers with Kurscode "WWI25AMB", when the account is created, then the user is assigned to Kurs B, Richtung AM, Studiengang WWI, Jahr 25.
- Given a user views their profile, when the page loads, then the parsed course details are displayed.

**Tasks**:
- Implement Kurscode parser logic on the backend.
- Add derived fields or computed properties for Studiengang, Jahr, Richtung, Kurs.
- Display course affiliation on the user profile page.
- Write unit tests for Kurscode parsing with all known DHBW formats.

#### Story 1.4: Password reset via email
**As a user, I want to reset my password via email if I forget it so that I can regain access to my account.**

**Acceptance criteria**:
- Given a user enters their registered email on the password reset page, when they submit, then a reset link is sent to the email if it exists.
- Given a user clicks a valid reset link within 1 hour, when they enter a new password, then the password is updated and the link becomes invalid.
- Given a user clicks an expired reset link, when the page loads, then an error message is shown and a new reset can be requested.

**Tasks**:
- Create password reset token generation and storage mechanism.
- Create REST API endpoint for requesting password reset.
- Create REST API endpoint for confirming password reset.
- Integrate email service (SendGrid, Mailgun, or SMTP).
- Create password reset request UI component.
- Create new password entry UI component.

---

### Epic 2: Running Data Import and Management

**Business value**: The app must receive running data from external sources. Users export CSV files from their running apps and upload them to the platform.

#### Story 2.1: CSV file upload
**As a runner, I want to upload a CSV file exported from Strava, Google Fit, or Apple Health so that my running data is stored in the app.**

**Acceptance criteria**:
- Given a user selects a CSV file on the upload page, when the file size is under 5MB and the format is CSV, then the file is accepted and queued for processing.
- Given a user selects a non-CSV file or a file over 5MB, when the user clicks upload, then an error message is displayed.
- Given an uploaded CSV file, when parsing begins, then duplicate entries based on user_id, date, and distance are detected and skipped.

**Tasks**:
- Create file upload API endpoint with size limits (5MB).
- Create CSV upload UI component with drag-and-drop and file picker.
- Implement client-side file type validation.
- Implement server-side file type and size validation.
- Show upload progress indicator.

#### Story 2.2: Parse and normalize imported data
**As a runner, I want my uploaded CSV data to be parsed and normalized so that distance, duration, pace, and date fields are stored consistently.**

**Acceptance criteria**:
- Given a valid CSV with columns for date, distance, and duration, when the file is processed, then each row is stored as a running record with fields: date, distance_km, duration_min, pace_min_per_km.
- Given a CSV with missing required columns, when the file is processed, then the user receives an error describing which columns are missing.
- Given a CSV with rows containing invalid data, when the file is processed, then those rows are skipped and a summary report of skipped rows is shown.
- Given a CSV from Strava, Google Fit, or Apple Health, when uploaded, then the parser auto-detects the format and maps columns correctly.

**Tasks**:
- Implement CSV parser supporting multiple running app export formats.
- Create column auto-detection logic (date, distance, duration, pace).
- Create running_records database schema (id, user_id, date, distance_km, duration_min, pace_min_per_km, source_app, created_at).
- Implement data normalization logic (unit conversion: miles to km, seconds to minutes, date standardization to ISO 8601).
- Implement duplicate detection based on user_id, date, distance, and duration.
- Write unit tests for parser with sample CSVs from each supported app.
- Write unit tests for normalization logic.

#### Story 2.3: View running history
**As a user, I want to view a list of all my imported running sessions so that I can review my activity history.**

**Acceptance criteria**:
- Given a user with imported runs, when the user opens the history page, then a chronological list of all runs is displayed with date, distance, duration, and pace.
- Given a user with no imported runs, when the history page loads, then an empty state message with a hint to upload data is shown.
- Given a user on the history page, when they click a run entry, then a detail view with full information is shown.
- Given a user on the history page, when they use the date range filter, then only runs within that range are displayed.

**Tasks**:
- Create API endpoint to fetch running history for a user with pagination.
- Create running history list UI component.
- Create run detail view UI component.
- Implement date range filter on the frontend.
- Implement pagination or infinite scroll for large histories.
- Create empty state illustration and message.

#### Story 2.4: Delete or edit a running record
**As a user, I want to delete or edit an imported running record so that I can correct mistakes.**

**Acceptance criteria**:
- Given a user views their running history, when they click delete on a run, then a confirmation dialog appears and the run is removed after confirmation.
- Given a user views a run detail, when they edit the date, distance, or duration, then the record is updated and the pace is recalculated.
- Given a user deletes a run, when the deletion completes, then the statistics and leaderboards reflect the change.

**Tasks**:
- Create REST API endpoint for deleting a running record.
- Create REST API endpoint for updating a running record.
- Create delete confirmation dialog UI component.
- Create inline edit form for running records.
- Trigger statistic recalculation after deletion or edit.

---

### Epic 3: Personal Performance Analytics Dashboard

**Business value**: Users track their progress through aggregated statistics and charts. The dashboard displays weekly and monthly performance summaries.

#### Story 3.1: Weekly and monthly statistics
**As a runner, I want to see my weekly and monthly totals for distance, number of runs, and average pace so that I can track my progress.**

**Acceptance criteria**:
- Given a user with running data, when the dashboard loads, then summary cards show total distance, number of runs, and average pace for this week and this month.
- Given a user with running data, when the dashboard loads, then a summary card shows the longest single run this month.
- Given a user with no data, when the dashboard loads, then placeholder zeros and an upload prompt are shown.

**Tasks**:
- Create aggregation queries for weekly and monthly statistics.
- Create dashboard API endpoint returning computed statistics.
- Create statistics summary card UI components.
- Add loading skeleton states for statistics cards.

#### Story 3.2: Visual performance charts
**As a runner, I want to see line charts and bar charts of my running distance and pace over time so that trends are visible.**

**Acceptance criteria**:
- Given a user with at least two weeks of data, when the dashboard loads, then a line chart displays distance per week over the last 8 weeks.
- Given a user with running data, when the dashboard loads, then a bar chart displays pace distribution across recent runs.
- Given a user with no data, when the dashboard loads, then empty chart states with guidance text are shown.

**Tasks**:
- Integrate a charting library (Chart.js or Recharts) into the React frontend.
- Create week-by-week and month-by-month aggregation queries.
- Create line chart component for distance trends.
- Create bar chart component for pace distribution.
- Handle empty state for users with insufficient data.

#### Story 3.3: Benchmark comparison display
**As a runner, I want to see how my weekly distance and pace compare to DHBW student averages so that I understand my relative performance level.**

**Acceptance criteria**:
- Given a user views their dashboard, when the benchmark section loads, then the user's weekly distance is displayed alongside the DHBW-wide average.
- Given the benchmark calculation, when computed, then the average is derived from all active users' data for the same time period.
- Given the user's performance, when compared to the average, then a visual indicator (above average, below average, near average) is shown.

**Tasks**:
- Create aggregation query for global DHBW average distance and pace per week.
- Create benchmark comparison UI component with visual indicators.
- Cache benchmark calculations to reduce query load.

#### Story 3.4: Running streak tracking
**As a runner, I want to see my current running streak (consecutive weeks with at least one run) so that I am motivated to maintain consistency.**

**Acceptance criteria**:
- Given a user with running data, when the dashboard loads, then a streak counter shows the number of consecutive weeks with at least one uploaded run.
- Given a user breaks their streak, when the dashboard loads, then the streak resets and the previous longest streak is shown.

**Tasks**:
- Implement streak calculation logic on the backend.
- Create streak display UI component with visual emphasis.
- Store longest streak in user record for historical reference.

---

### Epic 4: Social Comparison and Leaderboards

**Business value**: Peer comparison drives motivation. Users compare themselves with other individuals, their course, and their degree program.

#### Story 4.1: Individual leaderboard
**As a DHBW student, I want to see a leaderboard ranking all students by total distance or average pace so that I can compare my performance with peers.**

**Acceptance criteria**:
- Given a user opens the leaderboard page, when the page loads, then a ranked list of the top 50 students by total distance is displayed.
- Given a user on the leaderboard, when they switch the filter, then the ranking is recalculated by average pace or number of runs.
- Given a user on the leaderboard, when the current user's rank is outside the top 50, then the user's rank is shown separately below the list.

**Tasks**:
- Create leaderboard API endpoint with ranking by distance, pace, and number of runs.
- Create leaderboard UI component with filter toggle and tabs.
- Optimize query performance with database indexes.
- Add pagination for large leaderboards.

#### Story 4.2: Course-level aggregated statistics
**As a DHBW student, I want to see aggregated statistics for my course (e.g., WWI25AMB) so that I can see how my course performs collectively.**

**Acceptance criteria**:
- Given a user views the course comparison page, when the page loads, then their course's total distance, total runs, average pace, and number of participants are displayed.
- Given a course with multiple students, when statistics are calculated, then the aggregation includes all students assigned to that Kurs.

**Tasks**:
- Create course aggregation API endpoint.
- Create course statistics card UI component.
- Implement grouping logic by parsed Kurscode fields.

#### Story 4.3: Studiengang-level comparison
**As a user, I want to see a comparison across degree programs (e.g., WWI vs. BWL) so that I can see which program is most active.**

**Acceptance criteria**:
- Given a user opens the Studiengang comparison page, when the page loads, then a ranked list of degree programs by total distance is displayed.
- Given the list, when the user views it, then each entry shows the program name, number of participants, and total distance.

**Tasks**:
- Create Studiengang aggregation API endpoint.
- Create Studiengang comparison UI component.

#### Story 4.4: Time-period filtering for leaderboards
**As a user, I want to filter leaderboards by time period (this week, this month, this semester, all time) so that comparisons are fair.**

**Acceptance criteria**:
- Given a user on the leaderboard page, when they select "this month", then the ranking uses only data from the current calendar month.
- Given a user selects "this semester", when the ranking updates, then the period covers the current DHBW semester (approx. March-July or September-February).

**Tasks**:
- Implement time-period filter logic in leaderboard queries.
- Create time-period selector UI component.
- Define semester date ranges for the current academic year.

---

### Epic 5: AI Motivation Coach

**Business value**: AI-generated messages keep users engaged when activity drops and celebrate achievements when milestones are reached.

#### Story 5.1: Personalized motivational messages
**As a runner, I want to receive a personalized motivational message after uploading new data so that I feel encouraged to continue running.**

**Acceptance criteria**:
- Given a user uploads a new run, when the upload completes, then a motivational message generated by AI is displayed on the screen.
- Given the AI response, when it is generated, then it references the user's recent distance, pace, or improvement trend.
- Given an AI error or rate limit, when the message cannot be generated, then a fallback pre-written motivation is displayed.

**Tasks**:
- Integrate AI API (OpenAI or similar) into the backend.
- Design prompt template that includes user's running data context.
- Create API endpoint to generate motivational messages.
- Implement AI response caching to reduce API calls and cost.
- Create fallback message list for when AI is unavailable.
- Display the message in the frontend after upload.

#### Story 5.2: Coaching suggestions on activity drop
**As a runner, I want to receive a coaching suggestion when I have not uploaded a run in over 7 days so that I get back on track.**

**Acceptance criteria**:
- Given a user has not uploaded a run in 7 days, when they log in, then a notification banner with an AI-generated coaching suggestion is displayed.
- Given no recent activity, when the AI generates a suggestion, then the tone is encouraging and includes a specific actionable tip.
- Given a user has been inactive for 7 days, when the suggestion is shown, then it appears at most once per day.

**Tasks**:
- Implement inactivity detection logic.
- Create AI prompt for activity drop coaching.
- Create notification banner UI component with dismiss button.
- Implement frequency limit (max 1 per day per user).

#### Story 5.3: Milestone celebration insights
**As a user, I want to see AI-generated insights when I reach a milestone (e.g., 100 km total) so that I feel rewarded.**

**Acceptance criteria**:
- Given a user's total distance crosses a milestone threshold (50 km, 100 km, 250 km, 500 km), when the dashboard loads after crossing, then a celebratory insight is displayed.
- Given a milestone event, when the insight is shown, then it is distinct from regular messages and includes a summary of the user's journey.
- Given a milestone has been shown, when the user crosses the same threshold again (e.g., after data deletion), then the insight is not repeated.

**Tasks**:
- Implement milestone detection logic at 50, 100, 250, 500 km thresholds.
- Create AI prompt for milestone celebration.
- Create milestone modal or banner UI component with confetti animation.
- Track shown milestones in the database to avoid repetition.

---

### Epic 6: Legal Compliance and Governance

**Business value**: The app operates under German law. Required legal pages and consent mechanisms must be present before launch.

#### Story 6.1: Impressum and operator information
**As a user, I want to see an Impressum with operator contact details so that I know who runs the service.**

**Acceptance criteria**:
- Given a user clicks the "Impressum" link, when the page loads, then the legal operator name, address, and contact information for "Die dualen Muskeltiere" are displayed.

**Tasks**:
- Draft Impressum text with team contact details.
- Create Impressum page component.
- Add Impressum link in the footer on every page.

#### Story 6.2: Datenschutzerklaerung
**As a user, I want to read a Datenschutzerklaerung so that I understand how my running data and personal information are processed.**

**Acceptance criteria**:
- Given a user clicks "Datenschutz", when the page loads, then a complete privacy policy describing data collection, storage, processing, and user rights is displayed.
- Given the privacy policy, when reviewed, then it mentions CSV data processing, storage duration, AI service usage, and third-party data processors.
- Given the privacy policy, when reviewed, then it includes contact information for data protection inquiries.

**Tasks**:
- Draft Datenschutzerklaerung covering all data processing activities.
- Create Datenschutz page component.
- Add Datenschutz link in the footer.

#### Story 6.3: Cookie consent and AGB acceptance
**As a user, I want to accept Cookies and AGB before using the app so that my consent is documented.**

**Acceptance criteria**:
- Given a new visitor opens the app, when the page loads, then a cookie banner is displayed with accept and decline options.
- Given a user declines cookies, when they browse the site, then only essential cookies are set.
- Given a user attempts to register, when the registration form is shown, then a mandatory checkbox for AGB acceptance is present.
- Given a user attempts to register without checking the AGB box, when the form is submitted, then an error is shown and registration is blocked.
- Given a user accepts AGB, when they register, then the acceptance timestamp is stored in the database.

**Tasks**:
- Draft Cookie banner text and AGB text.
- Create cookie banner UI component with accept/decline tracking.
- Create AGB page component.
- Create Widerrufsbelehrung page component.
- Add AGB checkbox to registration form with validation.
- Implement backend storage for consent timestamps and types.

---

### Epic 7: Mobile-First Web Platform Foundation

**Business value**: The app is optimized for mobile use. Students check their stats on their phones. The technical foundation uses modern web technologies.

#### Story 7.1: Mobile-optimized responsive layout
**As a user, I want the web app to display correctly on my smartphone screen so that I can use it while running or on the go.**

**Acceptance criteria**:
- Given a user opens the app on a smartphone with a 375px width, when the page loads, then all content is readable without horizontal scrolling.
- Given a user opens the app on a tablet or desktop, when the page loads, then the layout adapts to use the available screen width.
- Given a user interacts with buttons or form fields, when they tap them on a touchscreen, then the tap targets are at least 44 x 44 pixels.

**Tasks**:
- Set up responsive CSS with mobile-first media queries.
- Configure viewport meta tag.
- Test layouts on common mobile screen sizes (375px, 414px, 768px).
- Ensure adequate tap target sizes for all interactive elements.

#### Story 7.2: Tab-based navigation
**As a user, I want tab-based navigation so that I can switch between sections (Dashboard, Upload, Leaderboards, Profile).**

**Acceptance criteria**:
- Given a user is on any page, when they tap a navigation tab, then the active section is displayed without a full page reload.
- Given a user taps a tab, when the new section loads, then the active tab is visually highlighted.
- Given a user on mobile, when they view the navigation, then tabs are accessible via a bottom navigation bar.

**Tasks**:
- Create tab navigation component for main app sections.
- Implement client-side routing with React Router.
- Create bottom navigation bar for mobile view.
- Style active and inactive tab states.

#### Story 7.3: React application foundation
**As a developer, I want the frontend built with React so that the codebase uses modern component-based architecture.**

**Acceptance criteria**:
- Given the project repository, when the code is examined, then React is the primary framework.
- Given the project, when the build command runs, then the application compiles and bundles correctly.
- Given the production build, when analyzed, then bundle size is under 500KB gzipped.

**Tasks**:
- Initialize React project with Vite.
- Set up project folder structure (components, pages, hooks, services, utils, assets).
- Configure environment variables for API base URL and AI API key.
- Set up ESLint and Prettier.
- Configure build optimization and code splitting.

---

### Epic 8: Backend API and Database Infrastructure

**Business value**: The application needs a reliable backend to process requests, store data, and serve the frontend. This epic covers the server foundation.

#### Story 8.1: Database setup and connection management
**As a developer, I want a PostgreSQL database with connection pooling so that data is stored reliably and the application can handle concurrent requests.**

**Acceptance criteria**:
- Given the application starts, when it connects to the database, then the connection pool is initialized with at least 5 connections.
- Given a database operation fails, when the error occurs, then the connection is released back to the pool and the error is logged.

**Tasks**:
- Provision PostgreSQL database (local for dev, cloud for prod).
- Set up database connection pooling.
- Create database initialization script.
- Create migration framework (e.g., node-pg-migrate).

#### Story 8.2: Core database schema implementation
**As a developer, I want the core database schema created so that all entities are properly defined with relationships and constraints.**

**Acceptance criteria**:
- Given the migration script runs, when it completes, then all tables (users, running_records, user_consents, ai_interactions, milestones_shown, system_logs) are created with proper types and constraints.
- Given the schema is in place, when foreign key constraints are checked, then deleting a user cascades deletion of their running records and consents.

**Tasks**:
- Write migration for users table.
- Write migration for running_records table.
- Write migration for user_consents table.
- Write migration for ai_interactions table.
- Write migration for milestones_shown table.
- Write migration for system_logs table.
- Add foreign key constraints and indexes.

#### Story 8.3: REST API framework and middleware
**As a developer, I want a structured REST API with middleware for logging, CORS, and JSON parsing so that the backend is maintainable.**

**Acceptance criteria**:
- Given any API request, when it reaches the server, then it is logged with timestamp, method, path, and status code.
- Given a request from the frontend origin, when CORS headers are checked, then the request is allowed from the configured domain.
- Given a malformed JSON request, when it is received, then a 400 error with a clear message is returned.

**Tasks**:
- Set up Express.js or Fastify server framework.
- Implement request logging middleware.
- Configure CORS for frontend origin.
- Implement JSON body parsing with size limits.
- Implement global error handling middleware.
- Create API versioning strategy (e.g., /api/v1/).

#### Story 8.4: API documentation
**As a developer, I want API documentation so that frontend and backend integration is clear.**

**Acceptance criteria**:
- Given the API docs are opened, when reviewed, then all endpoints are documented with request/response schemas and example payloads.

**Tasks**:
- Set up Swagger/OpenAPI documentation.
- Document all authentication endpoints.
- Document all running data endpoints.
- Document all statistics and leaderboard endpoints.
- Document all AI endpoints.

---

### Epic 9: Security and Data Protection

**Business value**: Student data must be protected. Security breaches or privacy violations would damage trust and could have legal consequences.

#### Story 9.1: HTTPS and secure HTTP headers
**As a user, I want all communication with the app to be encrypted so that my data cannot be intercepted.**

**Acceptance criteria**:
- Given any request to the application, when the protocol is HTTP, then the request is redirected to HTTPS.
- Given the response headers, when inspected, then security headers (HSTS, X-Content-Type-Options, X-Frame-Options, Content-Security-Policy) are present.

**Tasks**:
- Obtain and configure SSL/TLS certificate.
- Implement HTTP-to-HTTPS redirect.
- Configure security headers in server middleware.
- Test header configuration with security scanning tool.

#### Story 9.2: Input validation and injection prevention
**As a developer, I want all user inputs validated and queries parameterized so that injection attacks are prevented.**

**Acceptance criteria**:
- Given a malicious input containing SQL keywords, when submitted to any form, then the input is sanitized and the database is not affected.
- Given an XSS payload in a form field, when rendered in the frontend, then the script is not executed.

**Tasks**:
- Implement parameterized queries for all database operations.
- Add input sanitization middleware.
- Implement output encoding in React components.
- Add Content-Security-Policy header.

#### Story 9.3: Rate limiting and abuse prevention
**As a developer, I want rate limits on API endpoints so that the application is protected from abuse and excessive API costs.**

**Acceptance criteria**:
- Given a single IP address, when it makes more than 100 requests per minute to the API, then subsequent requests receive a 429 response.
- Given a single IP, when it makes more than 5 failed login attempts in 5 minutes, then further login attempts are blocked for 15 minutes.

**Tasks**:
- Implement IP-based rate limiting on all API routes.
- Implement stricter rate limiting on authentication endpoints.
- Implement AI API call rate limiting per user (e.g., 10 per day).
- Add rate limit headers in API responses.

---

### Epic 10: User Profile and Account Management

**Business value**: Users need control over their account. DSGVO mandates the right to access and delete personal data.

#### Story 10.1: Edit profile information
**As a user, I want to edit my display name or password so that my account information is up to date.**

**Acceptance criteria**:
- Given a logged-in user on the profile page, when they change their display name and save, then the change is persisted.
- Given a user changes their password, when they submit, then the old password is required and the new password must meet strength requirements.

**Tasks**:
- Create profile edit API endpoint.
- Create profile page UI component.
- Create password change form with old password verification.

#### Story 10.2: Export personal data
**As a user, I want to download all my data in a structured format so that I have a copy (DSGVO Art. 20).**

**Acceptance criteria**:
- Given a user requests data export, when the export is generated, then a ZIP file containing CSV of running records and JSON of account data is provided.
- Given the export file, when opened, then all personal data the app holds is included.

**Tasks**:
- Create data export API endpoint.
- Implement CSV generation for running records.
- Implement JSON generation for account and consent data.
- Create ZIP packaging logic.
- Create download UI in profile page.

#### Story 10.3: Delete account and all data
**As a user, I want to permanently delete my account and all associated data so that no trace remains (DSGVO Art. 17).**

**Acceptance criteria**:
- Given a user initiates account deletion, when they confirm with their password, then all their data is purged from the database within 30 days.
- Given the deletion completes, when checked, then the user's running records, consents, and AI interactions are removed.

**Tasks**:
- Create account deletion API endpoint.
- Implement cascading deletion for all user-related records.
- Create confirmation dialog with password re-entry.
- Log deletion event for audit purposes.

---

### Epic 11: Error Handling, Notifications and User Feedback

**Business value**: Users need clear feedback on their actions. Errors must be handled gracefully without exposing technical details.

#### Story 11.1: Toast notification system
**As a user, I want toast notifications for success, error, and warning messages so that I know the result of my actions.**

**Acceptance criteria**:
- Given a user performs an action (upload, delete, save), when it succeeds, then a green toast notification appears briefly.
- Given an action fails, when the error occurs, then a red toast with a human-readable message appears.
- Given multiple toasts, when they appear, then they stack and the oldest auto-dismisses after 5 seconds.

**Tasks**:
- Create toast notification context/provider in React.
- Create toast UI component with variants (success, error, warning, info).
- Implement auto-dismiss and manual dismiss.
- Wire toasts to all async actions.

#### Story 11.2: Loading states and skeleton screens
**As a user, I want loading indicators while data is fetched so that I know the app is working.**

**Acceptance criteria**:
- Given a page with data fetching, when data loads, then a skeleton placeholder or spinner is shown.
- Given data loads in under 200ms, when the transition occurs, then no loading state is shown to avoid flicker.

**Tasks**:
- Create skeleton UI components for lists and cards.
- Create loading spinner component.
- Implement loading state logic with debounce threshold.
- Apply loading states to all data-fetching pages.

#### Story 11.3: Error pages and recovery
**As a user, I want clear error pages when something goes wrong so that I know what happened and how to recover.**

**Acceptance criteria**:
- Given a 404 error, when the page loads, then a "Page not found" message with a link to the dashboard is shown.
- Given a 500 error, when the page loads, then a generic error message is shown without technical details.
- Given a network error, when it occurs, then a retry button is provided.

**Tasks**:
- Create 404 not found page component.
- Create 500 error page component.
- Implement global error boundary in React.
- Add retry logic for failed API requests.

---

### Epic 12: Deployment, DevOps and System Operations

**Business value**: The application must be accessible to users. Deployment must be reliable and repeatable.

#### Story 12.1: Production hosting and domain
**As a team, I want the application deployed to a production server with a custom domain so that users can access it.**

**Acceptance criteria**:
- Given the domain is entered in a browser, when the page loads, then the application is accessible.
- Given the domain, when DNS is checked, then it points to the production server.

**Tasks**:
- Select hosting provider (e.g., Render, Railway, Hetzner, DigitalOcean).
- Provision server or container instance.
- Register domain name.
- Configure DNS records.
- Set up environment variables for production.

#### Story 12.2: CI/CD pipeline
**As a developer, I want an automated pipeline that builds, tests, and deploys the application so that releases are consistent and errors are caught early.**

**Acceptance criteria**:
- Given a push to the main branch, when the CI pipeline runs, then unit tests and lint checks pass before deployment.
- Given a failed test, when the pipeline runs, then deployment is blocked.

**Tasks**:
- Set up GitHub Actions or GitLab CI workflow.
- Configure build step for frontend.
- Configure build step for backend.
- Configure test execution step.
- Configure automated deployment to production.

#### Story 12.3: Database backup strategy
**As an administrator, I want daily automated database backups so that data can be recovered after a failure.**

**Acceptance criteria**:
- Given the backup schedule, when it runs, then a backup file is created and stored.
- Given a backup file, when a restore is needed, then the database can be restored to that point in time.

**Tasks**:
- Configure automated PostgreSQL backups (pg_dump).
- Store backups in cloud storage with 7-day retention.
- Document restore procedure.
- Test restore procedure on a staging database.

---

### Epic 13: Accessibility and Inclusive Design

**Business value**: DSGVO and German law aside, accessibility ensures all students can use the app. It is a mark of professionalism.

#### Story 13.1: Keyboard navigation
**As a user who navigates by keyboard, I want all interactive elements reachable via Tab and actionable via Enter or Space so that I can use the app without a mouse.**

**Acceptance criteria**:
- Given a user presses Tab, when navigating the page, then focus moves through all interactive elements in logical order.
- Given a focused element, when Enter or Space is pressed, then the element's action is triggered.

**Tasks**:
- Audit all interactive components for keyboard accessibility.
- Ensure focusable elements have visible focus indicators.
- Add skip-to-content link for navigation.

#### Story 13.2: Screen reader compatibility
**As a user with a screen reader, I want meaningful labels and announcements so that I understand the interface.**

**Acceptance criteria**:
- Given a screen reader reads the leaderboard, when it encounters a row, then it announces rank, name, and distance.
- Given a chart is present, when a screen reader reaches it, then an accessible text alternative summarizing the data is provided.

**Tasks**:
- Add ARIA labels to all interactive elements.
- Add role attributes where semantic HTML is insufficient.
- Provide text alternatives for charts and visual data.
- Test with popular screen readers (NVDA, VoiceOver).

#### Story 13.3: Color contrast compliance
**As a user with low vision, I want sufficient color contrast so that text and UI elements are readable.**

**Acceptance criteria**:
- Given the UI is analyzed, when contrast ratios are checked, then all text meets WCAG AA (4.5:1 for normal text, 3:1 for large text).
- Given information is conveyed by color, when color is removed, then the information is still distinguishable.

**Tasks**:
- Audit color palette for contrast ratios.
- Add patterns or labels in addition to color for data visualization.
- Ensure error states are distinguishable without relying solely on red color.

---

### Epic 14: Data Export and Portability

**Business value**: DSGVO Article 20 grants users the right to data portability. Implementing this builds trust.

#### Story 14.1: Export running data as CSV
**As a user, I want to download all my running records as a CSV file so that I can analyze them externally or switch to another app.**

**Acceptance criteria**:
- Given a user clicks "Export data" on their profile, when the export completes, then a CSV file with all running records is downloaded.
- Given the exported CSV, when opened, then it contains columns: date, distance_km, duration_min, pace_min_per_km, source_app.

**Tasks**:
- Create CSV export endpoint.
- Format data with proper CSV escaping and headers.
- Trigger download in the frontend.

---

## Mermaid Diagram: Requirements Hierarchy Tree

The visualization is in `requirements_tree.mmd`.