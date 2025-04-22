# Product Listing App Documentation

## Overview

This document describes the functionality and architecture of the Product Listing App. The app allows users to search, view, and sort products fetched from an API and cached locally using Hive. If the device is offline, the app will notify the user via a pop-up message. The app also supports search functionality with sorting options (e.g., by title, price, and rating).

### Key Features

1. **Product Caching using Hive**: The app fetches products from the local cache first, and if new data is not available, it fetches the data from a remote source (DummyJSON API).
2. **Offline Handling**: If the device is offline, a pop-up message informs the user that they are offline.
3. **Search Functionality**: When the user clicks the search bar, they are navigated to a new page where they can search products.
4. **Search Results**: As the user types in the search bar and presses the search icon, the search results are shown.
5. **Sorting**: The user can sort the product list by:
   - Title (A-Z or Z-A)
   - Price (High to Low, Low to High)
   - Rating (Highest to Lowest)
6. **State Management with Bloc**: The app uses the `flutter_bloc` package to manage the state of the product list and search functionality.
7. **Clean Architecture**: The app follows clean architecture principles, with a clear separation of concerns and well-defined folder structure.

---

## Folder Structure

The app follows clean architecture principles, organizing code into multiple layers:

```
lib/
├── core/
│   ├── constants/
│   ├── errors/
│   ├── service_locator/
│   └── utils/
│
├── features/
│   ├── search/
│   │   ├── data/
│   │   │   ├── models/
│   │   │   ├── datasources/
│   │   │   └── repositories/
│   │   ├── domain/
│   │   │   ├── entities/
|   |   |   |── repositories/
│   │   │   ├── usecases/
│   │   └── presentation/
│   │       ├── pages/
│   │       ├── blocs/
│   │       └── widgets/
│   |
└── main.dart
```

### Key Components

- **Core**: Contains common code and utilities, such as constants, error handling, service locator, and utility functions.
- **Features**: The features folder contains the logic for specific app features, such as product listing and search.
- **Product**:
  - **Data**: Fetches and processes product data, including models, data sources (Hive for caching), and repositories.
  - **Domain**: Contains business logic like entities and use cases for fetching and manipulating product data.
  - **Presentation**: Includes the UI code, widgets, and blocs for managing the state of product data.
- **Search**: Includes UI components, Bloc for state management, and search-specific logic.

---

## Product Fetching and Caching

1. **Hive for Local Caching**:
   - Products are first fetched from the local cache (Hive) when the app starts.
   - If products are not available or outdated, the app fetches the data from the `DummyJSON` API.
   - If the device is offline, the app shows a pop-up message indicating that the device is offline and cannot fetch the data.

2. **Fetching from DummyJSON API**:
   - When the device is online, the app sends a request to the DummyJSON API to fetch product data. The fetched data is then cached using Hive for future access.

3. **Error Handling**:
   - If the API call times out or encounters an error, the app will show an offline message indicating the issue.

---

## Search Functionality

### Navigating to Search Page

- When the user clicks on the search bar on the home screen, they are navigated to a new page where they can type their search query.
- This search page provides a search icon, allowing the user to trigger a search when the query is entered.

### Performing a Search

- After typing a query in the search field and pressing the search icon, the app shows a list of products matching the search term.
- The search results are fetched from either the local cache (Hive) or the remote API, depending on availability.

---

## Sorting the Products

The app allows users to sort the products by the following criteria:

1. **Title**: Sort products alphabetically (A-Z or Z-A).
2. **Price**:
   - **High to Low**: Sort by the highest price to the lowest.
   - **Low to High**: Sort by the lowest price to the highest.
3. **Rating**: Sort by product rating from highest to lowest.

The sorting options are available as part of the search screen.

---

## Bloc for State Management

The app uses `flutter_bloc` for managing the state of the products. Below is a breakdown of the states used in the product-fetching process:

1. **SearchState**: The state of the search feature. It has the following subclasses:
   - `SearchInitial`: The initial state before any data is fetched.
   - `SearchLoading`: The state when the product data is being fetched.
   - `SearchLoaded`: The state when the product data has been successfully fetched.
   - `SearchError`: The state when an error occurs (e.g., offline, API error).

2. **ProductBloc**: Manages the product data fetching and sorting logic. It interacts with the use cases to fetch products and handle various states.

### Example Bloc Usage

```dart
// In your SearchBloc
  Future<void> _onInitialLoad(
      SearchInitialLoad event, Emitter<SearchState> emit) async {
    emit(SearchLoading([]));

    _skip = 0;
    _allProducts.clear();

    // Fetch the products
    final result = await getProducts(skip: _skip, limit: _limit);

    result.fold(
      (failure) {
        // Handle failure
        emit(SearchError(failure.message));
      },
      (productsModel) {
        _allProducts.addAll(productsModel);
        _skip += _limit;
        _totalProducts = productsModel.length;

        final hasMore = _totalProducts > _allProducts.length;

        // Emit the loaded state
        emit(SearchLoaded(
          products: _allProducts,
          total: _totalProducts,
          hasMore: hasMore,
        ));
      },
    );
  }
```

---

## Offline Handling

If the device is offline, the app will show a pop-up message indicating the user is offline and cannot fetch new product data. This is handled in the `ApiService` class when fetching data from the `DummyJSON` API.

### Example Offline Handling

```dart
on DioException catch (e) {
    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout ||
        e.type == DioExceptionType.sendTimeout) {
      throw const OfflineFailure('Request timed out. Please check your connection.');
    } else if (e.type == DioExceptionType.connectionError ||
               e.type == DioExceptionType.unknown) {
      throw const OfflineFailure('You are offline or unable to reach the server.');
    } else {
      throw ServerFailure(e.message ?? 'Something went wrong');
    }
  } catch (e) {
    throw const ServerFailure('Unexpected error occurred.');
  }
```

---

## Conclusion

This Product Listing App provides a smooth user experience by caching product data locally with Hive and fetching fresh data from the DummyJSON API. The app also handles offline scenarios gracefully and allows users to search and sort the product list based on different criteria. The app uses `flutter_bloc` for state management and follows clean architecture principles to keep the codebase organized and maintainable.


## Screenshots

<p align="center">
  <img src="https://github.com/user-attachments/assets/f5f209b2-9271-4530-968f-a5664a717d4b" alt="Screenshot 2025-04-22 165953" />
</p>
<p align="center"><i>Caption for Screenshot 1: This is home page showing all the products</i></p>
<br>

<p align="center">
  <img src="https://github.com/user-attachments/assets/71750f3b-e5ab-462d-a797-405678b5edb3" alt="Screenshot 2025-04-22 170051" />
</p>
<p align="center"><i>Caption for Screenshot 2: The search results page showing the products based on the search query.</i></p>
<br>

<p align="center">
  <img src="https://github.com/user-attachments/assets/59b069fa-2d2a-4e0c-8a9b-fa9976e2d69e" alt="Screenshot 2025-04-22 170033" />
</p>
<p align="center"><i>Caption for Screenshot 3: The sorting options allowing users to sort products by different criteria.</i></p>
<br>

<p align="center">
  <img src="https://github.com/user-attachments/assets/b7d5605e-6ca3-4e91-bf66-dba4fd034c14" alt="Screenshot 2025-04-22 170122" />
</p>
<p align="center"><i>Caption for Screenshot 4: The products showing after sorting based on low to high price .</i></p>




