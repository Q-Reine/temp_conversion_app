## Temperature Converter App
A Flutter-based application that allows users to easily convert temperatures between Fahrenheit and Celsius. 
The app features a clean, responsive design that adapts to both portrait and landscape orientations. 
It provides a simple and intuitive interface, lets users select the conversion type, and includes 
a history feature to track past conversions.

## Features

1. Temperature Conversion: Easily convert between Fahrenheit and Celsius, and vice versa.

2. Real-Time Conversion History: Automatically track and view a list of all past conversions.

3. User-Friendly Interface: Clean, modern design with intuitive controls for entering temperatures and selecting conversion types.

4. Responsive Layout: Fully responsive UI that adapts seamlessly to both portrait and landscape orientations.

5. Input Validation & Error Handling: Ensures accurate input and provides feedback for invalid entries.

6. Custom UI Components: Styled buttons, text fields, and UI elements to enhance the overall user experience.

7. Bottom Navigation Bar: Included as a placeholder for future feature expansions or navigation actions.


## Installation

1. Ensure you have Flutter installed on your machine
2. Clone the repository
3. Navigate to the project directory: cd temp-conversion-app 
4. Run the app: flutter run

## Structure

1. lib/ │ ├── main.dart # Main screen that serves as the app's entry point, managing its state and overall layout. 
2. assets/ └── images/ └── circle.png # Images used in the navigation bar(bottom).

## Conversion Formulas
Fahrenheit to Celsius: °C = (°F - 32) × 5/9
Celsius to Fahrenheit: °F = °C × 9/5 + 32