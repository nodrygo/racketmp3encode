# racketmp3encode

## <font color="blue"> Goal  </font> 
stupid and simple racket code to encode mp3 with **mplayer** and **lame**
this code to convert *.wav .ogg .wma* from source dir to dest in *.mp3*

## <font color="blue"> Needs  </font>  
[<font color="green"> Racket >= 6.0 </font>](http://racket-lang.org/)   
[<font color="green"> Rackjure </font>](https://github.com/greghendershott/rackjureinstalled) with `cmd line raco pkg install rackjure` (or use DrRacket graphical installer)    
tested on Linux with **mplayer** and **lame** installed (don't know for windows)

## <font color="blue">Use Case</font>
choose for source dir and target *(default is ".")*     
input dir recursive  true/false *(defaut false)*    
- get help 
    `racket convertmp3.rkt -h`    
- encode  recursive from to
    `racket convertmps3.rkt -r -i myinputdir  -o ~/test/mp3` 