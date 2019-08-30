/*
 *
 * Copyright (2019) Petr Ospalý <petr@ospalax.cz>
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/.
 *
 */


#include "include/screen.h"


/* Header section */

#include <stdio.h>
#include <stdlib.h>
#include <ncurses.h>
#include <string.h>


/* Code section */

void screen_create(T_screen *self)
{
    initscr();
}

void screen_destroy(T_screen *self)
{
    endwin();
}

void screen_refresh(T_screen *self)
{
    screen_draw(self);
    refresh();
}

void screen_init(T_screen *self)
{
    self->owner = NULL;
    self->draw = NULL;
}

//TODO: for PoC
void screen_draw(T_screen *self)
{
    self->draw(self->owner);
}

// last line

