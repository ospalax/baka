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
#include <ncurses.h>
#include <string.h>


/* Code section */

void helloworld_init(T_helloworld *self)
{
    self->border = FALSE;
    self->colors = FALSE;
    self->caption = "";
}

void helloworld(T_helloworld *self)
{
    if (has_colors())
        if (start_color() == OK)
            // set colors
            self->colors = TRUE;

    // border
    if (self->border)
    {
        attrset(A_NORMAL);
        if (self->colors)
        {
            init_pair(1, self->border_color, self->bg_color);
            attron(COLOR_PAIR(1));
        }
        box(stdscr,0,0);
        bkgd(COLOR_PAIR(1));
    }

    // caption
    attrset(A_NORMAL);
    if (self->colors)
    {
        init_pair(2, self->text_color, self->bg_color);
        attron(COLOR_PAIR(2));
    }

    // count the row,col position
    int row = LINES / 2, col = COLS / 2;
    col -= strlen(self->caption) / 2;
    // print the caption
    mvaddstr(row, col, self->caption);

    // cleanup just in case
    attrset(A_NORMAL);
}

// last line

