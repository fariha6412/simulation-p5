class SoundWaveForm{
  SoundFile sample;
  Waveform waveform;
  int samples = 100;
  
  SoundWaveForm(PApplet p, String fileName){
    sample = new SoundFile(p, fileName);
    sample.loop();
    waveform = new Waveform(p, samples);
    waveform.input(sample);
  }
  
  void play() {
    stroke(0);
    strokeWeight(2);
    noFill();
    waveform.analyze();
    
    beginShape();
    for(int i = 0; i < samples; i++){
      vertex(
        map(i, 0, samples, 100, width-40),
        map(waveform.data[i], -1, 1, 30, height)
      );
    }
    endShape();
  }
  void stopSound(){
    sample.stop();
  }
}
