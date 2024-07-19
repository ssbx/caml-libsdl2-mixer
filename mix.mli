open CamlSDL2

(** Ocaml binding to libsdl2 mixer.  See
    {:https://www.libsdl.org/projects/old/SDL_mixer/docs/SDL_mixer_frame.html}
    for the documentation *)

(** {1:gen General} *)

module InitFlags : sig
  type t =
    [ `MIX_INIT_FLAC
    | `MIX_INIT_MOD
    | `MIX_INIT_MP3
    | `MIX_INIT_OGG
    ]

  val test : unit -> unit
end

module Default : sig
  val frequency : int
  val audio_format : Sdl.AudioFormat.t
  val chunk_size : int
end

external init : InitFlags.t list -> unit = "caml_Mix_Init"
external quit : unit -> unit = "caml_Mix_Quit"

external open_audio
  :  frequency:int
  -> audio_format:Sdl.AudioFormat.t
  -> channels:int
  -> chunk_size:int
  -> unit
  = "caml_Mix_OpenAudio"

external close_audio : unit -> unit = "caml_Mix_CloseAudio"
external get_error : unit -> string = "caml_Mix_GetError"

(** {1:samples Samples} *)

module Chunk : sig
  type t
end

external load_wav : string -> Chunk.t = "caml_Mix_LoadWAV"
external free_chunk : Chunk.t -> unit = "caml_Mix_FreeChunk"

(** {1:ch Channels} *)

external play_channel_
  :  channel:int
  -> chunk:Chunk.t
  -> loops:int
  -> int
  = "caml_Mix_PlayChannel"

val play_channel
  :  channel:int
  -> chunk:Chunk.t
  -> loops:int
  -> unit

external fade_out_channel_
  :  channel:int
  -> ms:int
  -> int
  = "caml_Mix_FadeOutChannel"

val fade_out_channel : channel:int -> ms:int -> unit

(** {1:mus Music} *)

module Music : sig type t end
module FadingMusic : sig type t = NO_FADING | FADING_OUT | FADING_IN end

external load_mus : string -> Music.t = "caml_Mix_LoadMUS"
external free_music : Music.t -> unit = "caml_Mix_FreeMusic"
external play_music : Music.t -> loop:int -> unit = "caml_Mix_PlayMusic"
external fade_out_music : ms:int -> unit = "caml_Mix_FadeOutMusic"
external halt_music : unit -> unit = "caml_Mix_HaltMusic"
external fading_music : unit -> FadingMusic.t = "caml_Mix_FadingMusic"
external playing_music : unit -> bool = "caml_Mix_PlayingMusic"
external rewind_music : unit -> unit = "caml_Mix_RewindMusic"
external fade_in_music : Music.t -> ms:int -> loops:int -> unit = "caml_Mix_FadeInMusic"
