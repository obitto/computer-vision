v = VideoWriter('MMG.mpg');
open(v);
writeVideo(v,output);
close(v);