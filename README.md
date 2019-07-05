# Baka

## Objective
### `Bachelor thesis/project (Czech: Bakalářská práce)`

## Title
### `RAD tool for text user interface`

## Author
### `Petr Ospalý`

## Status

**Version:** `POC`

Proof of Concept - early stage of development.


## Introduction

### Text user interface

[Text User Interface](https://en.wikipedia.org/wiki/Text-based_user_interface) (TUI) does not have a notion of [**pixel**](https://en.wikipedia.org/wiki/Pixel) as that is the basic element in a graphical environment (GUI). Pixel's role in the text based environment is taken by a **character** and the whole screen is formed by rows and columns of these characters.


There is a nice paragraph on wikipedia in the article about [`curses`](https://en.wikipedia.org/wiki/Curses_(programming_library)):

> Curses-based programs often have a user interface that resembles a traditional graphical user interface, including 'widgets' such as text boxes and scrollable lists, rather than the command line interface (CLI) most commonly found on text-only devices. This can make them more user-friendly than a CLI-based program, while still being able to run on text-only devices. Curses-based software can also have a lighter resource footprint and operate on a wider range of systems (both in terms of hardware and software) than their GUI-based counterparts. This includes old pre-1990 machines along with modern embedded systems using text-only displays.


### RAD

**Baka** is intended as a `RAD` ([Rapid Application Development](https://en.wikipedia.org/wiki/Rapid_application_development)) tool(chain) for rapid development of applications in text based environments (here it means terminals). Very much in line with the pioneer of such tools - [Borland Delphi](https://en.wikipedia.org/wiki/Delphi_(IDE)#Borland_Delphi) - though my ambitions are much lower (and capabilities of text interface much lesser).

The fundamental component of a RAD tool is the **Designer** - where all the *rapid* development take the place (mostly). Without it the user (programmer) must learn API of whatever widget toolkit he chose to use. The purpose of any RAD tool and especially of the designer is to provide [`WYSIWYG`](https://en.wikipedia.org/wiki/WYSIWYG) features where the user intuitively design his application interface without any coding and all implementation details are hidden from him.

After the design time the user can hook up pieces of code on top of these widgets to give them some functionality. To achieve that: the RAD tool should provide a way of source code organization and automatic code creation - e.g. procedure/function templates (with auto-generated signature but empty body). We can call this the **scaffolding**.

Arguably the most popular way how to combine such scaffolding with the design element is by means of events (actions acted upon the widgets - mouse click, pressing the keys) and handlers (procedures/functions dealing with the events). Widgets have **properties** and handlers manipulate with the widgets through these properties. But only until they are invoked (triggered) by the relevant event, not sooner (usually).


### Runtime and concurrency

So the last piece of this RAD system is a **runtime**. The runtime can be implemented as an event-loop or some concurrency system to provide the *reactivity* for the applications. If no such runtime would be present then the application would be strictly synchronous and appeared "frozen" most of the time. In a system without asynchronous runtime any invoked (triggered) handler would halt the rest of the application until it finishes its job and in the meantime no other event could be registered.

Try to think just a trivial scrolling feature - in a synchronous system (without any event-loop or concurrency) the scrolled portion of the application (text, form...) would not be scrolled in the *"realtime"* (*real* realtime systems are actually a whole another story...) - but instead it would have to wait until you finish the movement and release the scroll-bar. Only then a new event would be triggered to redraw the scrolled (and changed) portion of the application - as you can imagine that is very *unfriendly* user experience.


## Description

As was stated above - **baka** project tries to implement RAD tool for a text based interface - namely for the unix-like terminals with [`(n)curses`](https://en.wikipedia.org/wiki/Ncurses) support.

`(n)curses` (meaning: *"New curses"*) is the most popular "`curses`" compatible library (at least on Linux) providing a programming API and abstractions over the many terminal implementations.

It is (**as of now**) the only serious dependency which this project has...this **may change** with possible integration of **Martin Sústrik**'s [`libdill`](http://libdill.org/) - the structured concurrency library. The same author also implemented golang-like concurrency in [`libmill`](http://libmill.org/).

### Technical stack

This project uses the following products to be build and for function:

    - Linux operating system
    - GNU C compiler or clang
    - C language + stdlib
    - git
    - ncurses
    - shell + terminal
    - (?) libdill

### Project structure

**Components:**

    - RAD Designer/IDE
    - Source code manager (scaffolding)
    - Runtime library (events handling)
    - Build toolchain

**Dependencies:**

    - (n)curses
    - libdill (?) (to replace my own event-loop implementation)


### Why C?

The programming language of choice for this project is the `C` - (`C99` to be exact).

Firstly `ncurses` and `libdill` are purely `C` libraries, so `C` language was a natural choice. Someone could argue that `C++` would be a better fit (*Object-Oriented language*, hello...).

`C++` also interfaces with `C` seamlessly and its compiler actually can compile `C` code without any hassle (many even prefer the `c++` compiler for `C` projects).

**So why not `C++` then?:**

- Mainly because I do not know it :)
- C++ is huge and it is growing every committee meeting...
- Every C++ programmer knows and uses only a subset of this beast (with their own flavor)
- And many of them program in the now frowned-upon obsoleted `C++98` version of the language
- Nowadays C++ looks very different than ten years ago (generics, templates and stuff)
- Bjarne Stroustrup (creator) said that he himself does not know all of C++ (from this [interview](http://www.stroustrup.com/japanese2010.pdf)):
> Even I can’t answer every question about C++ without reference to supporting material (e.g. my own books, online documentation, or the standard). I’m sure that if I tried to keep all of that information in my head, I’d become a worse programmer. What I do have is a far less detailed – arguably higher level – model of C++ in my head.

**So why C again?:**

- I know it :)
- C is a rock-solid and stable language - it looks much the same as it looked 20 years ago
- It is a small, elegant, practical and simple language
- The whole C can be covered in a 100 pages, probably much less - compare it to C++ heavy books
- You actually can write OOP styled code even in pure C (e.g. [`GObject`](https://en.wikipedia.org/wiki/GObject))
- These are written in C: Linux, compilers, shell, terminal emulator, sed, awk, grep (all of the old unix toolbox - [History of UNIX and the role of C](https://en.wikipedia.org/wiki/History_of_Unix#1970s)), ncurses, libdill etc. - why break the party?


## Why the name "baka"?

This project would not exist without [`(n)curses`](https://en.wikipedia.org/wiki/Ncurses) library, which is the successor of the original [`curses`](https://en.wikipedia.org/wiki/Curses_(programming_library)) library - and the word "curses" can mean magic spells or insults in English. Also there is the Czech term *"bakalářská práce"* for the *"bachelor thesis"* (notice the *baka* in the beginning) and Czech is my native language.

When you combine these two things with my healthy interest in Japan then you get: [baka](https://en.wikipedia.org/wiki/Baka_(Japanese_word)) a japanese insult meaning "fool" used so often in the anime.

And lastly...I am terrible at making up names...did you not notice my username (**ospalax**) - that has also a little bit convoluted history (unsurprisingly, my surname *Ospalý* plays a big role there...).


## Usage

**COMING SOON**

