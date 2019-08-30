/*
 *
 * Copyright (2019) Petr Ospalý <petr@ospalax.cz>
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/.
 *
 */


#include "include/baka.h"


/* Header section */

#include <stdio.h>
#include <stdlib.h>
#include <ncurses.h>


/* Code section */

// TODO: THIS IS A STUB - for PoC purposes only
void main_loop(T_screen *screen)
{
    screen_create(screen);
    screen_refresh(screen);
    noecho();
    getch();
    screen_destroy(screen);
}

// last line

