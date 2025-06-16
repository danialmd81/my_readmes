# Convert Markdown to RTL HTML using Pandoc

Welcome to the **Pandoc Markdown to RTL HTML** guide! 🎉 This guide will show you how to transform your Markdown files into stunning right-to-left (RTL) HTML files using Pandoc. Let's get started!

## Prerequisites 🛠️

Before we dive in, make sure you have the following:

- [Pandoc](https://pandoc.org/installing.html) installed on your system.
- A Markdown file ready for conversion.

## Installation 🚀

### Windows 🪟

1. Grab the Pandoc installer from the [Pandoc releases page](https://github.com/jgm/pandoc/releases).
2. Run the installer and follow the on-screen instructions. Easy peasy!

### macOS 🍏

1. Install Pandoc using Homebrew:

  ```sh
  brew install pandoc
  ```

### Linux 🐧

Install Pandoc using your package manager. For example, on Debian-based systems:

```sh
sudo apt-get install pandoc
```

## Usage 🎨

To convert a Markdown file to an RTL HTML file, use this magical command:

```sh
pandoc input.md -o output.html  --embed-resources --standalone --css=rtl.css
```

### Explanation 📖

- `input.md`: Your Markdown masterpiece.
- `-o output.html`: The resulting HTML file.
- `--self-contained`: Ensures the HTML file is self-contained, embedding all resources.
- `--css=rtl.css`: Points to a CSS file with RTL styles.

### Additional Resources 📂

You can download `rtl.css` and `light-rtl.css` from this workspace to style your RTL HTML files. Once you have the CSS files, you can convert your Markdown to an RTL HTML file with the following command:

```sh
pandoc input.md -o output.html -c rtl.css --self-contained 
```

For a light-themed RTL HTML file, use:

```sh
pandoc input.md -o output.html -c light-rtl.css --self-contained 
```

## Conclusion 🎉

By following these steps, you can effortlessly convert a Markdown file to an RTL HTML file using Pandoc. Feel free to tweak the CSS to match your style. Happy converting! 🚀
