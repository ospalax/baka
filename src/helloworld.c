/*
 *
 * Copyright (2019) Petr Ospalý <petr@ospalax.cz>
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/.
 *
 */


#include "include/helloworld.h"


/* Header section */

#include <stdio.h>
#include <stdlib.h>
#include <curses.h>


/* Code section */

void helloworld(void)
{
    initscr();
    box(stdscr, '*', '*');
    addstr(" (n)curses style Hello World!");
    refresh();
    getch();
    endwin();
}

// last line

