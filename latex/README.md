# LaTeX Notes

LaTeX is a high-quality typesetting system commonly used for creating documents with complex formatting, such as academic papers, books, and presentations.

## Key Features

- Precise control over document layout.
- Support for mathematical equations and symbols.
- Extensive package ecosystem for additional functionality.

## Document Class

The document class defines the overall layout and structure of your document. Commonly used classes include:

- `article`: For shorter documents like articles, essays, and reports.
- `report`: For longer documents like theses and technical reports.
- `book`: For books and similar long-form documents.
- `beamer`: For presentations.

### Example

```latex
\documentclass[12pt]{article}
```

You can specify options like font size (`10pt`, `11pt`, `12pt`) and paper size (`a4paper`, `letterpaper`).

## Title, Date, and Author

LaTeX allows you to define a title, date, and author for your document. These are displayed using the `\maketitle` command.

### Example

```latex
\documentclass[12pt]{article}

\title{My Document Title}
\author{Author Name}
\date{\today} % Automatically inserts the current date

\begin{document}
\maketitle
\end{document}
```

- `\title{}`: Sets the title of the document.
- `\author{}`: Sets the author(s) of the document.
- `\date{}`: Sets the date. Use `\today` for the current date or leave it empty for no date.

These commands help create a professional-looking title page or header for your document.

## Using the `xepersian` Package

The `xepersian` package is used for typesetting documents in Persian and other right-to-left (RTL) languages. It provides support for Persian fonts and proper text alignment.

### Example Usage

To use the `xepersian` package, include it in your LaTeX document's preamble:

```latex
\usepackage{xepersian}
```

### Requirements for Persian and English Text

When using the `xepersian` package to typeset documents with both Persian and English text, follow these steps:

1. **Set the Main Font**: Use `\settextfont` to define the font for Persian text.

   ```latex
   \settextfont{B Nazanin}
   ```

2. **Set the English Font**: Use `\setlatintextfont` to define the font for English text.

   ```latex
   \setlatintextfont{Times New Roman}
   ```

3. **Switch Between Languages**: Use `\lr{}` for English text within Persian text or `\rl{}` for Persian text within English text.

   ```latex
   متن فارسی \lr{English text here} ادامه متن فارسی
   ```

4. **Use XeLaTeX**: Ensure you compile your document with XeLaTeX, as `xepersian` relies on XeTeX for proper functionality.

### Example

```latex
\documentclass[12pt]{article}
\usepackage{xepersian}

\settextfont{B Nazanin}
\setlatintextfont{Times New Roman}

\begin{document}
متن فارسی \lr{This is English text.} ادامه متن فارسی.
\end{document}
```

These steps ensure proper rendering and alignment of both Persian and English text in your document.

## Alignment

### Left Alignment

Use the `flushleft` environment:

```latex
\begin{flushleft}
Your content aligned to the left.
\end{flushleft}
```

### Right Alignment

Use the `flushright` environment:

```latex
\begin{flushright}
Your content aligned to the right.
\end{flushright}
```

### Center Alignment

Use the `center` environment:

```latex
\begin{center}
Your content centered.
\end{center}
```

### Inline Left and Right Alignment

Use `\hfill` to push content to the left and right on the same line:

```latex
Left content \hfill Right content
```

This is useful for creating headers or footers with content aligned to opposite sides of the page.

### Custom Alignment in Tables

In LaTeX, you can customize the alignment of content in tables using column specifiers:

- `l`: Aligns content to the left.
- `c`: Centers content.
- `r`: Aligns content to the right.
- `p{width}`: Creates a column with a fixed width and allows text wrapping.

#### Example

```latex
\begin{tabular}{|l|c|r|}
\hline
Left-aligned & Centered & Right-aligned \\
\hline
Item 1 & Item 2 & Item 3 \\
\hline
\end{tabular}
```

For custom widths, use the `p{width}` specifier:

```latex
\begin{tabular}{|p{3cm}|p{5cm}|}
\hline
Column with fixed width & Another column with fixed width \\
\hline
\end{tabular}
```

This allows for precise control over table layout and alignment.

## Creating Tables

LaTeX provides the `tabular` environment for creating tables. It allows you to define rows and columns with various alignment options.

### Basic Example

```latex
\begin{tabular}{|l|c|r|}
\hline
Left-aligned & Centered & Right-aligned \\
\hline
Item 1 & Item 2 & Item 3 \\
\hline
\end{tabular}
```

### Key Features

- **Column Alignment**:
  - `l`: Aligns content to the left.
  - `c`: Centers content.
  - `r`: Aligns content to the right.
- **Borders**:
  - Use `|` to add vertical borders between columns.
  - Use `\hline` to add horizontal borders between rows.
- **Spacing**:
  - Add extra space between columns using `@{}` or `\hspace`.

### Example with Custom Widths

```latex
\begin{tabular}{|p{3cm}|p{5cm}|}
\hline
Column with fixed width & Another column with fixed width \\
\hline
This is a long text that wraps & Another long text that wraps \\
\hline
\end{tabular}
```

### Additional Resources

- [LaTeX Wikibook](https://en.wikibooks.org/wiki/LaTeX/Tables)
- [overleaf](https://www.overleaf.com/learn/latex/Tables)

### Notes

- Use the `array` package for advanced table formatting.
- For tables spanning multiple pages, use the `longtable` package.
- Combine with the `caption` package for adding captions to tables.

## Handling Overfull \hbox Warnings

An `Overfull \hbox` warning occurs when the content in a line is too wide to fit within the specified margins. This can result in text spilling into the margins.

### Common Solutions

1. **Manual Line Breaks**: Insert `\\` or `\newline` to break the line manually.

   ```latex
   This is a very long line of text that \\ needs to be broken manually.
   ```

2. **Hyphenation**: Use `\hyphenation{word}` to specify how words should be hyphenated.

   ```latex
   \hyphenation{ex-am-ple}
   ```

3. **Adjust Margins**: Use the `geometry` package to increase the margins.

   ```latex
   \usepackage[a4paper, margin=1in]{geometry}
   ```

4. **Flexible Spaces**: Use `\sloppy` or `\setlength{\emergencystretch}{3em}` to allow LaTeX to adjust spacing.

   ```latex
   \sloppy
   ```

5. **Resizing Tables**: If the issue is in a table, you can use the `\resizebox` command from the `graphicx` package to fit the table within the page width.

```latex
\usepackage{graphicx}

\begin{document}
\resizebox{\textwidth}{!}{%
\begin{tabular}{|l|c|r|}
\hline
Left-aligned & Centered & Right-aligned \\
\hline
Item 1 & Item 2 & Item 3 \\
\hline
\end{tabular}%
}
\end{document}
```

- `\textwidth`: Scales the table to fit the width of the page.
- `!`: Maintains the aspect ratio while resizing.

## Code Insertion Using `minted`

The `minted` package is a powerful tool for including syntax-highlighted code in LaTeX documents. It supports a wide range of programming languages and uses the Pygments library for syntax highlighting.

### Requirements

1. Install Python and the Pygments library.

   ```bash
   pip install Pygments
   ```

2. Compile your document with the `-shell-escape` flag to allow external commands.

### Example Usage

```latex
\documentclass[12pt]{article}
\usepackage{xcolor}
\usepackage{minted}

\begin{document}

Here is an example of Python code:

\begin{minted}{python}
def hello_world():
    print("Hello, World!")
\end{minted}

\end{document}
```

### Key Features

- **Language Support**: Specify the language in the `\begin{minted}{language}` block.
- **Line Numbers**: Add line numbers using the `linenos` option.

  ```latex
  \begin{minted}[linenos]{python}
  def hello_world():
      print("Hello, World!")
  \end{minted}
  ```

- **Custom Styles**: Customize the appearance of the code using Pygments styles.

### Notes

- Ensure you compile with `-shell-escape` to enable syntax highlighting.
- The `minted` package requires the `graphicx` package, which is usually included by default.

### Additional Resources

- [Pygments Documentation](https://pygments.org/)
- [minted Package Documentation](https://ctan.org/pkg/minted)

## Inserting Pictures

LaTeX allows you to include images in your documents using the `graphicx` package. This package provides commands for inserting and scaling images.

### Example Usage

```latex
\documentclass[12pt]{article}
\usepackage{graphicx}

\begin{document}

Here is an example of an image:

\includegraphics[width=\textwidth]{example-image}

\end{document}
```

### Key Features

- **File Path**: Replace `example-image` with the path to your image file (e.g., `images/picture.jpg`).
- **Scaling**: Use the `width` or `height` options to scale the image. For example:
  - `width=\textwidth`: Scales the image to the width of the text.
  - `height=5cm`: Sets the height of the image to 5 cm.
- **Positioning**: Use environments like `figure` for better control over image placement and captions.

### Example with Caption

```latex
\documentclass[12pt]{article}
\usepackage{graphicx}

\begin{document}

\begin{figure}[h]
\centering
\includegraphics[width=0.5\textwidth]{example-image}
\caption{This is an example caption.}
\label{fig:example}
\end{figure}

\end{document}
```

### Notes

- Supported image formats include `.png`, `.jpg`, and `.pdf`.
- Ensure the image file is in the same directory as your `.tex` file or provide the correct path.
- Use the `float` package for advanced positioning options.

### Additional Resources

- [LaTeX Project](https://www.latex-project.org/)
- [xepersian Documentation](https://ctan.org/pkg/xepersian)

## Custom Headers and Footers with `fancyhdr`

The `fancyhdr` package allows you to create custom headers and footers in your LaTeX documents. It provides flexibility to include text, page numbers, and other elements in the header and footer.

### Example Usage

```latex
\documentclass[12pt]{article}
\usepackage{fancyhdr}
\pagestyle{fancy}

\fancyhf{} % Clear all header and footer fields
\fancyhead[L]{Left Header} % Left-aligned header
\fancyhead[C]{Center Header} % Centered header
\fancyhead[R]{Right Header} % Right-aligned header
\fancyfoot[L]{Left Footer} % Left-aligned footer
\fancyfoot[C]{Page \thepage} % Centered footer with page number
\fancyfoot[R]{Right Footer} % Right-aligned footer

\begin{document}

\section*{Example Document}
This is an example document with custom headers and footers.

\newpage
This is the second page.

\end{document}
```

### Key Features

- **Header and Footer Fields**:
  - `L`: Left-aligned.
  - `C`: Centered.
  - `R`: Right-aligned.
- **Clearing Defaults**: Use `\fancyhf{}` to clear all default header and footer content.
- **Page Numbers**: Include page numbers using `\thepage`.

### Notes

- Use `\pagestyle{fancy}` to apply the custom header and footer style.
- Combine with the `geometry` package to adjust margins for better header and footer placement.
- Use `\thispagestyle{plain}` for pages (e.g., title pages) where you want to suppress custom headers and footers.

## Page Styles with `\pagestyle`

LaTeX provides predefined page styles that control the appearance of headers and footers. You can set a page style using the `\pagestyle` command.

### Predefined Page Styles

- `plain`: Displays only the page number in the footer.
- `empty`: No headers or footers.
- `headings`: Displays section titles in the header and page numbers.
- `myheadings`: Allows custom headers while displaying page numbers.

### Example: Using `plain`

```latex
\documentclass[12pt]{article}

\begin{document}
\pagestyle{plain}

This document uses the `plain` page style.

\newpage
This is the second page.
\end{document}
```

### Example: Custom Headers with `myheadings`

```latex
\documentclass[12pt]{article}

\begin{document}
\pagestyle{myheadings}
\markright{Custom Header Text}

This document uses the `myheadings` page style with a custom header.

\newpage
The custom header appears on this page as well.
\end{document}
```

### Notes

- Use `\thispagestyle{style}` to apply a specific style to a single page.
- Combine `\pagestyle` with the `fancyhdr` package for advanced header and footer customization.

## Defining Custom Commands with `\newcommand`

LaTeX allows you to define custom commands using the `\newcommand` command. This is useful for creating shortcuts for frequently used text or formatting.

### Syntax

```latex
\newcommand{\commandname}[num]{definition}
```

- `\commandname`: The name of the new command.
- `[num]`: (Optional) The number of arguments the command takes.
- `definition`: The content or behavior of the command.

### Example: Simple Command

```latex
\newcommand{\myname}{John Doe}

\begin{document}
Hello, my name is \myname.
\end{document}
```

### Example: Command with Arguments

```latex
\newcommand{\greet}[1]{Hello, #1!}

\begin{document}
\greet{Alice} % Outputs: Hello, Alice!
\greet{Bob}   % Outputs: Hello, Bob!
\end{document}
```

### Notes

- Use `\renewcommand` to redefine an existing command.
- Use `\providecommand` to define a command only if it is not already defined.
- Custom commands improve code readability and reduce repetition.

## Enumerated Lists with `enumerate`

The `enumerate` environment is used to create numbered lists in LaTeX. It allows customization of numbering styles and formats.

### Basic Example

```latex
\begin{enumerate}
    \item First item
    \item Second item
    \item Third item
\end{enumerate}
```

### Customizing Numbering

You can customize the numbering style using the `enumitem` package or by redefining the `\labelenumi` command.

#### Example: Using `enumitem`

```latex
\usepackage{enumitem}

\begin{document}
\begin{enumerate}[label=\alph*.]
    \item First item
    \item Second item
    \item Third item
\end{enumerate}
\end{document}
```

- `label=\alph*.`: Uses lowercase letters (a, b, c) followed by a period.
- Other options include:
  - `\arabic*.`: Numbers (1, 2, 3).
  - `\roman*.`: Lowercase Roman numerals (i, ii, iii).
  - `\Roman*.`: Uppercase Roman numerals (I, II, III).

#### Example: Redefining `\labelenumi`

```latex
\renewcommand{\labelenumi}{\Roman{enumi}.}

\begin{document}
\begin{enumerate}
    \item First item
    \item Second item
    \item Third item
\end{enumerate}
\end{document}
```

- `\Roman{enumi}`: Sets the numbering to uppercase Roman numerals.

### Nested Lists

You can create nested lists by using multiple `enumerate` environments.

```latex
\begin{enumerate}
    \item First item
    \begin{enumerate}
        \item Sub-item 1
        \item Sub-item 2
    \end{enumerate}
    \item Second item
\end{enumerate}
```

### Notes

- Use the `enumitem` package for advanced customization.
- Combine with the `itemize` environment for mixed list styles.
