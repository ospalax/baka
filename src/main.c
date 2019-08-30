/*
 *
 * Copyright (2019) Petr Ospalý <petr@ospalax.cz>
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/.
 *
 */

#include <stdio.h>
#include <stdlib.h>
#include <ncurses.h>

#include "include/baka.h"
#include "include/screen.h"
#include "include/helloworld.h"

int main(int argc, char* argv[])
{
    // helloworld demo
    T_helloworld hello;

    helloworld_init(&hello);
    hello.border = TRUE;
    hello.border_color = BLUE;
    hello.text_color = RED;
    hello.bg_color = BLACK;
    hello.caption = "(n)curses styled Hello World!";

    // initialize screen
    T_screen screen;

    screen_init(&screen);
    screen.owner = (void*)&hello;
    screen.draw = (void (*)(void*))helloworld;

    // run main loop
    // TODO: this is a fake no-loop
    main_loop(&screen);

    return EXIT_SUCCESS;
}

// last line

