open CamlSDL2

(* general *)

module InitFlags = struct
  type t =
    [ `MIX_INIT_FLAC
    | `MIX_INIT_MOD
    | `MIX_INIT_MP3
    | `MIX_INIT_OGG
    ]

  let test () = print_endline "hello"
end

module Default = struct
  let frequency = 22050
  let audio_format = Sdl.AudioFormat.AUDIO_S16
  let chunk_size = 2048
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

(* samples *)

module Chunk = struct
  type t
end

external load_wav : string -> Chunk.t = "caml_Mix_LoadWAV"
external free_chunk : Chunk.t -> unit = "caml_Mix_FreeChunk"

(* channels *)

external play_channel_
  :  channel:int
  -> chunk:Chunk.t
  -> loops:int
  -> int
  = "caml_Mix_PlayChannel"

let play_channel ~channel ~chunk ~loops =
  let _ = play_channel_ ~channel ~chunk ~loops in ()

external fade_out_channel_
  :  channel:int
  -> ms:int
  -> int
  = "caml_Mix_FadeOutChannel"

let fade_out_channel ~channel ~ms =
  let _ = fade_out_channel_ ~channel ~ms in ()

(* music *)

module Music = struct type t end
module FadingMusic = struct type t = NO_FADING | FADING_OUT | FADING_IN end

external load_mus : string -> Music.t = "caml_Mix_LoadMUS"
external free_music : Music.t -> unit = "caml_Mix_FreeMusic"
external play_music : Music.t -> loop:int -> unit = "caml_Mix_PlayMusic"
external fade_out_music : ms:int -> unit = "caml_Mix_FadeOutMusic"
external halt_music : unit -> unit = "caml_Mix_HaltMusic"
external fading_music : unit -> FadingMusic.t = "caml_Mix_FadingMusic"
external playing_music : unit -> bool = "caml_Mix_PlayingMusic"
external rewind_music : unit -> unit = "caml_Mix_RewindMusic"
external fade_in_music : Music.t -> ms:int -> loops:int -> unit = "caml_Mix_FadeInMusic"
