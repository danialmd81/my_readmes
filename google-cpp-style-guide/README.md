# Google C++ Style Guide

This repository contains my notes and examples following the Google C++ Style Guide.

## Overview

The Google C++ Style Guide is a set of guidelines for writing C++ code at Google. These guidelines help ensure consistency, readability, and maintainability across large C++ codebases.

## Summary

The Google C++ Style Guide provides a comprehensive set of rules and best practices for writing C++ code. It covers various aspects of coding, including naming conventions, formatting, comments, and more. The goal is to create a uniform codebase that is easy to read and maintain.

## Key Topics

- Naming Conventions
- Formatting
- Comments
- Header Files
- Scoping
- Classes
- Functions
- Other C++ Features

## Important Points

## Important Points

1. **Naming Conventions**: Use descriptive names for variables, functions, and classes. Follow camelCase for variables and functions, and PascalCase for class names.

    ```cpp
    int userAge; // camelCase for variables
    void calculateTotal(); // camelCase for functions
    class UserAccount; // PascalCase for class names
    ```

2. **Formatting**: Adhere to consistent indentation and spacing. Use 2 spaces for indentation and avoid tabs.

    ```cpp
    void exampleFunction() {
      int value = 10;
      if (value > 0) {
        value--;
      }
    }
    ```

3. **Comments**: Write clear and concise comments. Use `//` for single-line comments and `/* */` for multi-line comments.

    ```cpp
    // This is a single-line comment

    /*
     * This is a multi-line comment
     * explaining the following code block.
     */
    void exampleFunction() {
      // Initialize value
      int value = 10;
    }
    ```

4. **Header Files**: Use header guards to prevent multiple inclusions. Keep the interface in header files and implementation in source files.

    ```cpp
    // example.h
    #ifndef EXAMPLE_H
    #define EXAMPLE_H

    void exampleFunction();

    #endif // EXAMPLE_H

    // example.cpp
    #include "example.h"

    void exampleFunction() {
      // Implementation
    }
    ```

5. **Scoping**: Minimize the scope of variables. Use namespaces to avoid name conflicts.

    ```cpp
    namespace myNamespace {
      void exampleFunction() {
        int value = 10; // Minimized scope
      }
    }
    ```

6. **Classes**: Prefer composition over inheritance. Use initializer lists in constructors.

    ```cpp
    class Engine {
    public:
      Engine(int power) : power_(power) {}
    private:
      int power_;
    };

    class Car {
    public:
      Car(int power) : engine_(power) {}
    private:
      Engine engine_;
    };
    ```

7. **Functions**: Keep functions short and focused. Use const correctness and pass by reference where appropriate.

    ```cpp
    void printValue(const int& value) {
      std::cout << value << std::endl;
    }
    ```

8. **Other C++ Features**: Avoid using macros. Prefer modern C++ features like smart pointers and the STL.

    ```cpp
    #include <memory>
    #include <vector>

    void exampleFunction() {
      std::unique_ptr<int> ptr = std::make_unique<int>(10);
      std::vector<int> values = {1, 2, 3, 4, 5};
    }
    ```

## Purpose

This repository serves as:

1. A quick reference for Google C++ style conventions
2. Examples demonstrating proper implementation
3. Common pitfalls to avoid

## Resources

- [Official Google C++ Style Guide](https://google.github.io/styleguide/cppguide.html)
- Code examples in this repository
- Additional references and tools

## License

This repository is for educational purposes. All references to Google's C++ Style Guide belong to their respective owners.
