/*
 *
 * Copyright (2019) Petr Ospalý <petr@ospalax.cz>
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/.
 *
 */

#ifndef SAFEGUARD__HELLOWORLD_H_HEADER__
#define SAFEGUARD__HELLOWORLD_H_HEADER__
// do not put any code BEFORE these two lines

#include "screen.h"

typedef struct t_helloworld
{
    T_boolean border;
    T_boolean colors;
    T_color border_color;
    T_color text_color;
    T_color bg_color;
    char* caption;
} T_helloworld;

void helloworld_init(T_helloworld *self);
void helloworld(T_helloworld *self);

// do not put any code AFTER this line
#endif // SAFEGUARD__HELLOWORLD_H_HEADER__

