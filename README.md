# RADIUS CHALLENGE

## Architecture used
MVVM - Very familiar with this architecture. The package structure is easy to read & navigate.
.....

## Network Service
-> Network service written using URLSession, Swift Concurrency & Result Type.
-> Network service extends NetworkServiceProtocol and hence can be used to write Mock tests
-> Network service function 'sendRequest' accepts "generic" model and returns ResultType with 'generic success' and 'NetworkError error'
-> Codable model created to decode the JSON response

## Swift Concurrency
Used newly introduced native swift concurrency to manage asynchronous tasks instead of completion handlers.
Swift concurrency ....

## Unit Test
-> Added unit test cases for view model to test the exclusion rules and few other tests related to datasource counts
-> Created mock json and mock network service classes

## Utilities
-> Includes few helper methods and extensions

## ThirdParty
No third party libraries used in this project
