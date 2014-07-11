#lang rackjure
#|
 Auth: nodrygo  (https://github.com/nodrygo)

 code to convert .wav .ogg .wma in .mp3
 needs:
   Racket >= 6.0 
   Rackjure  (installed with cmd line raco pkg install rackjure  or use graphical installer) 
   tested on Linux with 'mplayer' and 'lame' installed (don't know for windows)

choose for source dir and target (default ".") 
entry recursive or not 
usage:  racket convertmp3.rkt -h 

|#

(require racket/path)
(require racket/system)

(define (simplify f)
   ;remove track number and space and dot from begining of file name
  (let  ([m (regexp-match #rx"^[0-9. ]*(.*)" f)])
        (when m (list-ref  m 1 ))))

(define pdirin (make-parameter "."))
(define pdirout (make-parameter "."))
(define prec (make-parameter #f))

(define (main)
  (command-line
   #:help-labels  "set directory parameters" 
   #:once-each
   [("-i" "--input-dir")  dirin   "dir source (default .)" (pdirin dirin)]
   [("-o" "--output-dir") dirout  "dir target (default .)" (pdirout dirout)] 
   ["-r"  "follow recursive input-dir" (prec #t)]
   #:ps "

Racket >=6.0 code to Convert  .wma and .ogg in mp3 from a directory
use 'mplayer' and 'lame' so they must be installed
exemple:   racket convertmps3.rkt -r -i myinputdir  -o ~/test/mp3 
"
   )
    (for ([f ((if (prec) in-directory directory-list) (pdirin))])
      (when (member (filename-extension f) '(#"ogg" #"wma" #"wav" ))
         (make-directory* (pdirout))
         (let* ([oname  (path-replace-suffix(simplify(file-name-from-path f)) ".mp3")]
                [of     (path->string (build-path (pdirout) oname))]
                [tmp    (path->string(path-add-suffix f ".wav"))]
                [command (str "mplayer -ao pcm:file="  (~e tmp) " " (~e (path->string f))
                              "; lame -h " (~e tmp) " " (~e of))])
           ;(displayln command)
           (system command)
           (delete-file tmp)
   ))))

(main)