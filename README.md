# CityFinder
## Description
Simple iPhone App to show list of Cities from a local JSON.

## Version Support
* iOS 12.0 and above

## Features

1. Cities List Screen
 * Displays list of Cities in a list view in Sorted Order
 * Displays CityName, Country Name as Title of City Cell
 * Displays Latitude and Longitude as SubTitle of City Cell
 * Search feature to filter Cities based on the text entered.

2. Details Screen :
 * Displays Map of the City
 
## App Architecture
MVVM Architecture

## Data Structure
Trie Structure is used to save the Cities after Parsing. This helps in fast run time search. The time complexity of searching in a TRIE is O(k) where k is the length of the string to be searched. This makes it faster than Linear Search

## Tests
Test Cases are added for the logical parts which includes:
* Filter/Search feature to test based on valid string, invalid string entered
* Parsing of JSON Response

 ## Dependencies
 There are no external dependencies to the project.

Note - Initial Data loading time of app is more as it takes time to parse huge json(with more then 2 lakh entries) and inserting the same data in Trie
