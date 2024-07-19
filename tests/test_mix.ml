open CamlSDL2_mixer
let () =
  Mix.init [];
  Mix.open_audio
    ~frequency:Mix.Default.frequency
    ~audio_format:Mix.Default.audio_format
    ~channels:2
    ~chunk_size:Mix.Default.chunk_size;
  (* chunk tests *)
  let sample = Mix.load_wav "sample.wav" in
  Mix.play_channel ~channel:(-1) ~chunk:sample ~loops:0;
  Unix.sleep 1;
  Mix.play_channel ~channel:(-1) ~chunk:sample ~loops:0;
  Unix.sleep 5;
  Mix.free_chunk sample;

  (* music tests *)
  if Mix.playing_music () then
    print_endline "playing mus before"
  else
    print_endline "not playing mus before";

  let music = Mix.load_mus "sample.wav" in
  Mix.play_music music ~loop:0;

  if Mix.playing_music () then
    print_endline "playing mus in"
  else
    print_endline "not playing mus in";

  Unix.sleep 5;

  if Mix.playing_music () then
    print_endline "playing mus after"
  else
    print_endline "not playing mus after";

  Mix.free_music music;
  Mix.close_audio ();
  Mix.quit ()
;;
