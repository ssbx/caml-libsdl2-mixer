#ifndef _CAML_SDL_MIXER_
#define _CAML_SDL_MIXER_

static value Val_Mix_Chunk(Mix_Chunk * p)
{
    return caml_copy_nativeint((intnat) p);
}

static Mix_Chunk * Mix_Chunk_val(value v)
{
    return (Mix_Chunk*) Nativeint_val(v);
}

static value Val_Mix_Music(Mix_Music * p)
{
    return caml_copy_nativeint((intnat) p);
}

static Mix_Music * Mix_Music_val(value v)
{
    return (Mix_Music*) Nativeint_val(v);
}


#endif /* _CAML_SDL_MIXER_ */


/* vim: set ts=4 sw=4 et: */
