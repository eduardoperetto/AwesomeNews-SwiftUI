# AwesomeNews

AwesomeNews is a SwiftUI-based iOS application that displays the latest news headlines using the [NewsAPI](https://newsapi.org/). This project is designed to practice integrating popular libraries and implementing modern iOS development techniques, such as the MVVM architecture and asynchronous networking with Alamofire.

## Table of Contents

- [Features](#features)
- [Getting Started](#getting-started)
  - [Prerequisites](#prerequisites)
  - [Installation](#installation)
  - [Configuration](#configuration)
- [Architecture](#architecture)
- [Libraries Used](#libraries-used)
  - [Alamofire](#alamofire)
- [Unit Tests](#unit-tests)
- [Network Logging](#network-logging)
- [Next Steps](#next-steps)

## Features

- Displays top headlines from around the world.
- Implements infinite scrolling to load more articles as the user scrolls.
- Pull-to-refresh functionality to fetch the latest news.
- Uses MVVM architecture for a clean separation of concerns.
- Asynchronous networking with Alamofire using async/await.
- Custom network logging for debugging network requests and responses.

## Getting Started

### Prerequisites

- Xcode 13 or later
- Swift 5.5 or later
- An API key from [NewsAPI](https://newsapi.org/)

### Installation

1. **Clone the repository:**

   ```bash
   git clone https://github.com/yourusername/AwesomeNews.git
   ```

2. **Open the project in Xcode:**

   ```bash
   cd AwesomeNews
   open AwesomeNews.xcodeproj
   ```

3. **Install dependencies:**

   The project uses Swift Package Manager to manage dependencies. All required packages should load automatically when you open the project in Xcode.

### Configuration

1. **Obtain a NewsAPI API Key:**

   Sign up at [NewsAPI](https://newsapi.org/register) to get a free API key.

2. **Create a Configuration File:**

   In the root folder of the project, create a file named `Config.xcconfig`.

3. **Add Your API Key:**

   Open `Config.xcconfig` and add the following line, replacing `your_api_key` with your actual API key:

   ```plaintext
   API_KEY = your_api_key
   ```

4. **Build and Run:**

   Select a simulator or device and run the project in Xcode.

## Architecture

The app follows the **Model-View-ViewModel (MVVM)** architecture pattern, which promotes a clean separation of concerns and makes the codebase more maintainable and testable.

- **Model:** Represents the data structures used in the app, such as `Headline` and `Source`.
- **View:** SwiftUI views that present the UI, like `NewsListView` and `HeadlineRow`.
- **ViewModel:** Handles the business logic and data manipulation, specifically `NewsListViewModel`.

## Libraries Used

### Alamofire

[Alamofire](https://github.com/Alamofire/Alamofire) is an elegant HTTP networking library written in Swift. It simplifies a lot of the boilerplate code needed for making network requests.

- **Documentation:** [Alamofire Docs](https://alamofire.github.io/Alamofire/)
- **Usage in AwesomeNews:**
  - **Asynchronous Networking:** Utilizes async/await functions in `NewsService.swift` to fetch data from the NewsAPI.
  - **RequestInterceptor:** Implements the `RequestInterceptor` protocol to add authentication headers (API key) to all outgoing requests.
  - **EventMonitor:** A custom `NetworkLogger` is created as an `EventMonitor` to log important network request and response information for debugging purposes.

## Unit Tests

Unit tests are included in the `AwesomeNewsTests` target to ensure the reliability and correctness of the app's functionality. The tests cover:

- Networking calls using mocked responses.
- ViewModel logic to ensure data is processed correctly.
- Error handling to verify the app responds appropriately to different error scenarios.

## Network Logging

A custom `NetworkLogger` is implemented as an Alamofire `EventMonitor`. It logs detailed information about network requests and responses, including:

- Request URLs, methods, headers, and bodies.
- Response status codes, headers, and bodies.
- Errors and their descriptions.

This is particularly useful for debugging network interactions and ensuring that the app communicates correctly with the NewsAPI.

## Next Steps

The project aims to explore and integrate more native and external libraries, like SwiftData, SwiftUI animations, Combine...

---

Feel free to contribute to the project by submitting pull requests or opening issues for any bugs or feature requests.

Happy Coding! 🚀
