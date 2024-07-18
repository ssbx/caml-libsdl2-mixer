open CamlSDL2_mixer
let () =
  Mixer.init [];
  Mixer.open_audio
    ~frequency:Mixer.Default.frequency
    ~audio_format:Mixer.Default.audio_format
    ~channels:2
    ~chunk_size:Mixer.Default.chunk_size;
  (* chunk tests *)
  let sample = Mixer.load_wav "sample.wav" in
  Mixer.play_channel ~channel:(-1) ~chunk:sample ~loops:0;
  Unix.sleep 1;
  Mixer.play_channel ~channel:(-1) ~chunk:sample ~loops:0;
  Unix.sleep 5;
  Mixer.free_chunk sample;
  (* music tests *)
  let music = Mixer.load_mus "sample.wav" in
  Mixer.play_music music ~loop:0;
  Unix.sleep 5;
  Mixer.free_music music;
  Mixer.close_audio ();
  Mixer.quit ()
;;
