/*
 *
 * Copyright (2019) Petr Ospalý <petr@ospalax.cz>
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/.
 *
 */

#ifndef SAFEGUARD__SCREEN_H_HEADER__
#define SAFEGUARD__SCREEN_H_HEADER__
// do not put any code BEFORE these two lines

typedef int T_boolean;

typedef enum t_color
{
    BLACK,
    RED,
    GREEN,
    YELLOW,
    BLUE,
    MAGENTA,
    CYAN,
    WHITE
} T_color;

typedef struct t_screen
{
    void* owner;
    void (*draw)(void *);
} T_screen;

void screen_init(T_screen *self);
void screen_create(T_screen *self);
void screen_destroy(T_screen *self);
void screen_refresh(T_screen *self);

void screen_draw(T_screen *self);

// do not put any code AFTER this line
#endif // SAFEGUARD__SCREEN_H_HEADER__

