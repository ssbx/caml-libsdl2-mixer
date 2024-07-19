#define CAML_NAME_SPACE
#include <caml/mlvalues.h>
#include <caml/memory.h>
#include <caml/alloc.h>
#include <caml/fail.h>

#include <SDL_mixer.h>
#include "camlsdl2/audio_stub.h"
#include "camlsdl2_mixer/mix_stub.h"

const int caml_mix_fading_table[] = {
    MIX_NO_FADING,
    MIX_FADING_OUT,
    MIX_FADING_IN
};

value
Val_Mix_fading_t(int mix_fading)
{
    switch (mix_fading) {
        case MIX_NO_FADING:  return Val_int(0);
        case MIX_FADING_OUT: return Val_int(1);
        case MIX_FADING_IN:  return Val_int(2);
    }
    caml_failwith("Val_Mix_fading_t");
}

static Uint32
Mix_InitFlags_val(value flag_list)
{
    Uint32 ret = 0x00000000;
    while (flag_list != Val_emptylist) {
        value flag = Field(flag_list, 0);
        if (flag == caml_hash_variant("MIX_INIT_FLAC"))
            ret |= MIX_INIT_FLAC;
        else if (flag == caml_hash_variant("MIX_INIT_MOD"))
            ret |= MIX_INIT_MOD;
        else if (flag == caml_hash_variant("MIX_INIT_MP3"))
            ret |= MIX_INIT_MP3;
        else if (flag == caml_hash_variant("MIX_INIT_OGG"))
            ret |= MIX_INIT_OGG;
        flag_list = Field(flag_list, 1);
    }
    return ret;
}

CAMLprim value
caml_Mix_Init(value flag_list)
{
    CAMLparam1(flag_list);
    CAMLlocal1(ret);
    Uint32 flags = Mix_InitFlags_val(flag_list);
    Uint32 ret_flags = Mix_Init(flags);

    if (flags != ret_flags)
        caml_failwith("caml_Mix_Init");

    CAMLreturn(Val_unit);
}

CAMLprim value
caml_Mix_Quit(value unit)
{
    CAMLparam0();
    Mix_Quit();
    CAMLreturn(Val_unit);
}

CAMLprim value
caml_Mix_OpenAudio(
    value frequency,
    value format,
    value channels,
    value chunksize)
{
    CAMLparam4(frequency,format,channels,chunksize);

    int r = Mix_OpenAudio(
        Int_val(frequency),
        SDL_AudioFormat_val(format),
        Int_val(channels),
        Int_val(chunksize));
    if (r == -1)
        caml_failwith("caml_Mix_OpenAudio");

    CAMLreturn(Val_unit);
}

CAMLprim value
caml_Mix_CloseAudio(value unit)
{
    CAMLparam0();
    Mix_CloseAudio();
    CAMLreturn(Val_unit);
}

CAMLprim value
caml_Mix_GetError(value unit)
{
    CAMLparam0();
    const char *err = Mix_GetError();
    CAMLreturn(caml_copy_string(err));
}

CAMLprim value
caml_Mix_LoadWAV(value filename)
{
    CAMLparam1(filename);
    Mix_Chunk * chunk = Mix_LoadWAV(String_val(filename));
    if (!chunk)
        caml_failwith("caml_Mix_LoadWAV");
    CAMLreturn(Val_Mix_Chunk(chunk));
}

CAMLprim value
caml_Mix_FreeChunk(value chunk)
{
    CAMLparam1(chunk);
    Mix_FreeChunk(Mix_Chunk_val(chunk));
    CAMLreturn(Val_unit);
}

CAMLprim value
caml_Mix_PlayChannel(value channel, value chunk, value loops)
{
    CAMLparam3(channel,chunk,loops);
    int ret = Mix_PlayChannel(
        Int_val(channel),
        Mix_Chunk_val(chunk),
        Int_val(loops));
    if (ret == -1) caml_failwith("caml_Mix_PlayChannel");
    CAMLreturn(Val_int(ret));
}

CAMLprim value
caml_Mix_LoadMUS(value filename)
{
    CAMLparam1(filename);
    Mix_Music * music = Mix_LoadMUS(String_val(filename));
    if (!music)
        caml_failwith("caml_Mix_LoadMUS");
    CAMLreturn(Val_Mix_Music(music));
}

CAMLprim value
caml_Mix_FreeMusic(value music)
{
    CAMLparam1(music);
    Mix_FreeMusic(Mix_Music_val(music));
    CAMLreturn(Val_unit);
}

CAMLprim value
caml_Mix_PlayMusic(value music, value loop)
{
    CAMLparam2(music, loop);
    int ret = Mix_PlayMusic(Mix_Music_val(music), Int_val(loop));
    if (ret == -1)
        caml_failwith("caml_Mix_PlayMusic");
    CAMLreturn(Val_unit);
}

CAMLprim value
caml_Mix_FadeOutMusic(value ms)
{
    CAMLparam1(ms);
    int ret = Mix_FadeOutMusic(Int_val(ms));
    if (ret == 0)
        caml_failwith("caml_Mix_FadeOutMusic");
    CAMLreturn(Val_unit);
}

CAMLprim value
caml_Mix_FadingMusic(value unit)
{
    CAMLparam1(unit);
    int ret = Mix_FadingMusic();
    CAMLreturn(Val_Mix_fading_t(ret));
}

CAMLprim value
caml_Mix_HaltMusic(value unit)
{
    CAMLparam1(unit);
    Mix_HaltMusic();
    CAMLreturn(Val_unit);
}

CAMLprim value
caml_Mix_PlayingMusic(value unit)
{
    CAMLparam1(unit);
    int ret = Mix_PlayingMusic();
    CAMLreturn(ret == 1 ? Val_true : Val_false);
}

CAMLprim value
caml_Mix_RewindMusic(value unit)
{
    CAMLparam1(unit);
    Mix_PlayingMusic();
    CAMLreturn(Val_unit);
}

CAMLprim value
caml_Mix_FadeInMusic(value music, value ms, value loop)
{
    CAMLparam3(music, ms, loop);
    int ret = Mix_FadeInMusic(Mix_Music_val(music), Int_val(loop), Int_val(ms));
    if (ret == -1)
        caml_failwith("caml_Mix_FadeInMusic");

    CAMLreturn(Val_unit);
}





/* vim: set ts=4 sw=4 et: */
