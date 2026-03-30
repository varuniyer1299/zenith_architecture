Zenith Architecture: Offline-First Flutter Core

Zenith Architecture is a professional-grade mobile application boilerplate built with Flutter, demonstrating a strict adherence to Clean Architecture and Domain-Driven Design (DDD).It features a robust offline-first synchronization strategy using Hive and Dio. 

Key Features

Clean Architecture: Clear separation between Data, Domain, and Presentation layers.

Offline-First Strategy: Intelligent data switching between Remote (API) and Local (Hive) based on real-time network connectivity.

Reactive State Management: Powered by BLoC (Business Logic Component) for predictable state transitions.

Dependency Injection: Managed via GetIt for decoupled, testable code.

Modern UI/UX: High-performance loading states using Skeletonizer (Shimmer effects) and Pull-to-Refresh.

Type-Safe Data Mapping: Dedicated Mapper layer to isolate Domain Entities from Data Models. 


Architectural Overview

The project follows the Clean Architecture pattern. Each feature is divided into three layers:

Domain (The Core): Contains Entities, Use Cases, and Repository Interfaces. This layer is pure Dart and has zero dependencies on Flutter or external libraries.

Data (The Infrastructure): Implements Repository interfaces, Data Sources (Remote/Local), Models (JSON/Hive), and Mappers.

Presentation (The UI): Contains BLoCs, Pages, and Widgets.


Tech Stack & Tools

Tech Stack & Architecture

Core Framework & State

flutter_bloc: Handles the "Zenith" predictable state flow via an Event-State bridge.

get_it: High-performance Service Locator for decoupled Dependency Injection.

Data & Networking
Hive: Lightning-fast, NoSQL local storage for Offline-First capabilities.

Dio: Robust HTTP client with custom interceptors for global error handling and logging.

Internet Connection Checker Plus: Real-time monitoring to trigger local vs. remote data strategies.

UI/UX Enhancements
Skeletonizer: Provides a seamless transition from loading states to content using automatic shimmers.

Getting Started

Prerequisites

Flutter SDK: ^3.x.x

Dart SDK: ^3.x.x


Installation

Clone the repository:Bashgit clone https://github.com/your-username/zenith-architecture.git

Install dependencies:Bashflutter pub get

Generate Hive Adapters & Mocks:Bashflutter pub run build_runner build --delete-conflicting-outputs

Run the app:Bashflutter run

Testing Strategy

The project prioritizes logic reliability through:Unit Tests: Testing Use Cases and Data Mappers (located in /test).Mocking: Using mockito or mocktail to isolate dependencies during testing.Run all tests with coverage:

Bash

flutter test --coverage

Design Decisions

Repository Pattern: The UserRepositoryImpl acts as a mediator, deciding whether to serve fresh API data or cached Hive data based on NetworkInfo.

The Mapper Layer: We avoid "leaking" Hive annotations into the Domain layer by using a dedicated UserMapper.

Base Data Sources: Common CRUD operations are abstracted into a BaseLocalDataSource<T> to reduce boilerplate and ensure scalability.

User-Agent Interceptors: Configured custom headers in Dio to prevent 403 Forbidden errors on public endpoints.

The architecture ensures data integrity by triggering a re-fetch event immediately upon a successful void-return sync, ensuring the local state mirrors the remote source of truth.

Technical Note:

I have opted to include generated files (*.g.dart) in this repository. This ensures that the codebase is immediately 'readable' and 'searchable' within the GitHub UI, allowing reviewers to inspect the full implementation of Hive Adapters and Mappers without needing a local development environment.
