---
title: Colors
dates: 2016
logo: /projects/colors/colors.svg
site: http://colors.graysonwright.com
source: https://github.com/graysonwright/colors
position: Side Project
teaser: To get more comfortable with ES6, I built a web interface for designing and downloading color scheme files for text editors.
---

### A Learning Tool

The main purpose of colors.graysonwright.com is to learn ES6,
the new Javascript standard.
I had used many different Javascript frameworks during my time at thoughtbot,
but I had never written object-oriented Javascript
with no frameworks layered on top.

As a toy project, I set out to build a friendly web interface
to [Chris Kempson's wonderful base16 command-line tool][base16].

### Implementation

The application uses ES6 classes to control the behavior of each UI element.
It uses a custom color picker built on HTML canvas,
and uses CSS Flexbox for the layout.

We use a clone of [base16-builder] on the server
to generate and serve colorscheme files based on the user's selection.

[base16]: http://chriskempson.com/projects/base16/
